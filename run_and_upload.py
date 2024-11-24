import paramiko

def lambda_handler(event, context):
    # EC2 Instance Configuration
    ec2_ip = "13.60.253.208"  # Replace with your EC2 public IP
    ec2_user = "ubuntu"  # Default username for Amazon Linux. Change if needed.
    key_path = "./whawryluk.pem"  # Path to your SSH key in the Lambda environment

    # Command to execute
    commands = [
        "cd /path/to/repo",  # Navigate to the folder where your repo is stored
        "python3 run_and_upload.py"  # Run the main script
    ]
    full_command = " && ".join(commands)

    # Establish SSH connection
    try:
        ssh = paramiko.SSHClient()
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        ssh.connect(ec2_ip, username=ec2_user, key_filename=key_path)

        # Execute the command
        stdin, stdout, stderr = ssh.exec_command(full_command)
        output = stdout.read().decode()
        error = stderr.read().decode()
        ssh.close()

        # Log output and errors
        if output:
            print(f"Output: {output}")
        if error:
            print(f"Error: {error}")
        return {"statusCode": 200, "body": output if output else error}
    except Exception as e:
        print(f"Failed to connect or execute command: {e}")
        return {"statusCode": 500, "body": str(e)}
