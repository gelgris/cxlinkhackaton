import sys
import json
import boto3
import datetime

from pyspark.sql.functions import *
from pyspark.sql.functions import udf, array
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
from awsglue.dynamicframe import DynamicFrame
from pyspark.sql.types import StringType, LongType, FloatType

createTimestampUDF = udf(lambda arr:createTimestamp(arr),StringType())

# TODO: Remove harcoded values
# TODO: Add erzet
# VBAP: US_OPERATION,MATNR,KWMENG,WERKS,LGORT,ERDAT,ERZET,NETPR
# MARD: US_OPERATION,MATNR,WERKS,LGORT,LABST

args = getResolvedOptions(sys.argv,
                          ['JOB_NAME',
                           'aws_account',
                           'aws_region',
                           'environment'
			   'customer_id',
                           'aws_forecast_glue_database_name',
                           'aws_forecast_use_case',
                           'aws_forecast_curated_s3_bucket',
                           'aws_forecast_glue_job_output_format',
                           'mappings_file'
])

aws_account                             = args['aws_account']
aws_region                              = args['aws_region']
environment                             = args['environment']
customer_id				= args['customer_id']
aws_forecast_glue_database_name         = args['aws_forecast_glue_database_name']
aws_forecast_use_case                   = args['aws_forecast_use_case']
aws_forecast_curated_s3_bucket          = args['aws_forecast_curated_s3_bucket']
aws_forecast_glue_job_output_format     = args['aws_forecast_glue_job_output_format']

aws_forecast_use_case = aws_forecast_use_case.replace('_', '-')

awsForecastGlueJobOutputPath 		    = "s3://" + aws_forecast_curated_s3_bucket + "/" + aws_account + "/" + aws_region + "/" + "aws-forecast" + "/" + aws_forecast_use_case  + "/" + "st_ir_ml_aws_forecast_sap_sales_" + custormer_id + '_' + environment
awsForecastGlueJobS3aOutputPath             = "s3a://" + aws_forecast_curated_s3_bucket + "/" + aws_account + "/" + aws_region + "/" + "aws-forecast" + "/" + aws_forecast_use_case  + "/" + "st_ir_ml_aws_forecast_sap_sales_" + custormer_id + '_' + environment

awsForecastGlueJobTargetDataSetOutputPath   = awsForecastGlueJobOutputPath + "/" + "st_ir_ml_aws_forecast_sap_sales_target"  + "_"  + customer_id + '_' + environment + "/"
awsForecastGlueJobRelatedDataSetOutputPath  = awsForecastGlueJobOutputPath + "/" + "st_ir_ml_aws_forecast_sap_sales_related" + "_"  + customer_id + '_' + environment + "/"

awsForecastGlueJobTargetDataSetS3aOutputPath   = awsForecastGlueJobS3aOutputPath + "/" + "st_ir_ml_aws_forecast_sap_sales_target"  + "_"  + customer_id + '_' + environment + "/"
awsForecastGlueJobRelatedDataSetS3aOutputPath  = awsForecastGlueJobS3aOutputPath + "/" + "st_ir_ml_aws_forecast_sap_sales_related" + "_"  + customer_id + '_' + environment + "/"

# Spark Context Initialization

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session

logger = glueContext.get_logger()

def createTimestamp(timestamp):
  erdat = datetime.datetime.strptime(str(timestamp[0]), '%Y%m%d').strftime("%Y-%m-%d")
  timestamp = str(erdat)
  return timestamp

def transformTimestamp(glueContext, parentFrame, transformation_ctx) -> DynamicFrame:
    df = parentFrame.toDF()
    df = df.withColumn("timestamp", createTimestampUDF(array(df["erdat"])))
    return DynamicFrame.fromDF(df, glueContext, transformation_ctx)

# TODO: Harcoded tables names

def emptyBucket(bucket, prefix, aws_region):
  try:
    aws_session_token = boto3.session.Session()
  except ClientError as e:
    if e.response['Error']['Code'] == 'InvalidClientTokenId':
      logger.error('Credentials not valid. Maybe local Execution?')
      exit(1)

  s3_client = aws_session_token.client(
        service_name ='s3',
        region_name = aws_region
  )
  objects = s3_client.list_objects(Bucket=bucket, Prefix=prefix)
  if "Contents" in objects:
    delete_keys = {'Objects': [{'Key': obj['Key']} for obj in objects['Contents']]}
    s3.delete_objects(Bucket=bucket, Delete=delete_keys)

def sparkSqlQuery(glueContext, query, mapping, transformation_ctx) -> DynamicFrame:
  for alias, frame in mapping.items():
    frame.toDF().createOrReplaceTempView(alias)
  result = spark.sql(query)
  return DynamicFrame.fromDF(result, glueContext, transformation_ctx)

def applyTransformation(glueContext, args):
    job = Job(glueContext)
    job.init(args["JOB_NAME"], args)

    # Creating DynamicFrames based in VBAP and MARD Glue Tables
    AWSGlueDataCatalog_mard_node1 = glueContext.create_dynamic_frame.from_catalog(
      database = aws_forecast_glue_database_name,
      table_name = "mard",
      transformation_ctx = "AWSGlueDataCatalog_mard_node1",
    )

    AWSGlueDataCatalog_vbap_node2 = glueContext.create_dynamic_frame.from_catalog(
      database = aws_forecast_glue_database_name,
      table_name = "vbap",
      transformation_ctx= "AWSGlueDataCatalog_vbap_node2",
    )

    # Target DataSet Creation
    ## SQL Query for Target DataSet
    # # VBAP: US_OPERATION,MATNR,KWMENG,WERKS,LGORT,ERDAT,ERZET,NETPR
    # Take only the LOAD (L) US_OPERATION records

    TargetSqlQuery = """
    select
           vbap.MATNR,
	   vbap.ERDAT,
           sum(vbap.KWMENG) as KWMENG,
	   vbap.ERKS,
	   vbap.LGORT
           from vbap group by vbap.MATNR,vbap.ERDAT,vbap.NETPR,vbap.WERKS,vbap.LGORT
           where mard.US_OPERATION == 'L'
    """

    SQLQuery_node3 = sparkSqlQuery(
      glueContext,
      query   = TargetSqlQuery,
      mapping = {
        "mard": AWSGlueDataCatalog_mard_node1,
        "vbap": AWSGlueDataCatalog_vbap_node2,
      },
      transformation_ctx = "SQLQuery_node3"
    )

    ## Fields Mapping
    ApplyMapping_node4 = ApplyMapping.apply(
      frame   = SQLQuery_node3,
      mappings= [
        ("MATNR", "string", "item_id", "string"),
        ("ERDAT", "bigint", "erdat", "string"),
        ("KWMENG", "double", "demand", "double"),
        ("WERKS", "string", "werks", "string"),
        ("LGORT", "string", "lgort", "string")
    ],
    transformation_ctx="ApplyMapping_node4"
    )

    ## Transformation to create the timestamp merging erdat
    TimestampDataSet_node5 = transformTimestamp(
        glueContext,
        parentFrame = ApplyMapping_node4,
        transformation_ctx = "TimestampDataSet_node5"
    )

    ## Dropping erdat
    TimestampDataSet_node6 = TimestampDataSet_node5.drop_fields(['erdat'])

    ## Dropping net price and stock fields to create the Forecast Target DataSet
    TargetDataSet_coalesce_node7 = TimestampDataSet_node6.coalesce(1)

    targetDF = TargetDataSet_coalesce_node7.toDF()
    targetDF.write.mode('overwrite').options(header='True',delimiter=',').csv(awsForecastGlueJobTargetDataSetS3aOutputPath)

    '''
    # Related DataSet Creation
    # MARD: US_OPERATION,MATNR,WERKS,LGORT,LABST
    # Take only the LOAD (L) US_OPERATION records
    RelatedSqlQuery = """
    select
           vbap.MATNR,
	   vbap.ERDATA,
           vbap.NETPR,
           mard.LABST
           from vbap inner join mard on vbap.MATNR = mard.MATNR group by vbap.MATNR, vbap.ERDAT, vbap.NETPR, mard.LABST
           where mard.US_OPERATION == 'L'
    """

    ## SQL Query for Related DataSet
    SQLQuery_node8 = sparkSqlQuery(
      glueContext,
      query   = RelatedSqlQuery,
      mapping = {
        "mard": AWSGlueDataCatalog_mard_node1,
        "vbap": AWSGlueDataCatalog_vbap_node2,
      },
      transformation_ctx = "SQLQuery_node8"
    )

    ApplyMapping_node9 = ApplyMapping.apply(
      frame   = SQLQuery_node8,
      mappings= [
        ("MATNR", "string", "item_id", "string"),
        ("ERDAT", "bigint", "erdat", "string"),
        ("NETPR", "double", "netpr", "double"),
        ("LABST", "double", "labst", "double")
    ],
    transformation_ctx="ApplyMapping_node9"
    )

    # Transformation to create the timestamp merging erdatt
    TimestampDataSet_node10 = transformTimestamp(
        glueContext,
        parentFrame = ApplyMapping_node9,
        transformation_ctx = "TimestampDataSet_node10"
    )
    # Dropping erdat
    TimestampDataSet_node11 = TimestampDataSet_node10.drop_fields(['erdat'])

    # Dropping net price and stock fields to create the Forecast Target DataSet
    RelatedDataSet_coalesce_node12 = TimestampDataSet_node11.coalesce(1)

    relatedDF = RelatedDataSet_coalesce_node12.toDF()
    relatedDF.write.mode('overwrite').options(header='True',delimiter=',').csv(awsForecastGlueJobRelatedDataSetS3aOutputPath)
    '''

applyTransformation(glueContext, args)
# TODO: Test the emptyBucket
#emptyBucket(aws_forecast_curated_s3_bucket, awsForecastGlueJobOutputPath, aws_region)


