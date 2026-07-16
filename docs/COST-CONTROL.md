# Cost-Control Policy

This document defines the financial guardrails for Azure Enterprise Platform Lab.

The project uses an Azure for Students subscription with limited credit. Cost optimization and cleanup are mandatory engineering requirements.

## Principles

1. Deploy only resources required by the active phase.
2. Prefer consumption-based and scale-to-zero services.
3. Keep expensive resources active only during controlled laboratory windows.
4. Review expected cost before deployment.
5. Review actual cost after deployment.
6. Destroy temporary resources after evidence is collected.
7. Verify cleanup instead of assuming that deletion succeeded.
8. Preserve sufficient credit for later advanced phases.

## Public documentation rule

The exact subscription credit balance, subscription ID, tenant ID, and billing identifiers are not published in the repository.

Public documentation may include:

- service cost estimates;
- project budget targets;
- cost comparisons;
- sanitized Cost Management screenshots;
- cleanup results.

## Resource cost categories

| Category | Examples | Operating rule |
|---|---|---|
| Minimal | Resource groups, RBAC definitions, policies without paid dependencies | May remain if they generate no charge |
| Low | Storage with minimal data, Key Vault operations, consumption-based functions | Review regularly |
| Medium | Container Apps usage, PostgreSQL burstable instance, monitoring ingestion | Keep small and time-limited |
| High | AKS nodes, Application Gateway, NAT Gateway, dedicated APIM, Bastion | Deploy only for active labs |
| Very high | Multi-region duplication, premium gateways, large databases | Reference design unless explicitly approved |

## Mandatory tags

Where supported, chargeable resources must use:

```text
project       = azure-enterprise-platform-lab
environment   = dev | staging | production
owner         = Morgein
managed_by    = terraform
purpose       = short technical description
expiration    = YYYY-MM-DD
```

The `expiration` tag is informational. It does not delete the resource automatically.

## Budget alerts

Budget alerts are configured through Azure Portal.

Recommended thresholds:

- 50 percent - review current usage;
- 75 percent - stop nonessential deployments;
- 90 percent - destroy temporary resources;
- 100 percent - no new paid deployment.

Azure budget alerts do not automatically stop or delete resources.

## Pre-deployment checklist

Before `terraform apply`:

- [ ] Review the Terraform plan.
- [ ] Identify every paid resource.
- [ ] Confirm the Azure region.
- [ ] Confirm the SKU.
- [ ] Confirm minimum and maximum scaling.
- [ ] Estimate the active laboratory time.
- [ ] Confirm log-retention settings.
- [ ] Confirm the cleanup command.
- [ ] Confirm that resource locks will not block cleanup.
- [ ] Confirm sufficient remaining credit.

## Post-deployment checklist

After deployment:

- [ ] Verify expected resources.
- [ ] Verify application functionality.
- [ ] Collect sanitized evidence.
- [ ] Check resource tags.
- [ ] Review Cost Management.
- [ ] Record the deployment start time.
- [ ] Record the planned destruction time.

## Cleanup checklist

After the laboratory:

- [ ] Run the reviewed Terraform destroy operation.
- [ ] Confirm that the resource group is empty or deleted.
- [ ] Check for managed disks.
- [ ] Check for snapshots.
- [ ] Check for public IP addresses.
- [ ] Check for NAT Gateway.
- [ ] Check for Application Gateway.
- [ ] Check for private endpoints.
- [ ] Check for PostgreSQL servers.
- [ ] Check for AKS node resource groups.
- [ ] Check for Log Analytics ingestion.
- [ ] Check for backup resources.
- [ ] Review Cost Management after billing data updates.

## High-risk resources

The following resources require special attention because they may generate cost while idle:

- virtual machines;
- managed disks;
- public IP addresses;
- NAT Gateway;
- Application Gateway;
- Azure Bastion;
- AKS worker nodes;
- dedicated API Management tiers;
- PostgreSQL servers;
- private endpoints;
- backup storage;
- Log Analytics ingestion and retention.

## Service strategy

### API Management

Use a consumption-based tier for the real low-volume laboratory when it provides the required features.

Dedicated APIM tiers are used only when a controlled advanced test requires them.

### Container Apps

Use scale-to-zero where application behavior allows it.

Set conservative maximum replica counts.

### AKS

Use the free control-plane tier where available.

Worker nodes remain chargeable.

Create AKS only for controlled advanced laboratories and destroy it after validation.

### PostgreSQL

Use a low-cost development configuration.

Create the server only when the active phase requires it.

Verify backup and restore behavior before destruction.

### Monitoring

Collect only useful telemetry.

Use short development retention.

Avoid logging secrets, tokens, complete request bodies, or uncontrolled high-cardinality fields.

## Unexpected-cost response

If unexpected cost appears:

1. Stop new deployments.
2. Identify the service and resource group.
3. Check recent Terraform applies.
4. Check for orphaned resources.
5. Destroy nonessential resources.
6. Verify deletion.
7. Record the root cause.
8. Update Terraform, documentation, or cleanup automation.
9. Recalculate the remaining project budget.

## Completion requirement

A project phase is not complete until its active paid resources are either:

- intentionally retained with documented reason and cost; or
- destroyed and verified.
