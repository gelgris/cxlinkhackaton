FROM public.ecr.aws/lambda/python:3.9

COPY cl-ir-hackathon-empathy-start-training-handler.py requirements.txt ./

RUN python3.9 -m pip install -r requirements.txt -t .

# Command can be overwritten by providing a different command in the template directly.
CMD ["cl-ir-hackathon-empathy-start-training-handler.lambda_handler"]
