# SolidaryTech Infrastructure as Code (IaC)

This repository contains the Terraform configuration files to provision the AWS infrastructure required for the SolidaryTech microservices ecosystem.

## Architecture Overview

The infrastructure defined in this repository sets up a complete cloud environment following DevOps and SRE best practices, including:

*   **Networking:** Amazon Virtual Private Cloud (VPC) with public and private subnets, and a NAT Gateway.
*   **Compute:** Amazon Elastic Kubernetes Service (EKS) for container orchestration, configured with cost-effective instances.
*   **Databases:** Amazon Relational Database Service (RDS) running PostgreSQL for structured relational data.
*   **NoSQL Storage:** Amazon DynamoDB table configured for on-demand capacity.
*   **Messaging:** Amazon Simple Queue Service (SQS) for asynchronous event-driven communication.
*   **Container Registry:** Amazon Elastic Container Registry (ECR) for hosting Docker images securely.

## Prerequisites

Before executing the code in this repository, ensure you have the following installed and configured:

*   [Terraform](https://developer.hashicorp.com/terraform/downloads) (version 1.5.0 or newer)
*   [AWS CLI](https://aws.amazon.com/cli/)
*   AWS Credentials configured locally or securely stored as secrets in your CI/CD pipeline environment.

## Usage Instructions

This project is integrated with GitHub Actions for automated deployment. The pipeline is triggered automatically on pushes to the main branch.

If you need to run the code manually from your local machine, follow these steps:

1.  **Initialize Terraform:**
    Download the required providers and initialize the backend.
    ```bash
    terraform init
    ```

2.  **Format and Validate:**
    Ensure the code meets the formatting standards and has no syntax errors.
    ```bash
    terraform fmt -check
    terraform validate
    ```

3.  **Plan the Infrastructure:**
    Review the execution plan to see exactly what Terraform will create, update, or destroy.
    ```bash
    terraform plan
    ```

4.  **Apply the Changes:**
    Provision the resources in your AWS account.
    ```bash
    terraform apply
    ```

## FinOps and Resource Tagging

Cost management is a priority for this project. All resources are provisioned with default tracking tags to facilitate cost allocation and monitoring:
*   `Project`: SolidaryTech
*   `Environment`: Production
*   `CostCenter`: NGO-Core

Please review the instance types and scaling configurations within the `.tf` files to ensure they meet your specific performance and budget requirements.

## State Management

The Terraform state is managed remotely using an S3 backend to ensure consistency and support collaboration across team members and CI/CD pipelines. Ensure the S3 bucket specified in `providers.tf` exists in your AWS account prior to initialization.