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

Export your AWS credentials in shell (if you have credentials in `~/.aws/credentials` that will work too):
```
export AWS_ACCESS_KEY_ID=***********
export AWS_SECRET_ACCESS_KEY=**************************
unset AWS_SESSION_TOKEN
```

Enter docker container with terraform and AWS CLI by typing:
```
dojo
```
at the root of the project.

Assume role with elevated permissions:
```
eval $(aws-cli-assumerole -rmfa <role-arn> <mfa-otp-code>)
```

Work with terraform as usual:
```
terraform init
terraform apply
```

If your session expires, exit the container to drop the temporary credentials and run `dojo` again.
