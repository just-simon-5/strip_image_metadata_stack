"""
Lambda to strip JPG image exif metedata
"""
import logging
import os
import boto3
from PIL import Image
import io
import sys

LOGGER = logging.getLogger(__name__)
LOGGER.setLevel(logging.INFO)

BUCKET_A = 'BUCKET_A'
INPUT_JPG = "input_jpg"
S3 = 's3'
BODY = 'Body'
TMP = 'tmp'
JPG_SUFFIX = '.jpg'
BUCKET_B = 'BUCKET_B'

# Lambda provides these input and they can not easily be typed
def lambda_handler(
    event: dict,
    context: dict,
) -> None:
    """
    Process JPG images
    """
    LOGGER.info("Start of request")

    input_bucket = os.getenv(BUCKET_A)
    input_jpg = event.get(INPUT_JPG)

    s3 = boto3.client(S3)

    LOGGER.info("Started S3 download")
    image_response = s3.get_object(Bucket=input_bucket, Key=input_jpg)

    LOGGER.info("Completed S3 download")
    image_body = image_response[BODY].read()

    image = Image.open(io.BytesIO(image_body))
    image_data = list(image.getdata())
    image_without_exif = Image.new(image.mode, image.size)
    image_without_exif.putdata(image_data)
    image_without_exif_filename = f"{input_jpg.removesuffix(JPG_SUFFIX)}_without_exif.jpg"
    # save file to ephemeral storage
    image_without_exif_filepath = f"/{TMP}/{image_without_exif_filename}"
    image_without_exif.save(image_without_exif_filepath)
    image_without_exif.close()
    image.close()

    output_bucket = os.getenv(BUCKET_B)

    LOGGER.info("Started S3 upload")
    with open(image_without_exif_filepath, "rb") as output_body:
      s3.put_object(Bucket=output_bucket, Key=image_without_exif_filename, Body=output_body)

    LOGGER.info("Completed S3 upload")

    LOGGER.info("End of request")


if __name__ == "__main__":
    jpg_arg = sys.argv[1]
    lambda_handler({INPUT_JPG: jpg_arg}, None)
