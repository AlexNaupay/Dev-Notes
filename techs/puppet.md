# Puppet

### Install Puppet server 
```bash
# https://apt.puppet.com/

wget <PACKAGE_URL>
dpkg -i <FILE_NAME>.deb
apt install puppetserver
source /etc/profile.d/puppet-agent.sh

hostnamectl set-hostname puppet
nano /etc/hosts # add 127.0.0.1 puppet

# on /etc/bash.bashrc
export PATH=/opt/puppetlabs/bin:$PATH

# after installing an agent
puppetserver ca list
puppetserver ca sign --certname agent-identity
```


### Install Puppet agent
```bash
# ensure to reach puppet server by "puppet" hostname
# https://apt.puppet.com/

wget <PACKAGE_URL>
dpkg -i <FILE_NAME>.deb
apt install puppet-agent
source /etc/profile.d/puppet-agent.sh
# on /etc/bash.bashrc
export PATH=/opt/puppetlabs/bin:$PATH

# check puppet server connection
puppet ssl bootstrap
puppet agent --test
```


## Resources

* [Puppet](https://puppet.com/)
* [Puppet Install](https://www.puppet.com/docs/puppet/8/server/install_from_packages)
* [Puppet Debian 12](https://shape.host/resources/guia-para-instalar-y-configurar-puppet-server-y-agent-en-debian-12)