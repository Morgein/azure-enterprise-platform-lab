# Project Roadmap

This document defines the implementation sequence, current progress, expected deliverables, validation requirements, and completion criteria for Azure Enterprise Platform Lab.

The roadmap moves from local development fundamentals to a production-oriented Azure platform and then to advanced Platform Engineering, DevSecOps, SRE, Kubernetes, GitOps, reliability, disaster recovery, and FinOps scenarios.

---

## Current project status

| Field | Value |
|---|---|
| Overall completion | Approximately 46% |
| Deployable Azure Platform Foundation | Approximately 82% |
| Primary environment | Development |
| Primary region | Poland Central |
| Current runtime | Azure Container Apps |
| Infrastructure management | Terraform |
| Delivery platform | GitHub Actions |
| Authentication | GitHub OIDC and Managed Identity |
| Security validation | Trivy, Checkov, and Dependency Review |
| Current focus | Governance evidence, workload identity, and Key Vault |

### Progress calculation

| Phase | Progress |
|---|---:|
| Phase 0 | 100% |
| Phase 1 | 100% |
| Phase 2 | 100% |
| Phase 3 | 70% |
| Phase 4 | 100% |
| Phase 5 | 90% |
| Phase 6 | 0% |
| Phase 7 | 0% |
| Phase 8 | 90% |
| Phase 9 | 0% |
| Phase 10 | 0% |
| Phase 11 | 0% |
| Phase 12 | 0% |
| Phase 13 | 0% |

```text
(100 + 100 + 100 + 70 + 100 + 90 + 90) / 14 = 46.4%
```

The complete advanced roadmap is therefore considered approximately **46% complete**.

The currently deployable Azure Platform Foundation is considered approximately **82% complete** because the application, container, networking, remote state, identity, delivery, and security-scanning foundations are operational.

---

## Status definitions

- `Planned` — implementation has not started.
- `In progress` — implementation, testing, evidence, or documentation is active.
- `Completed` — implementation, validation, documentation, and evidence satisfy the defined exit criteria.
- `Evidence finalization` — the implementation is operational, but final screenshots, documentation, or advanced validation remain.
- `Reference design` — architecture is validated through Terraform configuration, plans, diagrams, ADRs, and runbooks without permanent deployment.
- `Controlled laboratory` — infrastructure is deployed only during a limited testing window because of cost.
- `Blocked` — implementation cannot continue until a documented dependency is resolved.

---

## Roadmap summary

| Phase | Scope | Status | Progress |
|---|---|---|---:|
| 0 | Repository and safety foundation | Completed | 100% |
| 1 | Application, tests, Docker, and CI | Completed | 100% |
| 2 | Terraform foundation and remote state | Completed | 100% |
| 3 | Governance and cost controls | In progress | 70% |
| 4 | Development Network Foundation | Completed | 100% |
| 5 | Azure Container Registry and Container Apps | Evidence finalization | 90% |
| 6 | Identity, Key Vault, Storage, and PostgreSQL | Planned | 0% |
| 7 | Azure API Management | Planned | 0% |
| 8 | GitHub Actions, OIDC, delivery, and security scanning | In progress | 90% |
| 9 | Observability and SRE | Planned | 0% |
| 10 | Azure Kubernetes Service and Helm | Planned | 0% |
| 11 | GitOps and progressive delivery | Planned | 0% |
| 12 | Reliability, disaster recovery, and FinOps | Planned | 0% |
| 13 | Final validation and project defense | Planned | 0% |

---

# Phase 0 — Repository and safety foundation

Status: **Completed**

Progress: **100%**

## Objectives

- Prepare the local engineering environment.
- Create a secure Git repository.
- Protect personal information and credentials.
- Establish project structure and working rules.
- Define initial cost-control requirements.

## Completed implementation

- [x] Verified Git installation.
- [x] Verified Docker installation.
- [x] Verified Terraform installation.
- [x] Verified GitHub CLI installation.
- [x] Configured Git author name.
- [x] Configured GitHub noreply author email.
- [x] Created the project repository structure.
- [x] Created `.gitignore`.
- [x] Created `.editorconfig`.
- [x] Created the initial README.
- [x] Created the project roadmap.
- [x] Created cost-control documentation.
- [x] Created initial Architecture Decision Records.
- [x] Created a public GitHub repository.
- [x] Established feature branches and Pull Requests.
- [x] Established GitHub CLI workflow.
- [x] Verified that no personal email was committed.

## Evidence

- tool version output;
- Docker `hello-world`;
- sanitized Git configuration;
- repository tree;
- initial Git commit;
- public GitHub repository;
- initial Pull Request workflow.

## Exit criteria

- [x] Repository is published.
- [x] No secret or personal email is committed.
- [x] Repository structure is documented.
- [x] Provisioning rules are documented.
- [x] Cost-control rules are documented.

---

# Phase 1 — Application, tests, Docker, and CI

Status: **Completed**

Progress: **100%**

## Objectives

- Create the application used throughout the project.
- Establish automated application validation.
- Build a hardened container image.
- Create a reliable Continuous Integration baseline.

## Completed implementation

- [x] Created a Python virtual environment.
- [x] Created a FastAPI application.
- [x] Added `/health/live`.
- [x] Added `/health/ready`.
- [x] Added `/api/v1/info`.
- [x] Added versioned API routing.
- [x] Added typed response models.
- [x] Added correlation ID middleware.
- [x] Added environment-based application configuration.
- [x] Added Pytest tests.
- [x] Achieved more than 97% test coverage.
- [x] Added Ruff formatting.
- [x] Added Ruff static analysis.
- [x] Created a multi-stage Dockerfile.
- [x] Added a non-root runtime user.
- [x] Added controlled ownership and permissions.
- [x] Added a Docker health check.
- [x] Added explicit Uvicorn startup configuration.
- [x] Built and tested the container locally.
- [x] Added Python CI validation.
- [x] Added container build validation.
- [x] Added hardened container smoke tests.
- [x] Added coverage artifact publication.

## Evidence

- successful Pytest output;
- coverage report;
- successful Docker build;
- non-root user validation;
- health endpoint responses;
- successful CI workflow;
- hardened container execution.

## Exit criteria

- [x] Unit tests pass.
- [x] Coverage exceeds the configured threshold.
- [x] Static analysis passes.
- [x] Container starts successfully.
- [x] Health endpoints work.
- [x] Application requires no embedded credentials.
- [x] Image runs as a non-root user.
- [x] CI blocks invalid Pull Requests.

---

# Phase 2 — Terraform foundation and remote state

Status: **Completed**

Progress: **100%**

## Objectives

- Establish reproducible Infrastructure as Code.
- Protect Terraform state.
- Create reusable Azure infrastructure patterns.
- Add automated Terraform validation.

## Completed implementation

- [x] Configured Terraform version constraints.
- [x] Configured AzureRM provider constraints.
- [x] Added provider dependency lock files.
- [x] Created reusable Terraform patterns.
- [x] Created common variables and locals.
- [x] Created deterministic naming.
- [x] Created common resource tags.
- [x] Created the backend bootstrap root module.
- [x] Created the backend Resource Group.
- [x] Created the backend Storage Account.
- [x] Created the private state Blob Container.
- [x] Enabled Blob versioning.
- [x] Enabled soft-delete recovery.
- [x] Disabled shared-key access.
- [x] Configured Microsoft Entra backend authentication.
- [x] Configured partial backend configuration.
- [x] Migrated development state to Azure Blob Storage.
- [x] Verified Blob lease state locking.
- [x] Documented backend recovery.
- [x] Added recursive Terraform formatting validation.
- [x] Added matrix-based Terraform validation.
- [x] Added read-only lock-file enforcement.
- [x] Added backend-aware CI initialization.

## Evidence

- Terraform formatting result;
- Terraform validation result;
- bootstrap plan;
- backend apply;
- remote state verification;
- state-locking behavior;
- no-drift plan;
- backend recovery documentation.

## Exit criteria

- [x] Terraform initializes successfully.
- [x] Remote state is protected.
- [x] State is not committed to Git.
- [x] Provider versions are constrained.
- [x] Provider versions are locked.
- [x] State locking is operational.
- [x] Clean Terraform plans can be produced.
- [x] Backend recovery is documented.

---

# Phase 3 — Governance and cost controls

Status: **In progress**

Progress: **70%**

## Objectives

- Create consistent Azure resource organization.
- Establish resource ownership.
- Control regional placement.
- Add budget and cleanup controls.
- Make cost decisions visible and reviewable.

## Completed implementation

- [x] Created a dedicated development Resource Group.
- [x] Defined naming conventions.
- [x] Added deterministic Terraform naming.
- [x] Added common project tags.
- [x] Added `Environment` tags.
- [x] Added `ManagedBy` tags.
- [x] Added `Project` tags.
- [x] Added `CostProfile=StudentLab`.
- [x] Restricted deployment to an allowed region.
- [x] Documented cost-control requirements.
- [x] Selected low-cost ACR configuration.
- [x] Selected scale-to-zero Container Apps configuration.
- [x] Bounded Container Apps maximum replicas.
- [x] Deferred expensive services to controlled windows.
- [x] Documented cost-based Checkov exceptions.
- [x] Created a reusable Terraform Governance module.
- [x] Created a subscription-level Azure Cost Management Budget.
- [x] Configured a EUR 10 monthly spending threshold.
- [x] Added Actual Cost alerts at 50%, 75%, and 90%.
- [x] Added a Forecasted Cost alert at 100%.
- [x] Stored notification recipients outside the Git repository.
- [x] Added non-sensitive Governance outputs.
- [x] Verified the Budget through Terraform state.
- [x] Verified the Budget in Azure Portal.
- [x] Captured sanitized Budget evidence.
- [x] Verified a post-deployment no-drift plan.

## Remaining implementation

- [ ] Add selected Azure Policy definitions.
- [ ] Document Azure Policy exemptions.
- [ ] Create resource expiration rules.
- [ ] Create orphan-resource checks.
- [ ] Create a formal resource ownership matrix.
- [ ] Add scheduled cost review.
- [ ] Create a cleanup verification report.

## Evidence

- [Governance and Cost Controls Foundation](evidence/governance-cost-controls-foundation.md)

## Additional evidence requirements

- resource tags;
- allowed-region validation;
- budget alert;
- policy assignment;
- cost analysis;
- cleanup report.

## Exit criteria

- [ ] All resources contain required tags.
- [x] Budget alerts are configured.
- [ ] Resource ownership is documented.
- [ ] Policy behavior is tested.
- [ ] Cleanup rules are documented.
- [ ] Cost review is reproducible.

---

# Phase 4 — Development Network Foundation

Status: **Completed**

Progress: **100%**

## Objectives

- Create the development network baseline.
- Separate platform responsibilities by subnet.
- Add Network Security Groups.
- Prepare the network for Container Apps, APIM, data services, and private endpoints.

## Completed implementation

- [x] Created an IP address plan.
- [x] Created a reusable network Terraform module.
- [x] Created a `/16` Virtual Network.
- [x] Created the Container Apps subnet.
- [x] Created the API Management subnet.
- [x] Created the application subnet.
- [x] Created the data subnet.
- [x] Created the private-endpoints subnet.
- [x] Created the management subnet.
- [x] Created six Network Security Groups.
- [x] Associated NSGs with all subnets.
- [x] Added Container Apps subnet delegation.
- [x] Added sanitized Terraform outputs.
- [x] Created network architecture documentation.
- [x] Created deployment evidence.
- [x] Verified Portal configuration.
- [x] Verified Terraform state.
- [x] Verified no Terraform drift.

## Address plan

| Purpose | CIDR |
|---|---|
| Virtual Network | `10.20.0.0/16` |
| Container Apps | `10.20.0.0/23` |
| API Management | `10.20.2.0/24` |
| Application | `10.20.3.0/24` |
| Data | `10.20.4.0/24` |
| Private Endpoints | `10.20.5.0/24` |
| Management | `10.20.6.0/24` |

## Evidence

- [Development Network Architecture](architecture/development-network.md)
- [Development Network Evidence](evidence/development-network-foundation.md)

## Exit criteria

- [x] Address ranges do not overlap.
- [x] Subnets have documented responsibilities.
- [x] NSGs are associated correctly.
- [x] Container Apps delegation is configured.
- [x] Terraform state contains expected resources.
- [x] Post-deployment plan reports no drift.

---

# Phase 5 — Azure Container Registry and Container Apps

Status: **Evidence finalization**

Progress: **90%**

## Objectives

- Publish trusted container images.
- Deploy the application to a low-cost Azure runtime.
- Use identity-based registry authentication.
- Configure scaling and health validation.
- Establish revision-based application delivery.

## Completed implementation

- [x] Created a reusable Container Registry module.
- [x] Created an ACR Basic registry.
- [x] Disabled ACR Admin user.
- [x] Disabled anonymous pull.
- [x] Built the FastAPI image.
- [x] Added semantic and commit-based image tags.
- [x] Pushed the image to ACR.
- [x] Recorded image digests.
- [x] Created a reusable Container Apps module.
- [x] Created a Container Apps Environment.
- [x] Integrated the environment with the delegated subnet.
- [x] Created a runtime managed identity.
- [x] Assigned `AcrPull`.
- [x] Configured registry authentication through Managed Identity.
- [x] Created the Container App.
- [x] Configured external HTTPS ingress.
- [x] Configured target port `8000`.
- [x] Configured `APP_ENV=dev`.
- [x] Configured CPU and memory limits.
- [x] Configured minimum replicas `0`.
- [x] Configured maximum replicas `1`.
- [x] Configured liveness behavior.
- [x] Configured readiness behavior.
- [x] Verified stable application FQDN.
- [x] Verified Container Apps revisions.
- [x] Verified runtime endpoints.
- [x] Verified Terraform no-drift.
- [x] Created deployment evidence.
- [x] Added container vulnerability scanning.
- [x] Added container secret scanning.

## Remaining implementation

- [ ] Demonstrate revision traffic splitting.
- [ ] Demonstrate controlled rollback.
- [ ] Record rollback evidence.
- [ ] Review revision retention behavior.
- [ ] Add signed container images.
- [ ] Finalize cost evidence.

## Evidence

- [Container Platform Foundation](evidence/container-platform-foundation.md)

## Exit criteria

- [x] Image is pulled without registry passwords.
- [x] API is publicly reachable.
- [x] Health endpoints pass.
- [x] Application can scale to zero.
- [x] Maximum replicas are bounded.
- [x] Image digest is recorded.
- [x] Image vulnerability scanning is enforced.
- [ ] Revision rollback is demonstrated.
- [ ] Traffic splitting is demonstrated.
- [ ] Image signing is demonstrated.

---

# Phase 6 — Identity, Key Vault, Storage, and PostgreSQL

Status: **Planned**

Progress: **0%**

Deployment model: **Mixed permanent and controlled laboratory**

## Objectives

- Remove static application credentials.
- Store secrets in Azure Key Vault.
- Add identity-based Blob Storage access.
- Add a relational data service during a controlled laboratory window.
- Document backup and recovery behavior.

## Planned implementation

- [ ] Create a reusable Key Vault module.
- [ ] Configure Key Vault RBAC.
- [ ] Assign least-privilege secret access.
- [ ] Test application secret retrieval.
- [ ] Test denied unauthorized access.
- [ ] Configure secret rotation.
- [ ] Create an application Storage Account.
- [ ] Create a private Blob Container.
- [ ] Configure identity-based Blob access.
- [ ] Test Blob upload.
- [ ] Test Blob download.
- [ ] Test denied Blob access.
- [ ] Review PostgreSQL pricing.
- [ ] Review PostgreSQL regional availability.
- [ ] Create a controlled PostgreSQL Terraform module.
- [ ] Configure network access.
- [ ] Configure application database access.
- [ ] Add database migrations.
- [ ] Configure connection pooling.
- [ ] Review backup retention.
- [ ] Test restore procedures.
- [ ] Destroy temporary PostgreSQL resources after validation.

## Evidence requirements

- Managed Identity configuration;
- Key Vault RBAC;
- successful secret retrieval;
- denied secret access;
- successful Blob operation;
- denied Blob operation;
- PostgreSQL connection;
- migration output;
- backup configuration;
- restore documentation;
- cleanup evidence.

## Exit criteria

- [ ] No application secret is committed.
- [ ] Azure services use Managed Identity where supported.
- [ ] Data access follows least privilege.
- [ ] Unauthorized operations are denied.
- [ ] Database access is controlled.
- [ ] Recovery procedures are documented.
- [ ] Temporary expensive resources are removed.

---

# Phase 7 — Azure API Management

Status: **Planned**

Progress: **0%**

Deployment model: **Cost-reviewed controlled deployment**

## Objectives

- Place a governed API Gateway in front of the application.
- Introduce authentication, throttling, transformation, versioning, and Policy as Code.
- Demonstrate the role of an enterprise API Gateway.

## Planned implementation

- [ ] Review available APIM SKUs.
- [ ] Review Azure for Students restrictions.
- [ ] Review Poland Central availability.
- [ ] Create an APIM Terraform module.
- [ ] Deploy a cost-appropriate APIM instance.
- [ ] Import the FastAPI OpenAPI specification.
- [ ] Create API operations.
- [ ] Create API products.
- [ ] Configure subscriptions.
- [ ] Configure API versioning.
- [ ] Integrate Microsoft Entra ID.
- [ ] Add JWT validation.
- [ ] Add rate limits.
- [ ] Add quotas.
- [ ] Add CORS policies.
- [ ] Add request transformations.
- [ ] Add response transformations.
- [ ] Add backend routing.
- [ ] Add correlation ID propagation.
- [ ] Add sanitized error handling.
- [ ] Add safe caching where appropriate.
- [ ] Add controlled retries and timeouts.
- [ ] Store APIM policies in Git.
- [ ] Automate policy deployment.
- [ ] Test `401`, `403`, and `429` responses.
- [ ] Document APIM cost and cleanup.

## Evidence requirements

- APIM overview;
- imported OpenAPI definition;
- API operations;
- product configuration;
- successful API request;
- authentication failure;
- authorization failure;
- throttling response;
- policy transformation;
- backend failure handling;
- policy source files;
- cost evidence.

## Exit criteria

- [ ] APIM is the documented public entry point.
- [ ] Authentication works.
- [ ] Throttling works.
- [ ] Policies are stored as code.
- [ ] Backend errors are sanitized.
- [ ] API behavior matches the OpenAPI contract.
- [ ] Cost impact is documented.

---

# Phase 8 — GitHub Actions, OIDC, application delivery, and security scanning

Status: **In progress**

Progress: **90%**

## Objectives

- Automate application and infrastructure validation.
- Remove long-lived Azure credentials.
- Deploy only verified application commits.
- Establish an auditable CI/CD process.
- Enforce container, dependency, secret, and Infrastructure as Code security validation.

## Completed implementation

### Continuous Integration

- [x] Created Pull Request CI.
- [x] Created main-branch CI.
- [x] Added Python formatting validation.
- [x] Added static analysis.
- [x] Added tests and coverage.
- [x] Added Docker build validation.
- [x] Added hardened container smoke tests.
- [x] Added Terraform formatting validation.
- [x] Added Terraform root-module validation.
- [x] Added provider lock-file enforcement.

### Identity and Continuous Deployment

- [x] Created a protected GitHub Environment.
- [x] Created a separate deployment identity.
- [x] Configured GitHub OIDC.
- [x] Added immutable GitHub repository identity.
- [x] Restricted deployment access to the `development` environment.
- [x] Assigned resource-scoped Azure roles.
- [x] Added manual Continuous Deployment.
- [x] Added automatic CI-gated deployment.
- [x] Added deployable change detection.
- [x] Validated documentation-only deployment skipping.
- [x] Added exact verified commit checkout.
- [x] Added Docker Buildx.
- [x] Added GitHub Actions build cache.
- [x] Added BuildKit provenance.
- [x] Added Software Bill of Materials generation.
- [x] Added immutable commit tags.
- [x] Added digest-based Container Apps deployment.
- [x] Added deployment smoke tests.
- [x] Added GitHub deployment summaries.
- [x] Documented OIDC troubleshooting.
- [x] Documented change-detection troubleshooting.
- [x] Created Continuous Deployment evidence.

### Security Scanning Foundation

- [x] Created a dedicated Security Scanning workflow.
- [x] Added Trivy container vulnerability scanning.
- [x] Added Trivy secret scanning.
- [x] Added Checkov Terraform scanning.
- [x] Added a blocking Checkov policy gate.
- [x] Added GitHub Dependency Review.
- [x] Enabled GitHub Dependency Graph.
- [x] Added SARIF report generation.
- [x] Added SARIF upload to GitHub Code Scanning.
- [x] Added weekly scheduled security scans.
- [x] Added manual security workflow execution.
- [x] Added path-aware Pull Request scanning.
- [x] Added least-privilege workflow permissions.
- [x] Pinned third-party GitHub Actions to immutable commit SHAs.
- [x] Pinned the Checkov CLI version.
- [x] Reviewed all reported Terraform findings.
- [x] Documented narrowly scoped Checkov Policy Exceptions.
- [x] Documented compensating security controls.
- [x] Preserved blocking behavior for unapproved findings.
- [x] Created Security Scanning evidence.

## Checkov validation summary

| Result | Count |
|---|---:|
| Passed checks | 23 |
| Failed checks | 0 |
| Documented skipped checks | 20 |

The skipped checks are explicit, narrowly scoped Policy Exceptions. They represent cost limitations, platform constraints, unsupported enterprise features, or false positives caused by separate Terraform association resources.

New or undocumented findings continue to fail the Pull Request security gate.

## Remaining implementation

- [ ] Publish Terraform plan artifacts.
- [ ] Add protected Terraform apply.
- [ ] Add scheduled Terraform drift detection.
- [ ] Add controlled cleanup workflow.
- [ ] Add production GitHub Environment.
- [ ] Add required production reviewers.
- [ ] Add deployment rollback automation.
- [ ] Add unauthorized deployment test evidence.
- [ ] Add container image signing and verification.
- [ ] Add application-focused SAST.
- [ ] Review GitHub branch protection requirements.

## Evidence

- [Continuous Deployment Foundation](evidence/continuous-deployment-foundation.md)
- [Security Scanning Foundation](evidence/security-scanning-foundation.md)

## Exit criteria

- [x] GitHub contains no Azure client secret.
- [x] OIDC uses short-lived tokens.
- [x] Pull Requests cannot deploy directly.
- [x] Deployed artifact is linked to a commit.
- [x] Digest-based deployment is operational.
- [x] Failed CI prevents deployment.
- [x] Failed smoke tests fail the workflow.
- [x] Documentation-only changes do not trigger unnecessary deployment.
- [x] Container vulnerability scanning is enforced.
- [x] Container secret scanning is enforced.
- [x] Terraform security scanning is enforced.
- [x] Dependency Review is enforced.
- [x] Security findings are visible through SARIF.
- [x] Security scanning is enforced.
- [ ] Protected Terraform apply is implemented.
- [ ] Production approval is implemented.
- [ ] Container image signing is implemented.

---

# Phase 9 — Observability and SRE

Status: **Planned**

Progress: **0%**

## Objectives

- Make application and infrastructure behavior observable.
- Add metrics, structured logs, traces, dashboards, alerts, and SLOs.
- Control telemetry ingestion cost.

## Planned implementation

- [ ] Create a Log Analytics Workspace.
- [ ] Create Application Insights.
- [ ] Configure Container Apps diagnostic settings.
- [ ] Add structured JSON logging.
- [ ] Instrument FastAPI with OpenTelemetry.
- [ ] Propagate trace context.
- [ ] Record deployment version telemetry.
- [ ] Add dependency traces.
- [ ] Create KQL queries.
- [ ] Create an operations dashboard.
- [ ] Create availability tests.
- [ ] Create metric alerts.
- [ ] Create log alerts.
- [ ] Create alert runbooks.
- [ ] Define application SLIs.
- [ ] Define a learning SLO.
- [ ] Define an error budget.
- [ ] Review ingestion cost.
- [ ] Add log-retention controls.
- [ ] Verify sensitive values are not logged.

## Evidence requirements

- Application Insights overview;
- metrics;
- structured logs;
- distributed trace;
- dependency trace;
- KQL queries;
- dashboard;
- alert notification;
- runbook;
- SLI and SLO calculation;
- cost review.

## Exit criteria

- [ ] Requests can be traced end to end.
- [ ] Deployment versions are visible.
- [ ] Alerts are actionable.
- [ ] Alerts have owners and runbooks.
- [ ] Sensitive values are not logged.
- [ ] Ingestion remains within budget.

---

# Phase 10 — Azure Kubernetes Service and Helm

Status: **Planned**

Progress: **0%**

Deployment model: **Temporary controlled laboratory**

## Objectives

- Deploy the application to managed Kubernetes.
- Demonstrate Kubernetes networking, security, scaling, identity, and operations.
- Package the application with Helm.

## Planned implementation

- [ ] Review AKS regional availability.
- [ ] Review AKS quota requirements.
- [ ] Review AKS cost.
- [ ] Create a temporary AKS cluster.
- [ ] Configure a system node pool.
- [ ] Integrate AKS with ACR.
- [ ] Create namespaces.
- [ ] Create a Helm chart.
- [ ] Create a Kubernetes Deployment.
- [ ] Create a Kubernetes Service.
- [ ] Configure ingress.
- [ ] Configure liveness probes.
- [ ] Configure readiness probes.
- [ ] Configure resource requests.
- [ ] Configure resource limits.
- [ ] Configure Pod Security Context.
- [ ] Configure Pod Disruption Budget.
- [ ] Configure Horizontal Pod Autoscaler.
- [ ] Configure Workload Identity.
- [ ] Integrate Key Vault.
- [ ] Add Network Policies.
- [ ] Test rolling update.
- [ ] Test rollback.
- [ ] Review cluster upgrades.
- [ ] Destroy the AKS cluster after evidence collection.

## Evidence requirements

- cluster overview;
- node status;
- namespace status;
- Helm release;
- pod status;
- service status;
- ingress status;
- HPA behavior;
- Workload Identity;
- Network Policy;
- rolling update;
- rollback;
- cleanup.

## Exit criteria

- [ ] Application runs in AKS.
- [ ] Helm manages the release.
- [ ] Workloads contain no Azure credentials.
- [ ] Health probes work.
- [ ] Scaling is demonstrated.
- [ ] Network access is restricted.
- [ ] Rolling update and rollback work.
- [ ] Temporary cluster is removed.

---

# Phase 11 — GitOps and progressive delivery

Status: **Planned**

Progress: **0%**

## Objectives

- Reconcile workload state from Git.
- Detect and correct drift.
- Demonstrate progressive delivery and Git-based rollback.

## Planned implementation

- [ ] Select Argo CD or Flux.
- [ ] Document the selection through an ADR.
- [ ] Install the GitOps controller.
- [ ] Connect the deployment repository or directory.
- [ ] Configure application synchronization.
- [ ] Configure health assessment.
- [ ] Test manual synchronization.
- [ ] Test automatic synchronization.
- [ ] Introduce manual drift.
- [ ] Verify drift detection.
- [ ] Verify reconciliation.
- [ ] Configure canary or traffic splitting.
- [ ] Test failed deployment behavior.
- [ ] Test Git-based rollback.
- [ ] Document break-glass access.
- [ ] Document controller permissions.
- [ ] Remove temporary GitOps resources.

## Evidence requirements

- GitOps application status;
- synchronization result;
- drift detection;
- drift correction;
- progressive delivery;
- failed deployment;
- Git rollback;
- break-glass runbook.

## Exit criteria

- [ ] Git defines expected workload state.
- [ ] Manual drift is detected.
- [ ] Reconciliation is demonstrated.
- [ ] Progressive delivery is demonstrated.
- [ ] Rollback through Git is demonstrated.
- [ ] Emergency access is documented.

---

# Phase 12 — Reliability, disaster recovery, and FinOps

Status: **Planned**

Progress: **0%**

## Objectives

- Validate platform behavior during failure.
- Measure recovery.
- Test scaling.
- Review service cost.
- Verify cleanup.

## Planned implementation

- [ ] Define RTO examples.
- [ ] Define RPO examples.
- [ ] Create k6 load tests.
- [ ] Establish a performance baseline.
- [ ] Test Container Apps autoscaling.
- [ ] Test AKS autoscaling.
- [ ] Simulate application failures.
- [ ] Simulate dependency failures.
- [ ] Test retry behavior.
- [ ] Test timeout behavior.
- [ ] Test failed revision rollback.
- [ ] Test Blob version recovery.
- [ ] Test PostgreSQL restore.
- [ ] Create an incident timeline.
- [ ] Create an incident report.
- [ ] Create a postmortem.
- [ ] Review cost by Azure service.
- [ ] Compare Container Apps and AKS cost.
- [ ] Identify orphan resources.
- [ ] Verify complete cleanup.
- [ ] Produce a final FinOps report.

## Evidence requirements

- k6 results;
- scaling graph;
- failure injection;
- recovery timing;
- Blob recovery;
- PostgreSQL restore;
- incident report;
- postmortem;
- service cost comparison;
- cleanup report.

## Exit criteria

- [ ] Failure behavior is documented.
- [ ] Recovery time is measured.
- [ ] Recovery procedures are tested.
- [ ] Scaling limits are understood.
- [ ] Cost drivers are understood.
- [ ] No unexpected resources remain.

---

# Phase 13 — Final validation and project defense

Status: **Planned**

Progress: **0%**

## Objectives

- Validate the complete repository.
- Prepare a reproducible technical demonstration.
- Prepare the project for Cloud, DevOps, Platform, DevSecOps, and SRE interviews.

## Planned implementation

- [ ] Review all documentation.
- [ ] Validate Markdown links.
- [ ] Validate Mermaid diagrams.
- [ ] Validate Terraform configurations.
- [ ] Validate GitHub Actions workflows.
- [ ] Review repository security.
- [ ] Review Git history.
- [ ] Review committed author emails.
- [ ] Review evidence sanitization.
- [ ] Update architecture diagrams.
- [ ] Update all phase statuses.
- [ ] Create a final project summary.
- [ ] Create a demonstration script.
- [ ] Create an architecture walkthrough.
- [ ] Create interview questions.
- [ ] Create troubleshooting scenarios.
- [ ] Create a final cost report.
- [ ] Complete Azure cleanup.
- [ ] Create a cleanup verification report.
- [ ] Tag the final repository release.

## Evidence requirements

- final architecture diagram;
- final repository tree;
- successful validation output;
- final security review;
- final cost report;
- final cleanup report;
- demonstration script;
- project summary;
- tagged GitHub release.

## Exit criteria

- [ ] Every repository component is understood.
- [ ] Every major claim has evidence.
- [ ] No secret or sensitive identifier is exposed.
- [ ] Infrastructure is reproducible.
- [ ] Temporary resources are removed.
- [ ] Architecture can be explained.
- [ ] Troubleshooting scenarios can be demonstrated.
- [ ] Project is ready for technical defense.

---

## Phase dependencies

| Phase | Depends on |
|---|---|
| 0 | None |
| 1 | Phase 0 |
| 2 | Phase 0 |
| 3 | Phases 0 and 2 |
| 4 | Phases 2 and 3 |
| 5 | Phases 1, 2, and 4 |
| 6 | Phases 3, 4, and 5 |
| 7 | Phases 4, 5, and 6 |
| 8 | Phases 1, 2, and 5 |
| 9 | Phases 5 and 8 |
| 10 | Phases 2, 4, 5, 6, and 8 |
| 11 | Phases 8 and 10 |
| 12 | Phases 5, 6, 9, 10, and 11 |
| 13 | All previous phases |

---

## Cost classification

| Classification | Meaning | Examples |
|---|---|---|
| Low permanent cost | May remain deployed with monitoring | Terraform backend, ACR Basic |
| Scale-to-zero | Remains deployed but compute can stop | Azure Container Apps |
| Controlled laboratory | Deploy, test, document, destroy | PostgreSQL, APIM, AKS |
| Reference design | Validate without permanent deployment | Expensive production topology |
| Free control plane | No separate Azure service charge expected | GitHub OIDC, Federated Identity Credential |
| CI security control | Executes on GitHub-hosted runners | Trivy, Checkov, Dependency Review |

---

## Immediate execution plan

The next tasks are:

1. finalize the Governance and Cost Controls evidence Pull Request;
2. merge the validated Subscription Budget configuration into `main`;
3. create the Azure Key Vault Terraform module;
4. configure Managed Identity access to Key Vault;
5. create identity-based application Blob Storage;
6. add container image signing and application SAST;
7. add protected Terraform plan and apply workflows;
8. add scheduled Terraform drift detection;
9. demonstrate Container Apps rollback and traffic splitting;
10. prepare the Azure API Management controlled deployment.

---

## Near-term milestone

The next major milestone is the **Secure Application Platform Foundation**.

It will be achieved when:

- [x] the application is tested and containerized;
- [x] the container runs as a non-root user;
- [x] infrastructure is managed by Terraform;
- [x] Terraform state is stored remotely;
- [x] the development network is deployed;
- [x] ACR stores the application image;
- [x] Container Apps runs the application;
- [x] ACR authentication uses Managed Identity;
- [x] GitHub authenticates to Azure using OIDC;
- [x] CI validates application and Terraform changes;
- [x] CD deploys verified immutable artifacts;
- [x] container security scanning is enforced;
- [x] Terraform security scanning is enforced;
- [x] dependency changes are reviewed;
- [ ] Key Vault provides application secrets;
- [ ] Blob Storage access uses Managed Identity;
- [x] budget alerts and governance evidence are complete.

---

## Definition of project completion

Azure Enterprise Platform Lab is complete only when:

- every phase has a final status;
- every major claim has evidence;
- application tests pass;
- Terraform configurations validate;
- remote state is protected;
- no secrets are committed;
- CI/CD operates without Azure client secrets;
- image and infrastructure security scans are reviewed;
- unapproved security findings block Pull Requests;
- container images are signed and verified;
- Key Vault and data access use Managed Identity;
- APIM policies are tested;
- telemetry is observable;
- alerts have runbooks;
- AKS and Helm are demonstrated;
- GitOps reconciliation is demonstrated;
- scaling and rollback are tested;
- backup and restore are tested;
- costs are documented;
- temporary resources are removed;
- the complete architecture can be explained and defended.