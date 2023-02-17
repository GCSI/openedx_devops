#------------------------------------------------------------------------------
# written by: Lawrence McDaniel
#             https://lawrencemcdaniel.com/
#
# date: Feb-2023
#
# usage: create client parameters for a single Wordpress site.
#------------------------------------------------------------------------------
locals {
  wp_hosted_zone_id   = "Z064431917WGFKESPTVUT"
  wp_domain           = "global-communications-academy.com"
  wp_subdomain        = "help"
  wp_namespace        = "codlp-wordpress"
  wp_username         = "codlp_staging_wp"
  wp_email            = "wordpress_admin@global-communications-academy.com"
  wp_user_firstname   = "Pat"
  wp_user_lastname    = "McGuire"
  wp_blog_name        = "CODLP Wordpress Site"
  wp_database_user    = "codlp_staging_wp"
  wp_database         = "codlp_staging_wp"
  wp_disk_volume_size = "10Gi"
  phpmyadmin          = "N"
}
