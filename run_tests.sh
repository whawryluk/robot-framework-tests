echo "Running rf tests..."
robot -d reports tests/
echo "Tests completed. Uploading reports to S3..."
python upload_to_s3.py
echo "Reports uploaded successfully!"
