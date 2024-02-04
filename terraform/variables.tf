variable "environment" {
  description = "Run Environment"
  type = string
  default = "prod"
}

variable "az_us_east_1" {
  description = "abc to match naming convention for availability zones and subnets"
  type = map(string)
  default = {
    a = "us-east-1a"
    b = "us-east-1b"
    c = "us-east-1c"
} 
} 
