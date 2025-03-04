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
resource "google_compute_firewall" "http-server" {
  name    = "${var.prefix}-default-allow-ssh-http"
  network = google_compute_network.hashicat.self_link

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }

  // Allow traffic from everywhere to instances with an http-server tag
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}
