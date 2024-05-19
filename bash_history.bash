# Set up root's SSH keys, using PuTTY

# First of all, install the Nano Text Editor
yum install nano

# Open "PuTTYgen"
# Within parameters, select "RSA"
# Select "Generate"
# Delete Key comment
# Select "Save private key"
# (Optional) Enter a key passphrase
# Copy the public key

# Create a hidden folder to root's home directory
mkdir .ssh
# Go to the SSH key directory
cd .ssh
# Open or create the default file OpenSSH looks for public keys
nano authorized_keys
# Paste the public key into the file !Make sure the key goes on a single line
# At the end of the public key, type "root"
# Exit file, by pressing "Cntrl+X"
# Save modified buffer, by pressing "y"
# Press Enter

# Open "Pageant"
# Select Add key
# Select the saved private key
# Select Close

# Open "PuTTY"
# Specify the destination you want to connect to root@server, where server is you server's host name/ IP address
# Select Open
# You should not get asked for your password, but instead log straight in

# Add new user and its given SSH public key

# Add new user
adduser teacher
# Set new user's password
passwd teacher
teacher
teacher

# Go to user's home directory
cd /home/teacher
# Create a hidden folder to user's home directory
mkdir .ssh
# Go to the SSH key directory
cd .ssh
# Open or create the default file OpenSSH looks for public keys
nano authorized_keys
# Paste the public key into the file !Make sure the key goes on a single line
# At the end of the public key, type user's username
# Exit file
# Save modified buffer
# Press Enter

# Turn off password authentication

# Open the SSH configuration file
nano /etc/ssh/sshd_config
# Check that public key authentication is enabled
PubkeyAuthentication yes
# Set the password authentication to no
PasswordAuthentication no
# Restart the SSH service
systemctl reload sshd

# Manage user's permissions 

# Create a group
groupadd myGroup
# Move user to the new group 
usermod -G myGroup teacher
# Set read-only permissions for the user
chmod -R u=rwx g=r /home
chmod -R u=rwx g=r /root

# Deploy Apache web server

# Install Apache
sudo yum install httpd
# Permit HTTP/HTTPS traffic into the server
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload
# Check open ports
firewall-cmd --permanent --zone=public --list-services
# Start the service
sudo systemctl start httpd
# Verify that the service is running
sudo systemctl status httpd
# Get the server’s IP address
hostname -I
# Enter the IP into the browser’s address bar:
http://<server_IP>

# Add the necessary inbound rules to the CentOS' FirewallID

# Set HTTP and HTTPS to be accessible from everywhere
firewall-cmd --permanent --zone=internal --add-service=ssh
# Restricting SSH access only through the VPN
firewall-cmd --permanent --zone=internal --add-source=<VPN_public_IP>/32
# If your public IP on the VPN is different from the <VPN_public_IP>, add it too
firewall-cmd --permanent --zone=public --remove-service=ssh

# Install CA, CSR and SSL certificates

# Install OpenSSL
yum install -y openssl
# Generate a private key with 2048 bit encryption
openssl genrsa -out ca.key 2048 
# Generate a certificate signing request (CSR)
openssl req -new -key ca.key -out ca.csr
# Generate a self-signed certificate of X509 type, which remains valid for 365 keys
openssl x509 -req -days 365 -in ca.csr -signkey ca.key -out ca.crt
# Copy the files to the necessary directories
cp ca.crt /etc/pki/tls/certs/
cp ca.key /etc/pki/tls/private/
cp ca.csr /etc/pki/tls/private/

# Add the necessary rules to the Apache server 

# Configure Apache to serve the certificate over HTTPS and redirect HTTP to HTTPS
nano /etc/httpd/conf.d/ssl.conf
# Retart the service
systemctl restart httpd