FROM public.ecr.aws/lambda/python:3.11

COPY src ${LAMBDA_TASK_ROOT}

COPY docker/Pipfile ${LAMBDA_TASK_ROOT}

COPY docker/Pipfile.lock ${LAMBDA_TASK_ROOT}

RUN pip3 install --no-cache-dir pipenv

RUN pipenv install --system --deploy

# lambda creates its own user when it deploys the image so we don't need to create a working user
USER appuser

CMD [ "strip_image_metadata.lambda_handler" ]
