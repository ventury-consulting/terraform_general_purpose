# standalone

## Overview


## Basic usage

```bash
$ cd envs/standalone
$ export AWS_PROFILE=${YOUR_PROFILE}
$ terraform init
$ terraform plan
$ terraform apply
```

## Advanced usage

```bash
$ cd envs/standalone
$ export AWS_PROFILE=${YOUR_PROFILE}

# Edit configuration
$ cp example.tfvars config.tfvars
$ vi config.tfvars

$ terraform init
$ terraform plan --var-file=./config.tfvars
$ terraform apply --var-file=./config.tfvars
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| profile | Your profile in `~/.aws/config` | string | `"default"` | no |
| region | The region of instance to start | string | `"ap-northeast-1"` | no |
| public_key_path | The public key path to use for the instance | string | `"~/.ssh/id_rsa.pub"` | no |
| instance_count | Number of instances to launch | string | `"1"` | no |
| instance_type | The type of instance to start | string | `"t2.micro"` | no |
| root_volume_size | Volume size of root block device for the instance | string | `"100"` | no |

## Outputs

| Name | Description |
|------|-------------|
| private_ip | List of private IP addresses assigned to the instances |
| public_ip | List of public IP addresses assigned to the instances |
