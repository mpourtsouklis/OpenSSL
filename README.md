# Network Security Lab: OpenSSL

## Course Information
-   **Course:** Network Security
-   **Department:** Computer Science
-   **Institution:** Athens University of Economics and Business
-   **Semester:** 4th Year's Fall (2022-23)
-   **Instructor:** Dr. Ioannis F. Marias

## Overview
This project involves setting up a CentOS 7 virtual machine, configuring it as a secure web server using Apache, OpenSSL and MariaDB, and hosting a login page. 

## Steps
### 0. Web Server Setup
-  **Create a VM** on the [~okeanos platform](https://okeanos.grnet.gr/home/)
-  **Install CentOS 7** operating system


### 1. User Creation
-   **Create a user:** `teacher`
-   **Authentication:** SSH public key

### 2. Permissions Configuration
-   **Grant read permissions** to user `teacher` on `/home` and `/root`
-   **Remove write permissions** from user `teacher` on `/home`

### 3. Apache Web Server Setup
-   **Install and configure** all necessary services for Apache to function as a web server

### 4. Firewall Configuration
-   **Add inbound rules** in FirewallD for HTTP (port 80) and HTTPS (port 443) to be accessible from anywhere
-   **Restrict SSH access** only via AUEB VPN

### 5. OpenSSL Configuration
-   **Create** Certificate Authority (CA), Certificate Signing Request (CSR) and SSL certificate using OpenSSL

### 6. Apache SSL Configuration
-   **Serve SSL certificate:** Configure Apache to serve your SSL certificate on HTTPS and redirect HTTP to HTTPS
-   **Ensure** the entire SSL certificate chain is displayed correctly

### 7. Simple Website Creation
-   **Create a website** with a simple login form
-   **Functionality:** Display a success message when your student ID is submitted, otherwise display a failure message

### 8. Bash History Logging
-   **Create a text file:** Named after your student ID
-   **Content:** Copy your bash history into this file
-   **Location:** Save the file in your home directory

## Extra: Secure Data Storage and BruteForce Attack Preventation
### A. Storing User Passwords in the Database
- Every original password is combined with a unique salt, to prevent rainbow table attack
- Passwords are stored as the result of a hash function using a strong cryptographic hashing algorithm, to ensure user privacy in case of a data breach

![image](https://github.com/mpourtsouklis/SecureCentOS7WebServer/assets/103905458/8df9cbb0-840f-472e-82fc-f4720f46d39b)


### B. Logging Failed Login Attempts 
- Every failed login attempts increases the user's login attempts by 1
- If the user logs in successfully, the user's login attempts are reset to 0
- If the user fails 3 times to log in, their account gets locked

> Failed login attempt for user `3190138`

![image](https://github.com/mpourtsouklis/SecureCentOS7WebServer/assets/103905458/06184f8c-29a2-4ea1-90db-7ab60d86cd44)  ![image](https://github.com/mpourtsouklis/SecureCentOS7WebServer/assets/103905458/2542cd07-6427-48c8-9f97-6d500e07a116)



> Successful login attempt for user `3190138`

![image](https://github.com/mpourtsouklis/SecureCentOS7WebServer/assets/103905458/56196430-3c94-4bb4-8d61-9de6bd98067b)

> 3 failed login attempts for user `3190138`

![image](https://github.com/mpourtsouklis/SecureCentOS7WebServer/assets/103905458/99942f9d-6afc-4713-ba3c-bbf406485d6c) ![image](https://github.com/mpourtsouklis/SecureCentOS7WebServer/assets/103905458/22df7236-c90e-4da0-b22b-17e44a2b363d) ![image](https://github.com/mpourtsouklis/SecureCentOS7WebServer/assets/103905458/69946376-3efc-4516-b8eb-6f98d70d9241)
![image](https://github.com/mpourtsouklis/SecureCentOS7WebServer/assets/103905458/9ab1ea28-e5f4-4a42-a464-3b7416588161)





