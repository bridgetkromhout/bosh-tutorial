# BOSH tutorial


## Prerequisites

* laptop with administrator access

* comfortable using command line
	* commands you'll need will be provided, but you will want to be comfortable at a shell prompt.
	* No GUI version of the tutorial is available, and Windows-user support is limited.

* your own AWS account
  * [Signing up for the AWS free tier](https://aws.amazon.com/free/)
	* Requires amazon login, credit card, mailing address, and phone number
	* Can take up to 24 hours for full activation
  * [Getting your AWS access and secret keys](http://docs.aws.amazon.com/general/latest/gr/managing-aws-access-keys.html)
	* Setting up an IAM user & giving the user administrative permissions
	* Downloading credentials
	* AWS cli
		* install homebrew: http://brew.sh/
		* `brew install awscli`
		* `aws configure`
		* `aws iam list-users`
	* Sign up for VPC

* an SSH keypair to use with AWS
	* You can use an existing key if you prefer, but the terraform scripts assume specific naming
```
$ ssh-keygen -t rsa -b 4096 -C "yourname@example.com"
Generating public/private rsa key pair.
Enter file in which to save the key (/Users/yourname/.ssh/id_rsa): /Users/yourname/.ssh/boshtutorial
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /Users/yourname/.ssh/boshtutorial.
Your public key has been saved in /Users/yourname/.ssh/boshtutorial.pub.
```

* (optional) [Terraform installed](https://www.terraform.io/downloads.html)
  * makes it easier to stand up AWS infrastructure
	* Download, extract zip file
        * Put contents in your PATH:

	`mv ~/Downloads/terraform_0.6.16_darwin_amd64/* /usr/local/bin`

* Clone this repo:
` git clone https://github.com/bridgetkromhout/bosh-tutorial`

----

## Overview

 What is BOSH? Brief overview
  * "BOSH is an open source tool for release engineering, deployment, lifecycle management, and monitoring of distributed systems."
  * http://bosh.io/docs/about.html

## AWS infrastructure

* Standing up AWS infrastructure to use with BOSH
  * Terraform
		`terraform plan`
		`terraform apply`
		`terraform destroy`

* Launching bosh-lite instance
  * Looking at how the instance was created (Packer)
    * https://www.packer.io/docs/builders/amazon-ebs.html
    * https://github.com/cloudfoundry/bosh-lite/blob/master/packer/build-aws


## Trying BOSH

* Using BOSH (intro exercises)
  * [Learn BOSH](http://mariash.github.io/learn-bosh/)

```
bosh status
```
    * Misleading message

Ubuntu backports openssl fixes; a Ruby gem bosh uses doesn't know that. See https://github.com/nahi/httpclient/blob/v2.7.1/lib/httpclient/ssl_config.rb#L450 for the context of the line we're removing.

    ```
    ubuntu@agent-id-bosh-0:/$ sudo sed -i '/RSA 1024 bit CA certificates are loaded due to old openssl compatibility/d' /var/lib/gems/2.0.0/gems/httpclient-2.7.1/lib/httpclient/ssl_config.rb
    ```

```
bosh status
```


Replace UUID in manifest. You can use an editor or this substitution:
```
sed -i "s/4796378f-cc91-4d93-a1b0-75a9af101708/$(bosh status --uuid)/" manifest.yml
```

ubuntu@agent-id-bosh-0:~/learn-bosh-release$ bosh status --uuid
190bb19e-2e13-4f69-99ec-316a5ac637cf
ubuntu@agent-id-bosh-0:~/learn-bosh-release$ grep uuid manifest.yml
director_uuid: 4796378f-cc91-4d93-a1b0-75a9af101708
ubuntu@agent-id-bosh-0:~/learn-bosh-release$ sed -i "s/4796378f-cc91-4d93-a1b0-75a9af101708/$(bosh status --uuid)/" manifest.yml
ubuntu@agent-id-bosh-0:~/learn-bosh-release$ grep uuid manifest.yml
director_uuid: 190bb19e-2e13-4f69-99ec-316a5ac637cf
ubuntu@agent-id-bosh-0:~/learn-bosh-release$

## BOSH concepts

* BOSH stemcells

bosh upload stemcell https://bosh.io/d/stemcells/bosh-warden-boshlite-ubuntu-trusty-go_agent


* BOSH release


## Troubleshooting

## Cloud Foundry
* Installing CF with BOSH


