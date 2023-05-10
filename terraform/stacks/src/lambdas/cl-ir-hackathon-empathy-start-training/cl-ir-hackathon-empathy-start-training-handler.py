from __future__ import absolute_import

import boto3
import os
import sys
import logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)
from botocore.exceptions import ClientError

def start_pipeline(aws_region, aws_account, aws_session_token, environment, codepipelineName):
  codepipeline_client = aws_session_token.client(
        service_name ='codepipeline',
        region_name = aws_region
  )

  try:
    response = codepipeline_client.start_pipeline_execution(
      name = codepipelineName
    )
    logger.info(response)
    return response['pipelineExecutionId']
  except ClientError as e:
    if e.response['Error']['Code'] == 'AccessDeniedException':
      logger.error('Not enough permission to Start the State Machine')
    if e.response['Error']['Code'] == 'ValidationException':
      logger.error('Execution Parameters not Valid')
    if e.response['Error']['Code'] == 'ConflictException':
      logger.error('Conflict Exception')
    if e.response['Error']['Code'] == 'PipelineNotFoundException':
      logger.error('This CodePipeline does not Exist')
    else:
      logger.error(e)

def lambda_handler(event, context):

  aws_region             = os.environ['REGION']
  environment            = os.environ['ENVIRONMENT_TAG']
  codepipelineName       = os.environ['CODEPIPELINE_NAME']
  owner                  = os.environ['OWNER_TAG']
  stage                  = os.environ['STAGE_TAG']
  project                = os.environ['PROJECT_TAG']
  prefix                 = os.environ['PREFIX']
  use_case               = os.environ['USE_CASE']

  default_profile        = 'terraform-ht-ir-dev'

  logger.info('Event:')
  logger.info(event)

  logger.info("Starting the Forecast CodePipeline")

  aws_session_token = boto3.session.Session()
  sts_client = aws_session_token.client(
        service_name ='sts',
        region_name = aws_region
  )

  aws_session_token = boto3.session.Session()

  # TODO: Only for local testing porpouses
  # aws_session_token = boto3.session.Session(profile_name = default_profile)
  aws_account = sts_client.get_caller_identity().get('Account')

  codepipelineExecutionId = start_pipeline(aws_region, aws_account, aws_session_token, environment, codepipelineName)
  response = {
      "body": {
        "codepipelineExecutionId": codepipelineExecutionId
      }
  }
  logger.info(response)
  return(response)

# We define this code only for local testing. This code will not
# reached in the actual lambda execution.

def main() -> int:

  event = {}
  context = {}

  lambda_handler(event, context)

if __name__ == '__main__':
    sys.exit(main())
