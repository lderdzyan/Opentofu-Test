# Opentofu-Test

This repository demonstrates an **AWS serverless infrastructure** managed with **OpenTofu** and **Serverless Framework**, using **GitHub Actions** to build Lambda functions and upload artifacts to **Amazon S3** via a **matrix job**.

---

## Repository Structure

```
├── infra/
│ ├── main.tf
│ ├── providers.tf
│ └── variables.tf
│
├── src/
│ └── <lambda functions / folders>
│
├── serverless.yml
├── package.json
└── .github/
|   ├──workflows/
|       ├── lambdaBuilds.yml

```


### Description

- **infra/**  
  OpenTofu configuration for AWS infrastructure (IAM, S3, Lambda, etc.)

- **src/**  
  Lambda function source code (each file or folder represents a Lambda)

- **serverless.yml**  
  Used to package Lambda functions into `.zip` artifacts

- **package.json**  
  Node.js dependencies and scripts required for building Lambdas

- **.github/workflows/**  
  GitHub Actions workflows that:
  - Build Lambda artifacts
  - Use a **matrix job** to process multiple Lambdas
  - Upload artifacts to **Amazon S3**

---

## CI/CD Flow (GitHub Actions)

1. **Trigger**
   - Runs on push (e.g. `dev` branch)

2. **Build Phase**
   - Installs dependencies
   - Packages Lambda functions using Serverless
   - Produces `.zip` files

3. **Matrix Job**
   - Iterates over Lambda artifacts
   - Uploads each Lambda zip to S3
   - Can be used later by OpenTofu for deployment

4. **Authentication**
   - Uses **OIDC (GitHub → AWS)**  
   - No static AWS credentials stored in the repo

---

## Infrastructure (OpenTofu)

OpenTofu is used instead of Terraform.

Typical responsibilities:
- S3 bucket for Lambda artifacts
- IAM roles and policies
- Lambda functions
- Permissions and integrations (API Gateway, etc.)

Example files:
- `providers.tf` – AWS provider & backend
- `variables.tf` – configurable inputs
- `main.tf` – core infrastructure resources

---

## Requirements

- Node.js 
- OpenTofu
- AWS account
- GitHub repository with Actions enabled
- OIDC-configured IAM role in AWS

---

## Usage

### Build Lambdas Locally
```bash
npm install
npx serverless package
```
## Infrastructure Usage

### GitHub Actions Configuration

This repository relies on **GitHub Actions secrets and variables** for infrastructure and deployment configuration.

Typical usage includes:
- AWS account and region configuration
- S3 bucket names for Lambda artifacts
- Environment-specific values (e.g. `dev`, `stage`, `prod`)
- IAM role ARNs used for OIDC-based authentication

Secrets and variables are referenced in:
- `.github/workflows/*.yml`
- OpenTofu input variables (`TF_VAR_*`)

---

### Initialize Infrastructure

```bash
cd infra
tofu init
```

### Apply Infrastructure

This step applies the OpenTofu configuration using values provided by **GitHub Actions secrets and variables**.

```bash
tofu apply
```