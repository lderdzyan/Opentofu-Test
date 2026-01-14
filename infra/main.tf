resource "aws_s3_object" "upload_file" {
    bucket = var.bucket_name
    key = "${var.folder_name}/${var.file_name}.zip"
    source = "../lambda/${var.file_name}"
}
