# CorporateAWSApp

This repository has the artifacts for an experimental application in AWS. The purpose is to test various architectural patterns on a real running application
- This is a web application, with React based front end and a polyglot microservies backend, consisting of a dotnet and a spring based java api
- Terraform is used to provision the infrastructure
- It is mono repo, in that all the code, Iac as well as application code is in this repo

this application is deployed in us-west-2. Please change the Region to United Sates(Oregon) before using any console features.
Before this Terraform can start creating application artifacts, it has to be provided the storage and locking mechanisms. I creted the S3 bucket from Azure console, and Operations folder has the terrafrom to create dynamo db.
Make sure you have used aws configure to setup a user with required permissions to create your infrastructure