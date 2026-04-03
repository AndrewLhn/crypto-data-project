variable "postgres_user" {
  description = "PostgreSQL username"
  type        = string
  sensitive   = true
}

variable "postgres_password" {
  description = "PostgreSQL password"
  type        = string
  sensitive   = true
}

variable "postgres_db" {
  description = "PostgreSQL database name"
  type        = string
  default     = "crypto_db"
}

variable "minio_user" {
  description = "MinIO username"
  type        = string
  sensitive   = true
}

variable "minio_password" {
  description = "MinIO password"
  type        = string
  sensitive   = true
}

variable "environment" {
  description = "Environment name (dev/staging/prod)"
  type        = string
  default     = "dev"
}
