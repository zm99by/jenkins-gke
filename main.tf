terraform {
  required_version = ">= 1.0.0"

  backend "gcs" {
    bucket = "your-terraform-state-bucket"
    prefix = "jenkins-gke"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = google_container_cluster.primary.endpoint
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
  token                  = data.google_client_config.default.access_token
}

# Модуль для создания GKE кластера
module "gke" {
  source  = "./modules/gke"
  project_id = var.project_id
  region     = var.region
  cluster_name = var.cluster_name
  node_count   = var.node_count
  machine_type = var.machine_type
}

# Модуль для развёртывания Jenkins
module "jenkins" {
  source  = "./modules/jenkins"
  namespace = "jenkins"
}

# Модуль для Kubernetes ресурсов (например, Secret)
module "kubernetes" {
  source  = "./modules/kubernetes"
  namespace = "jenkins"
  jenkins_admin_password = module.jenkins.admin_password
}

