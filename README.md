# MONGODB-OPS-MANAGER

This repository builds AMI's for MongoDB Ops Manager and MongoDB Agent Servers. It provides CloudFormation to launch these AMIs in the cloud to use Ops Manager Automation to configure MongoDB clusters.

## Buiding Ops Manager AMI

```shell
cd ops-manager
export AWS_MAX_ATTEMPTS=60 AWS_POLL_DELAY_SECONDS=60
packer build -timestamp-ui .
```

## Deploying Ops Manager

``` shell
cd cloudformation

export OPS_MANAGER_STACK=<YOUR OPS MANAGER STACK NAME>
export AWS_VPC=<YOUR VPC ID>
export AWS_KEY_NAME=<YOUR KEY PAIR NAME>
export OPS_MANAGER_AMI=<YOUR INSTANCE TYPE>
export OPS_MANAGER_SUBNET=<YOUR SUBNET INSIDE YOUR VPC>
export OPS_MANAGER_PASSWORD=<PASSWORD FOR OPS MANAGER MONGODB ACCOUNT>
export MONGODB_ADMIN_PASSWORD=<YOUR PASSWORD>

aws cloudformation deploy --stack-name $OPS_MANAGER_STACK \
--template-file ops-manager.yml \
--parameter-overrides Environment=Dev \
OpsManagerAmi=$OPS_MANAGER_AMI\
VPC=$AWS_VPC \
KeyName=$AWS_KEY_NAME \
MongoDBAdminPassword=$MONGODB_ADMIN_PASSWORD \
OpsManagerMDBPassword=$OPS_MANAGER_PASSWORD \
OpsManagerSubnet=$OPS_MANAGER_SUBNET \
--capabilities CAPABILITY_NAMED_IAM \
--no-fail-on-empty-changeset \
--region us-east-1
```


## Buiding MongoDB Agents AMI

```shell
cd mongodb-agent
export AWS_MAX_ATTEMPTS=60 AWS_POLL_DELAY_SECONDS=60
packer build -timestamp-ui .
```

## Deploying Sharded Cluster


```shell
cd cloudformation

export AGENT_STACK_NAME=<YOUR STACK NAME>
export OPS_MANAGER_STACK=<YOUR OPS MANAGER STACK NAME>
export AZ_ONE==us-east-1a
export AZ_TWO=us-east-1b
export AZ_THREE=us-east-1c
export SUBNET_ONE==<SUBNET WITHIN AZ ONE>
export SUBNET_TWO=<SUBNET WITHIN AZ TWO>
export SUBNET_THREE=<SUBNET WITHIN AZ THREE>
export AWS_KEY_NAME=<YOUR KEY PAIR NAME>
export AGENT_AMI=<ID FOR THE AGENT AMI>
export OPS_MANAGER_PROJECT=<THE ID OF THE OPS MANAGER PROJECT>
export OPS_MANAGER_KEY=<THE API KEY FOR THE OPS MANAGER AGENT>
export MONGODB_ADMIN_PASSWORD=<YOUR PASSWORD>

aws cloudformation deploy --stack-name $AGENT_STACK_NAME \
--template three-shard-cluster.yml \
--parameter-overrides Environment=Dev \
AvailabilityZone1=$AZ_ONE \
AvailabilityZone2=$AZ_TWO \
AvailabilityZone3=$AZ_THREE \
AZSubnet1=$SUBNET_ONE \
AZSubnet2=$SUBNET_TWO \
AZSubnet3=$SUBNET_THREE \
KeyName=$AWS_KEY_NAME \
MongoDBAgentAmi=$AGENT_AMI \
OpsManagerStackName=$OPS_MANAGER_STACK \
OpsManagerProjectId=$OPS_MANAGER_PROJECT \
OpsManagerApiKey=$OPS_MANAGER_KEY\
--capabilities CAPABILITY_NAMED_IAM \
--no-fail-on-empty-changeset \
--region us-east-1
```

