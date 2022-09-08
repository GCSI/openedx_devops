
data "template_file" "vpa-gcas" {
  template = file("${path.module}/yml/verticalpodautoscalers/vpa-gcas.yaml.tpl")
  vars = {
    environment_namespace = var.environment_namespace
  }
}

data "template_file" "vpa-gcas-worker" {
  template = file("${path.module}/yml/verticalpodautoscalers/vpa-gcas-worker.yaml.tpl")
  vars = {
    environment_namespace = var.environment_namespace
  }
}

resource "kubectl_manifest" "vpa-gcas" {
  yaml_body = data.template_file.vpa-gcas.rendered
}

resource "kubectl_manifest" "vpa-gcas-worker" {
  yaml_body = data.template_file.vpa-gcas-worker.rendered
}
