resource "aws_s3_object" "upload_file" {
    bucket = var.bucket_name
    key = "dev/${var.file_name}.zip"
    source = "../lambda/${var.file_name}.zip"
}
terraform {
  backend "s3" {
    bucket         = var.state_bucket_name
    key            = "dev/${var.file_name}/terraform.tfstate"      
    encrypt        = true
  }
}