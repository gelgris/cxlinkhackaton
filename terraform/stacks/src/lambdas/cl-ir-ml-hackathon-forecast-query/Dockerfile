FROM public.ecr.aws/lambda/python:3.9

COPY cl-ir-ml-hackathon-forecast-query-handler.py requirements.txt ./

RUN python3.9 -m pip install -r requirements.txt -t .

# Command can be overwritten by providing a different command in the template directly.
CMD ["cl-ir-ml-hackathon-forecast-query-handler.lambda_handler"]
