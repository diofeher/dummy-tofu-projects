resource "null_resource" "operator-restarter" {

}

check "kafka_cluster_health" {
  data "external" "kafka_cluster_health" {
    program = ["bash", "${path.module}/check.sh"]
    depends_on = [
      null_resource.operator-restarter
    ]
  }

  assert {
    condition     = data.external.kafka_cluster_health.result.status == "ready"
    error_message = "not needed"
  }
}
