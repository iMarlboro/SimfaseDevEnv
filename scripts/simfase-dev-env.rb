# from homestead.rb
# 
class SimfaseDevEnv
  def SimfaseDevEnv.configure(config, settings)
    ENV['VAGRANT_DEFAULT_PROVIDER'] = "virtualbox"

    config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

    config.ssh.forward_agent = true

    config.vm.box = settings["box"] ||= "simfase-dev-env"
    config.vm.hostname = settings["hostname"] ||= "Simfase"

    config.vm.network :private_network, ip: settings["ip"] ||= "192.168.11.11"

    if settings.has_key?("networks")
      settings["networks"].each do |network|
        config.vm.network network["type"], ip: network["ip"], bridge: network["bridge"] ||= nil
      end
    end

    config.vm.provider "virtualbox" do |vb|
      vb.name = settings["name"] ||= "simface-dev-env-0.1.0"
      vb.customize ["modifyvm", :id, "--memory", settings["memory"] ||= "1024"]
      vb.customize ["modifyvm", :id, "--cpus", settings["cpus"] ||= "1"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--ostype", "Ubuntu_64"]
    end

    if (settings.has_key?("ports"))
      settings["ports"].each do |port|
        port["guest"] ||= port["to"]
        port["host"] ||= port["send"]
        port["protocol"] ||= "tcp"
      end
    else
      settings["ports"] = []
    end

    default_ports = {
      80   => 8001,
      443  => 44301,
      3306 => 33061
    }

    default_ports.each do |guest, host|
      unless settings["ports"].any? { |mapping| mapping["guest"] == guest }
        config.vm.network "forwarded_port", guest: guest, host: host, auto_correct: true
      end
    end

    if settings.has_key?("ports")
      settings["ports"].each do |port|
        config.vm.network "forwarded_port", guest: port["guest"], host: port["host"], protocol: port["protocol"], auto_correct: true
      end
    end

    if settings.include? 'authorize'
      if File.exists? File.expand_path(settings["authorize"])
        config.vm.provision "shell" do |s|
          s.inline = "echo $1 | grep -xq \"$1\" /home/vagrant/.ssh/authorized_keys || echo $1 | tee -a /home/vagrant/.ssh/authorized_keys"
          s.args = [File.read(File.expand_path(settings["authorize"]))]
        end
      end
    end

    if settings.include? 'keys'
      settings["keys"].each do |key|
        config.vm.provision "shell" do |s|
          s.privileged = false
          s.inline = "echo \"$1\" > /home/vagrant/.ssh/$2 && chmod 600 /home/vagrant/.ssh/$2"
          s.args = [File.read(File.expand_path(key)), key.split('/').last]
        end
      end
    end

    if settings.include? 'folders'

      settings["folders"].sort! { |a,b| a["map"].length <=> b["map"].length }

      settings["folders"].each do |folder|
        mount_opts = []

        if (folder["type"] == "nfs")
            mount_opts = folder["mount_options"] ? folder["mount_options"] : ['actimeo=1']
        end

        options = (folder["options"] || {}).merge({ mount_options: mount_opts })

        options.keys.each{|k| options[k.to_sym] = options.delete(k) }

        config.vm.synced_folder folder["map"], folder["to"], type: folder["type"] ||= nil, **options
      end
    end
    # config.vm.provision "shell" do |s|
      # s.inline = "/usr/local/bin/composer self-update"
    # end
  end
end
