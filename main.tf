provider "google" {
  project = "newproject-450616"
  region  = "us-central1"  
}

# Generate a random ID to append to the bucket name
resource "random_id" "bucket_suffix" {
  byte_length = 7
}

# Create a Cloud Storage Bucket
resource "google_storage_bucket" "my_bucket" {
  name     = "my-terraform-bucket-${random_id.bucket_suffix.hex}"
  location = "US"
}
resource "google_compute_instance" "my_vm" {
  name         = "my-terraform-vm-${random_id.vm_suffix.hex}"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }
}
