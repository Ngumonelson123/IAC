import boto3

# Test 1 - Verify identity
sts = boto3.client('sts')
identity = sts.get_caller_identity()
print("Account:", identity['Account'])
print("User ARN:", identity['Arn'])

# Test 2 - List S3 buckets
s3 = boto3.client('s3')
buckets = s3.list_buckets()
print("\nS3 Buckets:")
for bucket in buckets['Buckets']:
    print(" -", bucket['Name'])
