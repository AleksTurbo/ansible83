variable "yc_cloud_id" {
  description = "Cloud"
}
variable "yc_folder_id" {
  description = "Folder"
}
variable "yc_zone" {
  description = "Zone"
  default = "ru-central1-a"
}

variable "yc_image_family" {
  default = "centos-stream-8"
}


variable "service_account_key_file" {
  description = "key.json"
}


variable "metadata_file" {
  description = "Metadata file for ssh"
}

variable "sa_id" {
  description = "SERVICE ACCOUNT ID"
}

variable "login" {
  default = "ansible"
}

