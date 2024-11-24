import os
import boto3
import paramiko
import subprocess


def get_ssh_key_from_secrets():
    client = boto3.client('secretsmanager')
    secret_name = "my-ec2-ssh-key"

    response = client.get_secret_value(SecretId=secret_name)
    return response['SecretString']


def write_key_to_temp():
    key_content = get_ssh_key_from_secrets()
    key_path = "/tmp/temp-key.pem"

    # Write the key content to a file
    with open(key_path, "w") as key_file:
        key_file.write(key_content)

    # Set secure permissions
    os.chmod(key_path, 0o400)
    return key_path


def lambda_handler(event, context, paramiko=None):
    """
    Lambda function entry point.
    """
    # EC2 configuration
    ec2_ip = "13.60.253.208"  # Replace with your EC2's public IP
    ec2_user = "ec2-user"  # Default user for Amazon Linux; change if needed

    # Commands to execute on EC2
    commands = [
        "cd /path/to/repo",  # Update with the path where your repo is cloned
        "python3 run_and_upload.py"  # Runs the main test script
    ]

    # Retrieve and write the private key
    key_path = write_key_to_temp()

    # SSH into the EC2 instance and execute commands
    try:
        ssh = paramiko.SSHClient()
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        ssh.connect(ec2_ip, username=ec2_user, key_filename=key_path)

        # Execute the command
        full_command = " && ".join(commands)
        stdin, stdout, stderr = ssh.exec_command(full_command)

        # Log output and errors
        output = stdout.read().decode()
        error = stderr.read().decode()
        print(f"Output: {output}")
        print(f"Error: {error}")
        ssh.close()

        # Return response
        return {
            "statusCode": 200,
            "body": f"Execution completed. Output: {output}" if output else f"Errors: {error}"
        }

    except Exception as e:
        print(f"Failed to connect or execute command: {e}")
        return {"statusCode": 500, "body": str(e)}
