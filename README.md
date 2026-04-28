# Azure VNet Peering with Terraform
<img width="886" height="554" alt="AzureVnetpeering" src="https://github.com/user-attachments/assets/7028e2d0-d3a8-46c1-8e92-93e49d86c61a" />

## Overview

This project demonstrates how to deploy and configure Virtual Network (VNet) Peering in Azure.

It includes:

- Local VNet Peering (same region)
- Global VNet Peering (different regions)

This project helps automate secure communication between multiple Azure virtual networks.

---

## Project Structure

```text
Azure-Vnet-with-Terraform/
├── DeployingVNetpeering/
│   └── main.tf
├── SettingUpGlobalVNetPeering/
│   └── main.tf
└── README.md
```

---

## Prerequisites

Before deployment, make sure you have:

- Azure Subscription
- Terraform installed
- Azure CLI installed
- Existing Azure Resource Group

---

## Authenticate to Azure

Login to Azure:

```bash
az login
```

Verify subscription:

```bash
az account show
```

---

# Project 1: Deploying VNet Peering

## Overview

This section creates two virtual networks inside the same Azure Resource Group and establishes peering between them.

## File

- `main.tf`

## Resources Created

- Resource Group lookup
- VNet1 (`10.0.0.0/16`)
- VNet2 (`10.1.0.0/16`)
- VNet Peering (both directions)

## What it does

Creates:

- `vnet1`
- `vnet2`
- `vnet1-to-vnet2`
- `vnet2-to-vnet1`

This allows both networks to communicate privately.

---

## Required Changes

Replace:

```hcl
<resource_group_name>
```

with your Azure Resource Group.

---

## Deploy Steps

```bash
cd DeployingVNetpeering
terraform init
terraform plan
terraform apply
```

---

## Expected Result

Two VNets deployed with bidirectional peering.

---

# Project 2: Setting Up Global VNet Peering

## Overview

This section creates two VNets in different Azure regions and connects them using Global VNet Peering.

## File

- `main.tf`

## Resources Created

- VNet in East US
- VNet in West Europe
- Subnet in each VNet
- Global Peering connections

## VNets

### VNet 1

- Name: `vnet-eastus`
- Region: East US
- Address Space: `10.0.0.0/16`

### VNet 2

- Name: `vnet-westeurope`
- Region: West Europe
- Address Space: `10.1.0.0/16`

---

## Subnets

### Subnet 1

- `10.0.1.0/24`

### Subnet 2

- `10.1.1.0/24`

---

## Required Variables

### resource_group_name

Set your Azure Resource Group.

Example:

```bash
terraform apply -var="resource_group_name=myResourceGroup"
```

---

## Deploy Steps

```bash
cd SettingUpGlobalVNetPeering
terraform init
terraform plan
terraform apply -var="resource_group_name=myResourceGroup"
```

---

## Expected Result

Two VNets deployed in separate regions with global connectivity.

---

## Terraform Workflow

Initialize:

```bash
terraform init
```

Validate:

```bash
terraform validate
```

Plan:

```bash
terraform plan
```

Apply:

```bash
terraform apply
```

Destroy:

```bash
terraform destroy
```

---

## Verify in Azure

Go to:

Azure Portal → Virtual Networks → Peerings

Verify:

- Connected status
- Remote network visibility

---

## Troubleshooting

### Resource Group Not Found

Check:

```bash
az group list --output table
```

---

### Authentication Issues

Reauthenticate:

```bash
az login
```

---

### Terraform Provider Issues

Upgrade provider:

```bash
terraform init -upgrade
```

---

## Security Best Practices

- Use variables instead of hardcoding
- Restrict network access where needed
- Use tagging for resource organization
- Use remote Terraform state

---

## Learning Outcomes

By completing this project you will learn:

- Azure VNet deployment
- VNet Peering concepts
- Global VNet Peering
- Terraform provider configuration
- Terraform variables
- Infrastructure automation
