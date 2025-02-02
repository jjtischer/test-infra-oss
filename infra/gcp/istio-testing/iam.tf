# TODO: this role exists, but for some reason the terraform import is broken.
# We can probably just not use roles and inline the permissions now anyways once we move everything over to terraform.
#resource "google_project_iam_custom_role" "e2e_testing" {
#  description = "Created on: 2017-07-17"
#  permissions = [
#    "logging.exclusions.get",
#    "logging.exclusions.list",
#    "logging.logEntries.list",
#    "logging.logMetrics.get",
#    "logging.logMetrics.list",
#    "logging.logServiceIndexes.list",
#    "logging.logServices.list",
#    "logging.logs.list",
#    "logging.sinks.get",
#    "logging.sinks.list",
#    "logging.usage.get",
#    "stackdriver.projects.get",
#    "storage.objects.create",
#    "storage.objects.delete",
#    "storage.objects.get",
#    "storage.objects.list",
#    "storage.objects.update",
#  ]
#  project = local.project_id
#  role_id = "CustomRole"
#  stage   = "GA"
#  title   = "E2E Testing"
#}

## Misc Service Accounts
# Used by policy bot.
resource "google_service_account" "istio_policy_bot" {
  account_id   = "istio-policy-bot"
  display_name = "Istio Policy Bot"
  project      = "istio-testing"
}
# Unknown usage but it is in use. TODO: find what it is.
resource "google_service_account" "istio_health_metrics" {
  account_id   = "istio-health-metrics"
  display_name = "istio-health-metrics"
  project      = "istio-testing"
}

## Prow Job Service Accounts ##
# Used with WI as the "prowjob-default-sa" service account. This is the default for jobs
resource "google_service_account" "istio_prow_test_job_default" {
  account_id   = "istio-prow-test-job-default"
  description  = "Default service account used by Istio Prow jobs"
  display_name = "istio-prow-test-job-default"
  project      = "istio-testing"
}
# Used with WI as the "prowjob-private-sa" service account. This is the default for jobs in the private clusters
resource "google_service_account" "istio_prow_test_job_private" {
  account_id   = "istio-prow-test-job-private"
  description  = "Default service account used by Istio private Prow jobs."
  display_name = "istio-prow-test-job-private"
  project      = "istio-testing"
}
# Used with WI as the "prowjob-advanced-sa" service account. This is used for jobs that need elevated permissions
resource "google_service_account" "istio_prow_test_job" {
  account_id   = "istio-prow-test-job"
  display_name = "Istio Prow Test Job Service Account"
  project      = "istio-testing"
}
# Used for WI in test-infra trusted jobs
# This is now obsolete (6/21/23) but will be kept around during migration.
resource "google_service_account" "gencred_refresher" {
  account_id   = "gencred-refresher"
  description  = "The service account used by Prow jobs for rotating build cluster kubeconfig"
  display_name = "gencred-refresher"
  project      = "istio-testing"
}
# Used for WI in test-infra trusted jobs
resource "google_service_account" "prow_deployer" {
  account_id   = "prow-deployer"
  description  = "Used to deploy to the clusters in the istio-testing and istio-prow-build projects."
  display_name = "Prow Self Deployer SA"
  project      = "istio-testing"
}
# Used for WI in test-infra trusted jobs
resource "google_service_account" "testgrid_updater" {
  account_id   = "testgrid-updater"
  description  = "Service account to upload istio's TestGrid info to cloud storage"
  display_name = "testgrid-updater"
  project      = "istio-testing"
}


## Prow Infra Service Accounts ##
# Used for WI for external secrets deployment
resource "google_service_account" "kubernetes_external_secrets_sa" {
  account_id   = "kubernetes-external-secrets-sa"
  display_name = "kubernetes-external-secrets-sa"
  project      = "istio-testing"
}
# Used for WI for prow control plane deployment
resource "google_service_account" "prow_control_plane" {
  account_id   = "prow-control-plane"
  description  = "Used by prow components"
  display_name = "prow-control-plane"
  project      = "istio-testing"
}