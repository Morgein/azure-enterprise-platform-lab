# ADR-0001: Use Terraform as the Primary Provisioning Method

- Status: Accepted
- Date: 2026-07-16
- Decision owners: Project maintainer

## Context

The project requires a reproducible method for creating, changing, and deleting Azure infrastructure.

Azure CLI is available in the local Kali Linux environment but is not sufficiently reliable to use as the primary provisioning method.

The project must also operate within an Azure for Students subscription with limited credit. Infrastructure therefore needs predictable plans, reviewable changes, repeatable cleanup, and clear ownership.

## Decision

Terraform is the primary method for provisioning Azure resources.

Azure Portal is used for:

- subscription and billing configuration;
- budget alerts;
- selected bootstrap operations;
- selected identity configuration;
- visual inspection;
- troubleshooting;
- verification.

Azure CLI is optional and may be used for:

- authentication;
- read-only inspection;
- diagnostics;
- commands that are explicitly tested and documented.

Azure CLI is not used as the primary resource-provisioning method.

Manual resources created through Azure Portal must be:

- imported into Terraform;
- replaced by Terraform-managed resources; or
- explicitly documented as outside Terraform ownership.

## Consequences

### Positive consequences

- Infrastructure changes are reviewable.
- Resources can be reproduced.
- Dependencies are represented in code.
- Cleanup can be planned through Terraform.
- Git history records infrastructure changes.
- Pull requests can contain Terraform plans.
- Security scanning can run before deployment.
- Environment differences can be controlled.
- Manual configuration drift can be detected.

### Negative consequences

- Terraform state must be protected.
- Provider versions must be managed.
- Some new Azure features may appear in Terraform later than in Azure Portal.
- Importing manually created resources may require additional work.
- Incorrect Terraform changes can still destroy resources.
- Terraform does not automatically guarantee application correctness.

## Security implications

- Terraform state may contain sensitive information.
- State must not be committed to Git.
- Backend access must use least privilege.
- Real `.tfvars` files must not be committed.
- Secrets should be referenced from Key Vault where possible.
- GitHub Actions should authenticate through OIDC instead of a long-lived client secret.

## Cost implications

Terraform plans help identify resources before deployment, but a plan is not a cost guarantee.

Every paid deployment still requires:

- SKU review;
- region review;
- runtime planning;
- scaling limits;
- cleanup verification;
- Cost Management review.

## Alternatives considered

### Azure Portal only

Rejected as the primary method because manual deployments are difficult to reproduce, review, test, and clean up consistently.

### Azure CLI scripts

Rejected as the primary method because Azure CLI is unreliable in the current local environment and imperative scripts require additional state and idempotency handling.

### Bicep

Bicep remains useful for comparing Azure-native Infrastructure as Code.

It is not selected as the primary tool because the project focuses on advanced Terraform workflows and may integrate additional providers and external systems.

### Ansible

Ansible remains useful for operating-system and application configuration.

It is not selected as the main Azure provisioning tool because Terraform provides a stronger infrastructure dependency and state model for this project.

## Compliance

A change complies with this decision when:

- Terraform owns the Azure resource where practical;
- manual changes are documented;
- infrastructure changes are reviewed;
- state is protected;
- cleanup is defined;
- secrets are not committed.

## Review conditions

This decision should be reviewed if:

- Azure CLI becomes the required organizational standard;
- Terraform cannot support a required Azure feature;
- the project moves to an organization with an established Bicep platform;
- Terraform state requirements become incompatible with the target environment.
