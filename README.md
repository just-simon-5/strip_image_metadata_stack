# strip\_image\_metadata\_stack

This repo contains terraform to deploy a lambda function which strips any exif metadata from JPG images.

<img src="assets/strip_image_metadata_architecture_diagram.jpg" height="65%" width="65%">

**Figure.** Strip Image Metadata Architecture Design

<br>

## Testing Lambda Execution Locally

To test the lambda locally, first the docker image must be built:
```sh
# command assumes you are in repository rootdir
docker build -t <IMAGE-NAME> -f docker/Dockerfile .
```

Start the lambda container with:
```sh
docker run \
    -e AWS_ACCESS_KEY_ID=<ACCESS-KEY> \
    -e AWS_SECRET_ACCESS_KEY=<SECRET-KEY> \
    -e AWS_SESSION_TOKEN=<SESSION-TOKEN> \
    -e BUCKET_A=<INPUT-BUCKET> \
    -e BUCKET_B=<OUTPUT-BUCKET> \
    --user root -v /tmp:/tmp -p 9000:8080 <IMAGE-NAME>
```
**Please Note:** You have to specify root user when testing locally as otherwise will receive the error:
```sh
docker: Error response from daemon: unable to find user appuser: no matching entries in passwd file
```
This is due to the fact the lambda creates its own user and so when running locally that user isn't created and so Docker cannot find the password to use that user.

Send a request to the lambda container from a separate terminal window:
```sh
curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" \
  -d '{"input_jpg": "<INPUT-JPG-NAME>"}'
```
