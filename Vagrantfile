# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'vagrant-openstack-provider'

Vagrant.configure('2') do |config|

  config.ssh.pty = true

  config.vm.provider :openstack do |os|
    os.openstack_auth_url = 'http://cocina.psi.unc.edu.ar:5000/v2.0/tokens'
    os.username           = ENV['OS_USERNAME']
    os.password           = ENV['OS_PASSWORD']
    os.tenant_name        = ENV['OS_TENANT_NAME']
    os.image              = 'ubuntu-14.04-x86_64'
    os.sync_method        = 'none'
    #os.floating_ip_pool   = 'ext-net'
    os.networks           = ['vlan159']
    os.security_groups    = ['permit-any']
  end

  config.vm.define 'comdoc' do |comdoc|
    comdoc.vm.provider :openstack do |os|
      os.flavor         = 'c2m2d20'
    end
    comdoc.vm.hostname     = 'comdoc'
    comdoc.ssh.username    = 'ubuntu'
##### Configure all VMs with Ansible. Uncoment the folowwing four lines.
    comdoc.vm.provision :ansible do |ansible|
      ansible.playbook = "playbook-comdoc.yml"
      ansible.limit = 'all'
    end
  end

end
