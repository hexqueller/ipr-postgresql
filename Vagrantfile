Vagrant.configure("2") do |config|

  machines = [
    { name: "pg01", ip: "192.168.58.0" },
    { name: "pg01s", ip: "192.168.58.1" }
  ]

  machines.each do |machine|
    config.vm.define machine[:name] do |node|
      node.vm.box = "almalinux/9"
      node.vm.hostname = machine[:name]
      node.vm.network "private_network", ip: machine[:ip]
      node.vm.provider "virtualbox" do |vb|
        vb.memory = "4048"
        vb.cpus = 4
      end

      node.vm.provision "shell", path: "prepareOS.sh"
      node.vm.provision "shell", path: "install-pg.sh"
      node.vm.provision "shell", path: "configure-pg.sh"
    end
  end
end
