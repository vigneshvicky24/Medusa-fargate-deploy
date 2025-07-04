terraform {
  backend "s3" {
    bucket         = "terraform-state-medusa-ap" # 🔁 new bucket name
    key            = "env:/terraform.tfstate"
    region         = "ap-south-1"               # ✅ your desired region
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
