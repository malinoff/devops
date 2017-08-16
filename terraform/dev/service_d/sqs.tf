resource "aws_sqs_queue" "service_d" {
  name = "${var.environment}-service_d"
  visibility_timeout_seconds = 600
  message_retention_seconds = 345600
  max_message_size = 262144
  delay_seconds = 0
  receive_wait_time_seconds = 0
  redrive_policy = <<POLICY
{
  "deadLetterTargetArn": "${aws_sqs_queue.service_d-deadletter.arn}",
  "maxReceiveCount": 5
}
POLICY
}

resource "aws_sqs_queue" "service_d-deadletter" {
  name = "${var.environment}-service_d-deadletter"
  visibility_timeout_seconds = 30
  message_retention_seconds = 1209600
  max_message_size = 262144
  delay_seconds = 0
  receive_wait_time_seconds = 0
}
