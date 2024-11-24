import boto3
import os


def upload_to_s3(bucket_name, folder_path):
    s3 = boto3.client('s3')
    for root, dirs, files in os.walk(folder_path):
        for file in files:
            s3.upload_file(os.path.join(root, file), bucket_name, f"reports/{file}")


upload_to_s3('robot-framework-test-reports-whawryluk2', './reports')
