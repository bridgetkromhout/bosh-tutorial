# BOSH tutorial


## Course Outline

### Prerequisites

* laptop with administrator access

* comfortable using Linux command line
  * commands you'll need will be provided, but you will want to be comfortable at a shell prompt. No GUI version of the tutorial is available, and Windows-user support is limited.

* your own AWS account
  * [Signing up for the AWS free tier](https://aws.amazon.com/free/)
  * [Getting your AWS access and secret keys](http://docs.aws.amazon.com/general/latest/gr/managing-aws-access-keys.html)

* [an SSH key to use with AWS](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/)

* (optional) [Terraform installed](https://www.terraform.io/downloads.html)
  * makes it easier to stand up AWS infrastructure

* (optional) git installed locally
  * makes it easier to follow along in this repo

### Topics

* What is BOSH? Brief overview
  * "BOSH is an open source tool for release engineering, deployment, lifecycle management, and monitoring of distributed systems."
  * http://bosh.io/docs/about.html
* Standing up AWS infrastructure to use with BOSH
  * Terraform
* Launching bosh-lite instance
  * Looking at how the instance was created (Packer)
    * https://www.packer.io/docs/builders/amazon-ebs.html
    * https://github.com/cloudfoundry/bosh-lite/blob/master/packer/build-aws
  * Running bosh
    * Misleading message
	Ubuntu backports openssl fixes; a Ruby gem bosh uses doesn't know that. See https://github.com/nahi/httpclient/blob/v2.7.1/lib/httpclient/ssl_config.rb#L450 for the context of the line we're removing.
    ```
    ubuntu@agent-id-bosh-0:/$ sudo sed -i '/RSA 1024 bit CA certificates are loaded due to old openssl compatibility/d' /var/lib/gems/2.0.0/gems/httpclient-2.7.1/lib/httpclient/ssl_config.rb
    ```

* Using BOSH (intro exercises)
* BOSH release

* Installing CF with BOSH

