spinnaker_version = "1.25.7"
ip = "192.168.205.10"

Vagrant.configure("2") do |config|
  name = "spinnaker"

  config.vm.define name do |spinnaker|
    spinnaker.vm.box = "ubuntu/bionic64"
    spinnaker.vm.hostname = name

    spinnaker.vm.network :private_network, ip: ip
    spinnaker.vm.network "forwarded_port", guest: 9000, host: 9000 # Deck port
    spinnaker.vm.network "forwarded_port", guest: 8084, host: 8084 # Gate port
    spinnaker.vm.network "forwarded_port", guest: 9001, host: 9001 # MinIO port

    spinnaker.vm.provider "virtualbox" do |v|
      v.name = name
      v.customize ["modifyvm", :id, "--memory", 8192]
      v.customize ["modifyvm", :id, "--cpus", 4]
    end

    spinnaker.vm.provision "file", source: "hal/profiles/front50-local.yml", destination: "${HOME}/.hal/default/profiles/front50-local.yml"
    spinnaker.vm.provision "file", source: "hal/service-settings/deck.yml", destination: "${HOME}/.hal/default/service-settings/deck.yml"
    spinnaker.vm.provision "file", source: "hal/service-settings/gate.yml", destination: "${HOME}/.hal/default/service-settings/gate.yml"
    spinnaker.vm.provision "shell", path: "scripts/install-docker.sh", privileged: false
    spinnaker.vm.provision "shell", path: "scripts/install-hal.sh", privileged: false
    spinnaker.vm.provision "shell", path: "scripts/setup-minio.sh", privileged: false
    spinnaker.vm.provision "shell", path: "scripts/install-spinnaker.sh", args: spinnaker_version
    if File.exist?("tmp/kube.config") 
      puts "Kubernetes config file exists, setting up kubernetes provider"
      spinnaker.vm.provision "file", source: "tmp/kube.config", destination: "${HOME}/.kube/config"
      spinnaker.vm.provision "shell", path: "scripts/setup-kubernetes-provider.sh", privileged: false, args: "local-kubernetes"
    end
  end
end
