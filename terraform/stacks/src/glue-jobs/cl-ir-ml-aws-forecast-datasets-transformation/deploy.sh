#!/bin/bash

ENVIRONMENT="dev"
PROFILE="terraform-ml-${ENVIRONMENT}"
ACCOUNT="742189430206"
REGION="eu-west-1"

S3_GLUE_BUCKET="cl-ir-ml-hackathon-ea-glue-forecast-bucket-${ENVIRONMENT}"
USE_CASE="work-force"
GLUE_JOB="cl-ir-ml-hackathon-ea-datasets-transformation-${ENVIRONMENT}"

SCRIPT_BASE_PATH=./
aws s3 sync ${SCRIPT_BASE_PATH} s3://cl-ir-ml-hackathon-ea-glue-forecast-bucket-dev/742189430206/eu-west-1/aws-forecast/work-force/etls/gluejobs/cl-ir-ml-hackathon-ea-datasets-transformation/ --profile ${PROFILE}
#aws s3 sync ${SCRIPT_BASE_PATH} s3://${S3_GLUE_BUCKET}/${ACCOUNT}/${REGION}/aws-forecast/${USE_CASE}/etls/gluejobs/${GLUE_JOB}/ --profile ${PROFILE}

