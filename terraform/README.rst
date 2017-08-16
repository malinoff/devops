Fairly complex terraform templates example
------------------------------------------

Let's imagine we have 4 services:

* service_a, requiring a couple of DynamoDB tables and an RDS instance;
* service_b, requiring an ElastiCache and an RDS instances;
* service_c, requiring a couple of SQS queues and an RDS instance;
* service_d, requiring a couple of DynamoDB tables, a couple of SQS queues
  and an ElastiCache instance;
  
deployed on 3 environments:

* dev,
* stg, and
* prod.

For bravity and simplicity, all these environments
are in the same VPC, but using different subnets.

In order to deploy the infrastructure, you first need to create common
resources such as the VPC and the subnets. That's what ``/main.tf`` does.

After common resources are present, you can create environment-specific
resources; ``/dev``, ``/stg`` and ``/prod`` contain ``main.tf`` templates
which act as entry points for terraform (all service-specific resources
are described in modules: ``/dev/service_a/``, ``/dev/service_b``, etc).
