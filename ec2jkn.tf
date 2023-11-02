# Specify the provider and AWS region
provider "aws" {
  region = "us-east-1" # Replace with your desired region
 }


# Define the EC2 instance

resource "aws_instance" "windows_instance" {
  ami           = "ami-0efd0e356e33d31de" # Specify the Windows AMI ID
  instance_type = "t2.micro"              # Change instance type as needed
  key_name      = "winkeypair"            # Replace with your key pair name
  subnet_id     = "subnet-093fbe85418375fe6"       # Replace with your subnet ID
  security_groups = ["sg-09ae7347262da7e6d"]  # Replace with your security group ID
  

tags = {
    Name = "AWS-test2"
}

 user_data = <<-EOF
    <powershell>
    # Configure the instance (e.g., install software, configure settings)

    # Set the new computer name
    
    $NewComputerName = "MYServer1"
    (Get-WmiObject -Class Win32_ComputerSystem).Rename($NewComputerName)
   

# Set DNS server addresses
    $DnsServers = "172.31.35.59"  # Replace with your desired DNS server IP addresses
    
    # Configure DNS servers
    $NetworkInterface = Get-NetAdapter | Where-Object { $_.Status -eq "Up" }
    $NetworkInterface | Set-DnsClientServerAddress -ServerAddresses $DnsServers

    
</powershell>
EOF
}
# Output the public IP address of the instance

  output "public_ip" {
  value = aws_instance.windows_instance.public_ip
  }
