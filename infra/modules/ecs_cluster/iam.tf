
data "aws_iam_policy" "AmazonECSTaskExecutionRolePolicy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy_document" "ecs_task_execution_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "ecs_task_execution_role"
  path               = "/system/"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_policy.json
}

resource "aws_iam_policy_attachment" "ecs_task_execution_policy" {
  name       = "ecs_task_execution_policy"
  roles      = [aws_iam_role.ecs_task_execution_role.id]
  policy_arn = data.aws_iam_policy.AmazonECSTaskExecutionRolePolicy.arn
}
