# -*- mode: ruby -*-
# vi: set ft=ruby :

vms = {
  'm1' => {'memory' => '1024', 'cpus' => 1, 'ip' => '10', 'provision' => 'first.sh'},
  'm2' => {'memory' => '1024', 'cpus' => 1, 'ip' => '20', 'provision' => 'second.sh'},
  'm3' => {'memory' => '1024', 'cpus' => 1, 'ip' => '30', 'provision' => 'second.sh'},
  'nfs' => {'memory' => '512', 'cpus' => 1, 'ip' => '40', 'provision' => 'nfs.sh'}
}

Vagrant.configure('2') do |config|

  config.vm.box = 'debian/buster64'
  config.vm.box_check_update = false

  vms.each do |name, conf|
    config.vm.define "#{name}" do |k|
      k.vm.hostname = "#{name}.k8s.com"
      k.vm.network 'private_network', ip: "192.168.33.#{conf['ip']}"
      k.vm.provider 'virtualbox' do |vb|
        vb.memory = conf['memory']
        vb.cpus = conf['cpus']
      end
      k.vm.provider 'libvirt' do |lv|
        lv.memory = conf['memory']
        lv.cpus = conf['cpus']
        lv.cputopology :sockets => 1, :cores => conf['cpus'], :threads => '1'
      end
      k.vm.provision 'shell', path: "provision/#{conf['provision']}", args: "#{conf['ip']}"
    end
  end

  config.vm.provision 'shell', path: 'provision/provision.sh'
end

