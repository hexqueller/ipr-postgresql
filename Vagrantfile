Vagrant.configure("2") do |config|

  machines = [
    { name: "pg01", ip: "10.0.0.99" },
    { name: "pg01s", ip: "10.0.0.98" }
  ]

  machines.each do |machine|
    config.vm.define machine[:name] do |node|
      node.vm.box = "almalinux/9"
      node.vm.hostname = machine[:name]
      node.vm.network "public_network", bridge: "eno1", ip: machine[:ip], dev: "eno1"
      node.vm.provider "virtualbox" do |vb|
        vb.memory = "4048"
        vb.cpus = 4
      end

      node.vm.provision "shell", path: "prepareOS.sh"
      node.vm.provision "shell", path: "install-pg.sh"
      node.vm.provision "shell", path: "configure-pg.sh"
      node.vm.provision "shell", path: "install-monitoring.sh"
    end
  end
end
