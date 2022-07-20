# REA Sinatara App Challenge

## Goals

1. Create the server (can be local VM or AWS based) 
2. Configure an OS image (your choice) appropriately.
3. Deploy the provided application.
4. Make the application available on port 80.
5. Ensure that the server is locked down and secure.

### (Additional Goals)
- Simplicity
- Code /Documentation and layout
- Ease of deployment
- Idempotency
- Security
- Anti - Fragility

## Documentation

### Design choices and Assumptions

- As per the requirements (1) & (2) the solution will be deployed using IAAS to showcase the IAC understanding
- Treating the challenge as a staging server, rather than a production server (no redundancy, monitoring capabilities etc.)
- As the solution will be deployed as IAAS, no PAAS/FAAS applications are being used.
- AWS account is required with the proper user rights.



### Prerequisite 
- Terraform (version )
- AWS Cli installed on the client machine
- Text editor 
- AWS Programmatic credentials 
- Network connectivity

### Method of procedure to execute the code


- The infrastructure as a code has the following flow chart
- The following configuration is stored in .env file that can be changed by the user
    - AWS Region 
    - AWS Credentials
    - Subnet
    - IP address
    - Tags : appName
    - Tags : Resource Type
    - Tags : Description



