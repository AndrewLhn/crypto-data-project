terraform {
  required_version = ">= 1.0"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Генерация случайных паролей (только если не указаны в переменных)
resource "random_password" "postgres_password" {
  length  = 16
  special = false
}

resource "random_password" "minio_password" {
  length  = 16
  special = false
}

locals {
  postgres_password = var.postgres_password != "" ? var.postgres_password : random_password.postgres_password.result
  minio_password    = var.minio_password != "" ? var.minio_password : random_password.minio_password.result
}

# Docker network
resource "docker_network" "crypto_network" {
  name   = "crypto_network_${var.environment}"
  driver = "bridge"
}

# PostgreSQL container
resource "docker_container" "postgres" {
  name  = "crypto_postgres_${var.environment}"
  image = "postgres:15-alpine"
  must_run = true
  
  networks_advanced {
    name = docker_network.crypto_network.name
  }
  
  ports {
    internal = 5432
    external = 5432
  }
  
  env = [
    "POSTGRES_DB=${var.postgres_db}",
    "POSTGRES_USER=${var.postgres_user}",
    "POSTGRES_PASSWORD=${local.postgres_password}"
  ]
  
  volumes {
    volume_name    = "postgres_data_${var.environment}"
    container_path = "/var/lib/postgresql/data"
  }
  
  healthcheck {
    test     = ["CMD-SHELL", "pg_isready -U ${var.postgres_user} -d ${var.postgres_db}"]
    interval = "30s"
    timeout  = "10s"
    retries  = 5
  }
}

# MinIO container
resource "docker_container" "minio" {
  name  = "crypto_minio_${var.environment}"
  image = "minio/minio:latest"
  command = ["server", "/data", "--console-address", ":9001"]
  must_run = true
  
  networks_advanced {
    name = docker_network.crypto_network.name
  }
  
  ports {
    internal = 9000
    external = 9000
  }
  
  ports {
    internal = 9001
    external = 9001
  }
  
  env = [
    "MINIO_ROOT_USER=${var.minio_user}",
    "MINIO_ROOT_PASSWORD=${local.minio_password}"
  ]
  
  volumes {
    volume_name    = "minio_data_${var.environment}"
    container_path = "/data"
  }
  
  healthcheck {
    test     = ["CMD", "curl", "-f", "http://localhost:9000/minio/health/live"]
    interval = "30s"
    timeout  = "20s"
    retries  = 3
  }
}

# MinIO Client to create buckets
resource "docker_container" "minio_client" {
  name  = "crypto_mc_${var.environment}"
  image = "minio/mc:latest"
  
  networks_advanced {
    name = docker_network.crypto_network.name
  }
  
  depends_on = [docker_container.minio]
  
  entrypoint = [
    "/bin/sh", "-c",
    "sleep 10 && \
     mc alias set myminio http://${docker_container.minio.name}:9000 ${var.minio_user} ${local.minio_password} && \
     mc mb myminio/crypto-raw --ignore-existing && \
     mc mb myminio/crypto-processed --ignore-existing && \
     mc anonymous set private myminio/crypto-raw && \
     mc anonymous set private myminio/crypto-processed && \
     echo 'Buckets created successfully'"
  ]
}

# Outputs
output "postgres_password" {
  value     = local.postgres_password
  sensitive = true
}

output "minio_password" {
  value     = local.minio_password
  sensitive = true
}

output "endpoints" {
  value = {
    postgres      = "localhost:5432"
    minio_api     = "localhost:9000"
    minio_console = "http://localhost:9001"
  }
}

output "container_names" {
  value = {
    postgres = docker_container.postgres.name
    minio    = docker_container.minio.name
  }
}
