check "kafka_cluster_health" {
  data "external" "kafka_cluster_health" {
    program = ["bash", "${path.module}/check.sh"]
  }

  assert {
    condition     = data.external.kafka_cluster_health.result.status == "ready"
    error_message = "not needed"
  }
}
