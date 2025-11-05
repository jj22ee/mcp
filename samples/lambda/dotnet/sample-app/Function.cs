using Amazon.Lambda.Core;
using Amazon.Lambda.APIGatewayEvents;
using Amazon.S3;
using Amazon.S3.Model;

[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace LambdaSample;

public class Function
{
    private readonly IAmazonS3 _s3Client;

    public Function()
    {
        _s3Client = new AmazonS3Client();
    }

    public async Task<APIGatewayProxyResponse> FunctionHandler(APIGatewayProxyRequest request, ILambdaContext context)
    {
        context.Logger.LogInformation("Serving lambda request.");

        var result = await _s3Client.ListBucketsAsync();
        
        var otelResourceAttrs = Environment.GetEnvironmentVariable("OTEL_RESOURCE_ATTRIBUTES");
        var xrayTraceId = Environment.GetEnvironmentVariable("_X_AMZN_TRACE_ID");
        
        context.Logger.LogInformation($"Fetched OTel Resource Attrs:{otelResourceAttrs}");
        context.Logger.LogInformation($"Fetched X-Ray Trace Header:{xrayTraceId}");

        var bucketCount = result.Buckets?.Count ?? 0;
        var responseBody = $"Hello lambda - found {bucketCount} buckets. X-Ray Trace ID: {xrayTraceId ?? "Not available"}";

        return new APIGatewayProxyResponse
        {
            StatusCode = 200,
            Body = responseBody
        };
    }
}