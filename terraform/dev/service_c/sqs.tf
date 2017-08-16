resource "aws_sqs_queue" "service_c" {
    name                       = "${var.environment}-service_c"
    visibility_timeout_seconds = 30
    message_retention_seconds  = 345600
    max_message_size           = 262144
    delay_seconds              = 0
    receive_wait_time_seconds  = 0
    redrive_policy             = <<POLICY
{
  "deadLetterTargetArn": "${aws_sqs_queue.service_c-deadletter.arn}",
  "maxReceiveCount": 3
}
POLICY
}

resource "aws_sqs_queue" "service_c-deadletter" {
    name                       = "${var.environment}-service_c-deadletter"
    visibility_timeout_seconds = 30
    message_retention_seconds  = 1209600
    max_message_size           = 262144
    delay_seconds              = 0
    receive_wait_time_seconds  = 0
}
