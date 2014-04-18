# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.
 config.vm.define "testvm" do |testvm|
    testvm.vm.hostname = "chefiisbase"
    testvm.vm.box = "vagrant-win2k8r2"
    testvm.vm.guest = :windows
#    testvm.omnibus.chef_version = :latest

   testvm.vm.box_url = "https://dl.dropboxusercontent.com/u/2105139/vagrant/win2k8r2.box"
    testvm.vm.network :private_network, ip: "192.168.18.66"

      # Port forward WinRM and RDP
    testvm.vm.network :forwarded_port, guest: 3389, host: 3389, id: "rdp", auto_correct: true
    testvm.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true

    testvm.vm.provider :virtualbox do |vb|
       # Don't boot with headless mode
       vb.gui = true
    #   # Use VBoxManage to customize the VM. For example to change memory:
    #   vb.customize ["modifyvm", :id, "--memory", "1024"]
    end

    testvm.vm.boot_timeout = 120
  
   # Max time to wait for the guest to shutdown
    testvm.windows.halt_timeout = 25

      # Admin user name and password
    testvm.winrm.username = "vagrant"
    testvm.winrm.password = "vagrant"

    testvm.vm.provision :chef_solo do |chef|
      chef.log_level = :debug
      chef.json = {
        :minitest => {
          :ci_reports => '/tmp/chefci'
        }
      }
      chef.run_list = [
          "recipe[winfw::add_rule]",
          "recipe[winfw::delete_rule]",
          #"recipe[minitest-handler::default]"
      ]
    end
  end    
 

  # option to your ~/.vagrant.d/Vagrantfile file
  config.berkshelf.enabled = true

end
