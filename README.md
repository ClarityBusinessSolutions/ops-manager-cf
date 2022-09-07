# MONGODB-OPS-MANAGER

This repository builds AMI's for MongoDB Ops Manager and MongoDB Agent Servers. It provides CloudFormation to launch these AMIs in the cloud to use Ops Manager Automation to configure MongoDB clusters.

## Buiding Ops Manager AMI

```shell
cd ops-manager
export AWS_MAX_ATTEMPTS=60 AWS_POLL_DELAY_SECONDS=60
packer build -timestamp-ui .
```



## Destroying Agent Instances Stack

```shell
aws cloudformation delete-stack --stack-name mongodb-agents-stack
```




