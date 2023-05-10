#!/bin/bash

# Ref: https://github.com/mathspace/terraform-aws-ecr-docker-image
#
# Builds a Docker image and pushes to an AWS ECR repository
#
# Usage:
#
#
# Acquire an AWS session token
#
# TODO: Check if the lambda function is on creating state before push
# state: 'Pending'. StateReasonCode: 'Creating 

removeLambda(){
  aws lambda delete-function --function-name ${lambda_name}-${environment} --profile ${profile}
}

checkDockerEngine() {
  echo "Check if the Docker Engine is Running"
}

checkLambdaState() {
  LAMBDA_STATE=$(aws lambda get-function --function-name ${lambda_name}-${environment} --profile ${profile}|jq .Configuration.State|tr -d '"')

  if [ -z $LAMBDA_STATE ]
  then
    echo "Lambda Function does not exist"
    return
  fi

  time=0
  while [ "${LAMBDA_STATE}" != "Active" ] && [ "${time}" -lt "${MAX_TIMEOUT}" ]
  do
    echo "Lambda Function in $LAMBDA_STATE state"
    echo "Waiting for Active state.."
    sleep 5
    ((time=time+5))
  done

  if [ "${time}" -ge "${MAX_TIMEOUT}" ]
  then
    echo "Timeout exedeed, removing tha lambda function"
    removeLambda
  fi
}

checkECRImage() {
  IMAGE_STATUS="$(aws ecr describe-images --repository-name ${lambda_name}-lambda-${environment} --image-ids imageTag=latest --profile ${profile} | jq .imageDetails[].imageScanStatus.status | tr -d '"')"

  while [ $IMAGE_STATUS != "COMPLETE" ]
  do
    echo "Uploading ECR Image..."
    echo "Image in $IMAGE_STATUS status"
    IMAGE_STATUS="$(aws ecr describe-images --repository-name ${lambda_name}-lambda-${environment} --image-ids imageTag=latest --profile ${profile} | jq .imageDetails[].imageScanStatus.status | tr -d '"')"
    sleep 5
  done
  # TODO: We need a more deterministic condition
  sleep 5
}

build() {

 docker logout ${ECR_URL}
 echo "Log in in the ${ECR_URL} ECR"
 
 if ( ! aws ecr get-login-password --region ${region} --profile ${profile} | docker login --username AWS --password-stdin ${ECR_URL} )
 then
   echo "Already logged in"
 fi

 CURRENT_DIR=$(pwd)

 echo "Building ${lambda_name} Lambda Function ECR Image"
 cd ${src_base}

 docker build -t ${lambda_name}-lambda-${environment}:${lambda_name}-lambda_${stage}_${environment} --platform linux/amd64 .
 docker tag ${lambda_name}-lambda-${environment}:${lambda_name}-lambda_${stage}_${environment} ${ECR_URL}/${lambda_name}-lambda-${environment}:latest
 docker push ${ECR_URL}/${lambda_name}-lambda-${environment}:latest

 # Updating the ECR Image in the Lambda Function with this new ECR Image 
 
 if ( aws lambda get-function --function-name "${lambda_name}-${environment}" --profile "${profile}" )
 then
   aws lambda update-function-code --function-name "${lambda_name}-${environment}" --image-uri "${ECR_URL}/${lambda_name}-lambda-${environment}:latest" --profile "${profile}"
 fi

 cd ${CURRENT_DIR}
}

# Main

set -e

region="$1"
environment="$2"
profile="$3"
lambda_name="$4"
tag="$5"
stage="$6"
account_id="$7"
src_base="$8"
timeout="$9"

MAX_TIMEOUT=20

ECR_URL="${account_id}.dkr.ecr.${region}.amazonaws.com"

checkLambdaState
build
checkECRImage
