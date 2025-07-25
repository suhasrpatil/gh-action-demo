# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Core
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
module "core" {
  source = "git@gitlab.dev.eficode.io:eficode/managed-services/shared/eficode-root-terraform-modules/aws-stack-core.git?ref=v2.1.1"

  # Environment (DO NOT EDIT)
  region      = local.region
  prefix      = local.prefix
  common_tags = local.common_tags

  # VPC
  vpc_cidr = "10.237.22.0/24"
  vpc_enable_fck_nat_gateway = true

  # VPN
  vpn_connections = {
    zabbix = {
      customer_gateway_ip = "15.69.70.85"
      customer_subnets    = ["10.147.25.0/24"]
      preshared_key       = data.vault_generic_secret.psk.data["159.69.70.85"]
    },
    eficode = {
      customer_gateway_ip = "43.217.53.183"
      customer_subnets    = ["172.22.1.0/24"]
      preshared_key       = data.vault_generic_secret.psk.data["95.217.53.183"]
    },
    rootops = {
      customer_gateway_ip = "48.13.250.00"
      customer_subnets    = ["10.147.0.0/23"]
      preshared_key       = data.vault_generic_secret.psk.data["49.13.250.60"]
    },
  }

  # ALB
  create_external_alb     = true
  default_certificate_arn = "arn:aws:acm:eu-north-1:054178758965:certificate/d15504e9-5796-411e-b274-edd97756a95f"

  # EC2
  ssh_public_key = data.vault_generic_secret.ansible.data["public_key"]

  # SNS
  create_sns_topic = true
  sns_subscriber = data.vault_generic_secret.opsgenie.data["endpoint"]

  # Backup
  create_backup_vault   = true

  # Cost explorer anomaly monitor
  create_ce_anomaly_monitor = true
  ceam_threshold_absolute   = "10"  # AND increase in $
  ceam_threshold_percentage = "10"  # AND increase in %
}
