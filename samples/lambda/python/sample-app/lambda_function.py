import json
import os
import boto3

s3 = boto3.client('s3')

def lambda_handler(event, context):
    print('Serving lambda request.')
    
    result = s3.list_buckets()
    
    otel_resource_attrs = os.environ.get('OTEL_RESOURCE_ATTRIBUTES')
    xray_trace_id = os.environ.get('_X_AMZN_TRACE_ID')
    
    print(f'Fetched OTel Resource Attrs:{otel_resource_attrs}')
    print(f'Fetched X-Ray Trace Header:{xray_trace_id}')
    
    bucket_count = len(result.get('Buckets', []))
    response_body = f"Hello lambda - found {bucket_count} buckets. X-Ray Trace ID: {xray_trace_id or 'Not available'}"
    
    return {
        'statusCode': 200,
        'body': response_body
    }