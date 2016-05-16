#!/bin/bash

set -e -x

sudo sed -i '/RSA 1024 bit CA certificates are loaded due to old openssl compatibility/d' /var/lib/gems/2.0.0/gems/httpclient-2.7.1/lib/httpclient/ssl_config.rb
sudo wget -O /usr/local/bin/spiff https://github.com/cloudfoundry-incubator/spiff/releases/download/v1.0.7/spiff_linux_amd64
sudo chmod a+x /usr/local/bin/spiff
mkdir workspace
cd workspace
git clone https://github.com/cloudfoundry/cf-release.git
git clone https://github.com/cloudfoundry/bosh-lite.git
cd bosh-lite/
sudo gem install bundler
sudo ./bin/provision_cf
sudo chown -R ubuntu:ubuntu  ~/.bosh

