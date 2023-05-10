from __future__ import absolute_import

import boto3
import os
import sys
import logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)
logging.getLogger().addHandler(logging.StreamHandler(sys.stdout))

from botocore.exceptions import ClientError

def getForecastArn(aws_region, aws_account, aws_session_token, dataset_group_name):
  datasetGroupArn      = "arn:aws:forecast:" + aws_region + ':' + aws_account + ":dataset-group/" + dataset_group_name

  forecast_client = aws_session_token.client(
        service_name ='forecast',
        region_name = aws_region
  )

  # We select only the Forecasts tha use the DataSetGroup and in ACTIVE status
  # The filters supported in this moment are: DatasetGroupArn, PredictorArn and Status

  try:
    response = forecast_client.list_forecasts(
      Filters=[
      {
            'Key': 'DatasetGroupArn',
            'Value': datasetGroupArn,
            'Condition': 'IS'
      },
      {
            'Key': 'Status',
            'Value': 'ACTIVE',
            'Condition': 'IS'
      }
      ]
    )

    forecasts = response['Forecasts']

    # TODO: Implement pagination

    if (len(forecasts) == 0):
      logger.error("No forecasts available")
      exit(1)
    elif (len(forecasts) > 1):
      logger.error("Several forecasts")
      exit(1)
    else:
      return forecasts[0]['ForecastArn']
  except ClientError as e:
    if e.response['Error']['Code'] == 'InvalidInputException':
      logger.error(e)
    if e.response['Error']['Code'] == 'AccessDeniedException':
      logger.error(e.response)
      logger.error('Not enough permissions to get the Predictor ARN. Please, review the lambda role.')
      exit(1)
    if e.response['Error']['Code'] == 'InvalidNextTokenException':
      logger.error(e)
    logger.error(e)
  except Exception as e:
    logger.error('Error getting the Forecast')
    logger.error(e)
    response = {
      "statusCode": 500,
      "body": {
        "message": str(e),
      }
    }

def queryForecast(aws_region, aws_account, aws_session_token, dataset_group_name, startDate, endDate, workforceType):

  forecastArn = getForecastArn(aws_region, aws_account, aws_session_token, dataset_group_name)

  forecast_client = aws_session_token.client(
        service_name ='forecastquery',
        region_name = aws_region
  )

  try:
    response = forecast_client.query_forecast(
      ForecastArn  = forecastArn,
      StartDate    = startDate,
      EndDate      = endDate,
      Filters      = {
        "workforce_type" : workforceType
      }
    )
    return response['Forecast']['Predictions']
  except ClientError as e:
    if e.response['Error']['Code'] == 'InvalidInputException':
      logger.error(e)
    if e.response['Error']['Code'] == 'ResourceAlreadyExistsException':
      logger.error(e)
    if e.response['Error']['Code'] == 'ResourceNotFoundException':
      logger.error(e)
    if e.response['Error']['Code'] == 'ResourceInUseException':
      logger.error(e)
    if e.response['Error']['Code'] == 'LimitExceededException':
      logger.error(e)
    logger.error(e)
  except Exception as e:
    logger.error('Error getting Forecast')
    logger.error(e)
    response = {
      "statusCode": 500,
      "body": {
        "message": str(e),
      }
    }

def lambda_handler(event, context):

  aws_region             = os.environ['REGION']
  environment            = os.environ['ENVIRONMENT_TAG']
  owner                  = os.environ['OWNER_TAG']
  stage                  = os.environ['STAGE_TAG']
  project                = os.environ['PROJECT_TAG']
  prefix                 = os.environ['PREFIX']
  use_case               = os.environ['USE_CASE']
  test_mode              = os.environ['TEST_MODE']
  dataset_group_name     = os.environ['DATASET_GROUP_NAME']
  rawBucketName          = os.environ['RAW_BUCKET_NAME'] + '-' + environment

  default_profile = 'terraform-ht-ir-dev'

  logger.info('Event:')
  logger.info(event)

  logger.info("Getting Forecast")

  aws_session_token = boto3.session.Session()
  # TODO: Only for local testing porpouses
  #aws_session_token = boto3.session.Session(profile_name = default_profile)

  sts_client = aws_session_token.client(
        service_name ='sts',
        region_name = aws_region
  )

  aws_account = sts_client.get_caller_identity().get('Account')

  # Getting the Forecast

  startDate = event['startDate']
  endDate = event['endDate']
  workforceType = event['workforceType']

  inferences = queryForecast(aws_region, aws_account, aws_session_token, dataset_group_name, startDate, endDate, workforceType)
  logger.error(inferences)
  forecastValue = inferences['mean'][0]['Value']
  response = {
      "statusCode": 200,
      "body": {
        "ForecastValue": forecastValue,
      }
    }
  logger.info('Forecast Value:')
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
