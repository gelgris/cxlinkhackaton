/* Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: Apache-2.0
ABOUT THIS NODE.JS EXAMPLE: This example works with the AWS SDK for JavaScript version 3 (v3),
which is available at https://github.com/aws/aws-sdk-js-v3.

Purpose:
This file provides the necessary information for the program to access 
AWS resources.

Inputs (replace in code):
- REGION // Amazon region (e.g. us-west-2)
- IDENTITY_POOL_ID - an Amazon Cognito Identity Pool ID.
*/

export const ACCOUNT_ID = '585543526779'
export const REGION = "eu-west-1"; 
export const IDENTITY_POOL_ID = "eu-west-1:e7548ac9-edb2-40a7-b26c-53f313f74730";
export const BUCKET = "cl-ir-ml-hackathon-aws-forecast-raw-bucket-cruz-roja-dev";
export const SESSION_ID = Date.now();
