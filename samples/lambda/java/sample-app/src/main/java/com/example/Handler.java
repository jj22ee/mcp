package com.example;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyRequestEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyResponseEvent;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.ListBucketsResponse;

public class Handler implements RequestHandler<APIGatewayProxyRequestEvent, APIGatewayProxyResponseEvent> {
    
    private final S3Client s3Client = S3Client.create();

    @Override
    public APIGatewayProxyResponseEvent handleRequest(APIGatewayProxyRequestEvent event, Context context) {
        context.getLogger().log("Serving lambda request.");

        ListBucketsResponse result = s3Client.listBuckets();
        
        String otelResourceAttrs = System.getenv("OTEL_RESOURCE_ATTRIBUTES");
        String xrayTraceId = System.getProperty("com.amazonaws.xray.traceHeader");
        
        context.getLogger().log("Fetched OTel Resource Attrs:" + otelResourceAttrs);
        context.getLogger().log("Fetched X-Ray Trace Header:" + xrayTraceId);

        int bucketCount = result.buckets() != null ? result.buckets().size() : 0;
        String responseBody = String.format("Hello lambda - found %d buckets. X-Ray Trace ID: %s", 
            bucketCount, xrayTraceId != null ? xrayTraceId : "Not available");

        APIGatewayProxyResponseEvent response = new APIGatewayProxyResponseEvent();
        response.setStatusCode(200);
        response.setBody(responseBody);
        
        return response;
    }
}