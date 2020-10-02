# Base infrastructure for deductions PRM

Scope of infrastructure which should be in this repository:

> All infrastructure that is not bound to specific environment.

That implies:
 * ECR repositories for docker images that we produce
 * DNS zone shared by all environments
 * IP whitelisting and public-facing security groups

# Updating whitelisted IPs

To make sure that you can access deductions services such as VPN or GOCD, please run following script anytime when your IP changes:
```
./tasks allow_my_ip <role_arn> <mfa_code>
```

# Development and workflow

## Prerequisites

Tools are bundled in a docker image to get you running quickly.
You'll only need to install:
1. Docker
2. [Dojo](https://github.com/kudulab/dojo):
 * On OSX: `brew install kudulab/homebrew-dojo-osx/dojo`
 * On Linux: `sudo wget -O /usr/bin/dojo https://github.com/kudulab/dojo/releases/download/${version}/dojo_linux_amd64
&& chmod +x /usr/bin/dojo`

## Workflow

### Access to AWS

In order to get sufficient access to work with terraform or AWS CLI:

Make sure to unset the AWS variables:
```
unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset AWS_SESSION_TOKEN
```

As a note, the following set-up is based on the README of assume-role [tool](https://github.com/remind101/assume-role)

Set up a profile for each role you would like to assume in `~/.aws/config`, for example:

```
[profile default]
region = eu-west-2
output = json

[profile admin]
region = eu-west-2
role_arn = <role-arn>
mfa_serial = <mfa-arn>
source_profile = default
```

The `source_profile` needs to match your profile in `~/.aws/credentials`.
```
[default]
aws_access_key_id = <your-aws-access-key-id>
aws_secret_access_key = <your-aws-secret-access-key>
```

### Assume role with elevated permissions 

#### Install `assume-role` locally:
`brew install remind101/formulae/assume-role`

Run the following command with the profile configured in your `~/.aws/config`:

`assume-role admin`

#### Run `assume-role` with dojo:
Run the following command with the profile configured in your `~/.aws/config`:

`eval $(dojo "echo <mfa-code> | assume-role admin")`

Run the following command to confirm the role was assumed correctly:

`aws sts get-caller-identity`


Work with terraform as per usual:
```
terraform init
terraform apply
```

If your session expires, exit the container to drop the temporary credentials and run `dojo` again.


## AWS SSM Parameters Design Principles

When creating the new ssm keys, please follow the agreed convention as per the design specified below:

* all parts of the keys are lower case
* the words are separated by dashes (`kebab case`)
* `env` is optional
  
### Design:
Please follow this design to ensure the ssm keys are easy to maintain and navigate through:

| Type               | Design                                  | Example                                               |
| -------------------| ----------------------------------------| ------------------------------------------------------|
| **User-specified** |`/repo/<env>?/user-input/`               | `/repo/${var.environment}/user-input/db-username`     |
| **Auto-generated** |`/repo/<env>?/output/<name-of-git-repo>/`| `/repo/output/prm-deductions-base-infra/root-zone-id` |

