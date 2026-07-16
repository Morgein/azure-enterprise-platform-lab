# Project Roadmap

This document defines the implementation sequence, expected deliverables, validation requirements, and completion criteria for Azure Enterprise Platform Lab.

The roadmap moves from local development to real Azure deployment and then to advanced platform-engineering scenarios.

## Status definitions

- `Planned` - implementation has not started.
- `In progress` - implementation or validation is active.
- `Completed` - implementation, testing, evidence, documentation, and cleanup are complete.
- `Reference design` - validated through code, plans, diagrams, and documentation without permanent deployment.
- `Blocked` - implementation cannot continue until a documented dependency is resolved.

---

## Phase 0 - Repository and safety foundation

Status: **Completed**

### Objectives

- Prepare the local development environment.
- Initialize the Git repository.
- Protect author email privacy.
- Define repository structure.
- Define provisioning and security rules.
- Document cost-control requirements.
- Publish the initial repository.

### Implementation

- Verify Git, Docker, Terraform, and GitHub CLI.
- Configure Git author name and GitHub noreply email.
- Create the project directory structure.
- Create `.gitignore`.
- Create `.editorconfig`.
- Create the main README.
- Create the project roadmap.
- Create the cost-control policy.
- Create the initial Architecture Decision Records.
- Make the initial commit.
- Create the public GitHub repository.

### Evidence

- Tool version output.
- Docker `hello-world` result.
- Git configuration without personal email.
- Repository tree.
- Initial Git commit.
- Public GitHub repository.

### Exit criteria

- Repository is available on GitHub.
- No secret or personal email is committed.
- The project structure is documented.
- Provisioning rules are accepted.
- Cost-control rules are documented.

---

## Phase 1 - Local application and container baseline

Status: **Planned**

### Objectives

- Create the application that will be deployed throughout the project.
- Establish automated application testing.
- Build a secure container image.

### Implementation

- Create a Python virtual environment.
- Create a FastAPI application.
- Add `/health/live` and `/health/ready` endpoints.
- Add a versioned API endpoint.
- Add structured error responses.
- Add correlation ID handling.
- Add unit tests with Pytest.
- Add dependency locking.
- Create a multi-stage Dockerfile.
- Run the container as a non-root user.
- Add Docker health checks.
- Add local container tests.
- Scan the image with Trivy.

### Evidence

- Successful unit-test output.
- Successful Docker build.
- Container running locally.
- Health endpoint responses.
- Image metadata.
- Vulnerability scan results.

### Exit criteria

- All unit tests pass.
- The container starts successfully.
- Health endpoints work.
- The application does not require embedded secrets.
- The image runs as a non-root user.

---

## Phase 2 - Terraform foundation and remote state

Status: **Planned**

### Objectives

- Establish the Terraform workflow.
- Create reusable configuration patterns.
- Protect Terraform state.

### Implementation

- Configure Terraform version requirements.
- Configure the AzureRM provider.
- Configure provider version constraints.
- Create common variables and locals.
- Define naming and tagging conventions.
- Create the bootstrap configuration.
- Create an Azure Storage backend.
- Enable backend recovery controls.
- Configure remote state.
- Separate state by environment.
- Document state recovery.
- Add Terraform formatting and validation.

### Evidence

- `terraform fmt` result.
- `terraform validate` result.
- Bootstrap Terraform plan.
- Remote backend verification.
- State-locking verification.
- Sanitized backend configuration.

### Exit criteria

- Terraform initializes successfully.
- Remote state is protected.
- State is not committed to Git.
- Provider versions are locked.
- A clean Terraform plan can be produced.

---

## Phase 3 - Governance and resource organization

Status: **Planned**

### Objectives

- Create a consistent Azure resource organization.
- Introduce governance and cost ownership.

### Implementation

- Create development resource groups.
- Apply naming conventions.
- Apply mandatory tags.
- Configure allowed regions.
- Introduce selected Azure Policy definitions.
- Document role assignments.
- Configure budget alerts through Azure Portal.
- Create cleanup and expiration rules.
- Document quota requirements.

### Evidence

- Resource-group deployment.
- Tag verification.
- Policy result.
- Budget configuration screenshot.
- Terraform plan and apply output.
- Cost Management verification.

### Exit criteria

- All resources have required tags.
- Budget alerts are configured.
- Resource ownership is clear.
- Policies do not prevent required cleanup.
- Governance is reproducible where supported.

---

## Phase 4 - Azure networking

Status: **Planned**

### Objectives

- Build the network foundation.
- Demonstrate controlled connectivity and troubleshooting.

### Implementation

- Create the IP address plan.
- Create a virtual network.
- Create application, data, ingress, and private-endpoint subnets.
- Create Network Security Groups.
- Create least-privilege security rules.
- Create route tables where required.
- Configure private DNS.
- Test private endpoints.
- Create a hub-and-spoke reference architecture.
- Test Network Watcher troubleshooting.
- Document Application Gateway and WAF design.

### Evidence

- Network architecture diagram.
- Terraform network plan.
- Effective NSG rules.
- DNS-resolution results.
- Connectivity tests.
- Broken NSG troubleshooting scenario.

### Exit criteria

- Address ranges do not overlap.
- Application traffic follows the expected path.
- Data services are not unnecessarily public.
- DNS behavior is documented.
- Network failures can be diagnosed.

---

## Phase 5 - Container Registry and Container Apps

Status: **Planned**

### Objectives

- Publish trusted application images.
- Deploy the low-cost Azure application baseline.

### Implementation

- Create Azure Container Registry.
- Configure build and pull identities.
- Push a versioned image.
- Record the image digest.
- Create a Container Apps environment.
- Deploy the application.
- Configure ingress.
- Configure health probes.
- Configure revisions.
- Configure scale-to-zero.
- Configure minimum and maximum replicas.
- Test traffic splitting.
- Test rollback.

### Evidence

- ACR repository output.
- Image digest.
- Container Apps revision.
- Public API response.
- Scaling result.
- Rollback result.

### Exit criteria

- The image is pulled without registry passwords.
- The API is reachable.
- Health probes pass.
- Scale-to-zero works where expected.
- A failed revision can be rolled back.

---

## Phase 6 - Identity, Key Vault, Storage, and PostgreSQL

Status: **Planned**

### Objectives

- Remove static credentials from application access.
- Add secure data services.

### Implementation

- Create managed identities.
- Assign least-privilege Azure roles.
- Create Azure Key Vault.
- Configure secret access.
- Configure secret rotation test.
- Create Azure Storage.
- Configure Blob access with identity.
- Create PostgreSQL for a controlled laboratory window.
- Configure network access.
- Configure database connection pooling.
- Apply database migrations.
- Review backup configuration.
- Test restore procedures.

### Evidence

- Managed identity information.
- RBAC assignments.
- Successful Key Vault access.
- Denied unauthorized access.
- Blob operation result.
- PostgreSQL connection test.
- Migration result.
- Restore documentation.

### Exit criteria

- No application secret is committed.
- Workloads use managed identity where supported.
- Data access is least privilege.
- Database connectivity is monitored.
- Recovery steps are documented.

---

## Phase 7 - Azure API Management

Status: **Planned**

### Objectives

- Place a governed API gateway in front of the application.
- Implement API lifecycle and security controls.

### Implementation

- Create a cost-appropriate APIM instance.
- Import the OpenAPI specification.
- Create API operations and products.
- Configure subscriptions.
- Configure API versioning.
- Validate JWT tokens.
- Integrate with Microsoft Entra ID.
- Add rate limits and quotas.
- Add CORS rules.
- Add request and response transformations.
- Add backend routing.
- Add caching for safe operations.
- Add controlled retries.
- Add correlation IDs.
- Add sanitized error handling.
- Store APIM policies in Git.
- Automate policy deployment.

### Evidence

- APIM API configuration.
- Successful API request.
- Expected `401` response.
- Expected `403` response.
- Expected `429` response.
- Policy transformation result.
- Backend failure result.
- APIM monitoring data.

### Exit criteria

- APIM is the documented public API entry point.
- Authentication and throttling work.
- Policies are stored as code.
- Backend errors are sanitized.
- API behavior matches the OpenAPI contract.

---

## Phase 8 - GitHub Actions and OIDC

Status: **Planned**

### Objectives

- Automate infrastructure and application delivery.
- Remove long-lived Azure credentials from GitHub.

### Implementation

- Create GitHub Actions validation workflows.
- Configure OIDC federation.
- Create separate deployment identities.
- Restrict Azure permissions.
- Add protected GitHub environments.
- Add application tests.
- Add Docker build and scanning.
- Add Terraform formatting and validation.
- Add Terraform security scanning.
- Add Terraform plan.
- Add protected Terraform apply.
- Add application deployment.
- Add smoke tests.
- Add controlled cleanup.
- Add scheduled drift detection.

### Evidence

- Successful pull-request workflow.
- Successful OIDC authentication.
- Terraform plan artifact.
- Container image artifact metadata.
- Successful deployment workflow.
- Smoke-test result.
- Failed unauthorized deployment test.

### Exit criteria

- GitHub contains no Azure client secret.
- Pull requests cannot deploy to production.
- Production deployment requires approval.
- The deployed artifact is linked to a Git commit.
- Failed smoke tests stop the release.

---

## Phase 9 - Observability

Status: **Planned**

### Objectives

- Make application and infrastructure behavior observable.
- Create actionable monitoring.

### Implementation

- Create Log Analytics.
- Create Application Insights.
- Configure diagnostic settings.
- Instrument the application with OpenTelemetry.
- Propagate correlation and trace context.
- Create KQL queries.
- Create dashboards.
- Create metric and log alerts.
- Create availability tests.
- Define application SLIs.
- Define a learning SLO.
- Track deployment versions in telemetry.
- Review ingestion cost.

### Evidence

- Application metrics.
- Structured logs.
- Distributed trace.
- Dependency trace.
- KQL query output.
- Dashboard screenshot.
- Alert notification.
- SLO calculation.

### Exit criteria

- A request can be traced end to end.
- Deployment versions are visible.
- Alerts have owners and runbooks.
- Sensitive values are not logged.
- Log ingestion remains within the project budget.

---

## Phase 10 - AKS and Helm

Status: **Planned**

### Objectives

- Deploy the application to managed Kubernetes.
- Implement advanced container orchestration.

### Implementation

- Create a temporary AKS cluster.
- Configure node pools.
- Integrate AKS with ACR.
- Create namespaces.
- Create a Helm chart.
- Configure Deployments and Services.
- Configure Ingress.
- Configure health probes.
- Configure requests and limits.
- Configure Pod Disruption Budgets.
- Configure Horizontal Pod Autoscaler.
- Configure persistent storage where required.
- Configure workload identity.
- Integrate Key Vault.
- Configure Kubernetes Network Policies.
- Configure security contexts.
- Test rolling update and rollback.
- Review upgrade requirements.

### Evidence

- AKS cluster information.
- Helm deployment result.
- Pod status.
- Service and ingress status.
- HPA result.
- Workload identity result.
- Network Policy result.
- Rolling update result.
- Rollback result.

### Exit criteria

- The application runs successfully in AKS.
- Workloads do not use embedded Azure credentials.
- Health probes and scaling work.
- Network access is restricted.
- The cluster can be destroyed cleanly.

---

## Phase 11 - GitOps and progressive delivery

Status: **Planned**

### Objectives

- Reconcile application state from Git.
- Demonstrate controlled progressive delivery.

### Implementation

- Install Argo CD or Flux.
- Connect a deployment repository or directory.
- Configure synchronization.
- Configure health checks.
- Test drift detection.
- Test automatic or controlled reconciliation.
- Document break-glass access.
- Implement canary or traffic-splitting behavior.
- Test rollback through Git.
- Document controller permissions.

### Evidence

- GitOps application status.
- Synchronization result.
- Drift correction.
- Failed deployment result.
- Git-based rollback.
- Break-glass runbook.

### Exit criteria

- Git defines the expected workload state.
- Manual drift is detected.
- Reconciliation behavior is understood.
- Rollback is tested.
- Emergency procedures are documented.

---

## Phase 12 - Reliability, recovery, and FinOps

Status: **Planned**

### Objectives

- Test platform behavior during failure.
- Validate recovery and cost controls.

### Implementation

- Define RTO and RPO examples.
- Perform application load testing.
- Test autoscaling.
- Simulate dependency failures.
- Test retries and timeouts.
- Test PostgreSQL backup and restore.
- Test Blob version recovery.
- Create an incident timeline.
- Create a post-incident review.
- Review cost by service.
- Check for orphan resources.
- Compare Container Apps and AKS cost.
- Validate complete cleanup.

### Evidence

- k6 load-test result.
- Scaling graph.
- Failure-injection result.
- Restore result.
- Incident report.
- Postmortem.
- Cost analysis.
- Cleanup verification.

### Exit criteria

- Critical failure behavior is documented.
- Recovery procedures are tested.
- Achieved recovery time is measured.
- Cost drivers are understood.
- No unexpected resource remains deployed.

---

## Phase 13 - Final validation and project defense

Status: **Planned**

### Objectives

- Validate the complete repository.
- Prepare a reproducible technical demonstration.

### Implementation

- Review all documentation.
- Validate all links.
- Validate Terraform configurations.
- Review repository security.
- Review Git history.
- Sanitize evidence.
- Update architecture diagrams.
- Update phase statuses.
- Create final project summary.
- Create a demonstration script.
- Prepare architecture interview questions.
- Prepare troubleshooting interview scenarios.
- Complete final Azure cleanup.

### Evidence

- Final architecture diagram.
- Final repository tree.
- Successful validation results.
- Final cost report.
- Final cleanup report.
- Demonstration script.
- Project summary.

### Exit criteria

- Every repository component is understood.
- Every major claim has supporting evidence.
- No secret or sensitive identifier is exposed.
- The project can be demonstrated and explained.
- Temporary Azure resources are removed.
