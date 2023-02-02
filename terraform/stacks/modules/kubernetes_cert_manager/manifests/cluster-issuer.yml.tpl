#------------------------------------------------------------------------------
# written by: Miguel Afonso
#             https://www.linkedin.com/in/mmafonso/
#
# date: Aug-2021
#
# usage: setup SSL certs for EKS load balancer worker node instances.
#        see https://cert-manager.io/docs/
#------------------------------------------------------------------------------
---
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: service.global-communications-academy.com
  namespace: ${namespace}
spec:
  acme:
    email: no-reply@aube.university
    privateKeySecretRef:
      name: service.global-communications-academy.com
    server: https://acme-v02.api.letsencrypt.org/directory
    solvers:
      - dns01:
          # hosted Zone ID for the admin domain.
          route53:
            region: ${aws_region}
            hostedZoneID: ${hosted_zone_id}
