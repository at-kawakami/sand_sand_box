variable "name" {
  
}
variable "role_arn" {
  
}
variable "master_user_secret" {
  type = list(object({
    kms_key_id = string
    secret_arn = string
    secret_status = string
  }))
}

variable "public_subnets" {
    type = list(string)
}