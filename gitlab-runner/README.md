# Vagrant Gitlab Runner for Android projects

This vagrant box has included Android sdk and Android ndk inside, gitlab runner will **be registered after the first run** of `bootstrap.sh` script.

## Usage

1. Install Vagrant and VirtualBox, for Windows users, please upgrade PowerShell to 5.1.

2. Checkout this repo and copy `.env.example` file to `.env`, then modify environment variables:

```
URL="YOUR_GITLAB_URL"
TOKEN="YOUR_TOKEN"
PROXY_HOST="YOUR_PROXY_HOST"
PROXY_PORT="YOUR_PROXY_PORT"
```

3. Run the following commands to get start:

```
vagrant up --provision
```

## Shutdown the vm

Run the following command to shutdown gitlab runner virtual machine

```
vagrant halt
```

You can always boot the vm using `vagrant up --provision`. 

## Destroy

Run the following commands to destroy gitlab runner virtual machine

```
vagrant destroy
```

And then remove the dead runner from gitlab.

## Hostname

Virtual machine's hostname is set automatically based on host's name, it's set in `Vagrantfile` by the following line:

```
config.vm.hostname = "#{`hostname`[0..-2]}-runner"
```

For example, if your host machine's name is `Peter-Desktop`, the client virtual machine's name will be `Peter-Desktop-runner`. And the gitlab runner's name will be the same as the hostname of vm, This is very useful if multiple vagrant runners are running for same gitlab instance.

## Slow speed

You can download the vm box file directly with your favorite Download Manager from the following link:

[https://vagrantcloud.com/xdtianyu/boxes/gitlab-runner/versions/1.0.0/providers/virtualbox.box](https://vagrantcloud.com/xdtianyu/boxes/gitlab-runner/versions/1.0.0/providers/virtualbox.box)

And then add box file to your vagrant box list by the following command:

```
vagrant box add xdtianyu/gitlab-runner gitlab-runner.box
```

## Project

[https://github.com/xdtianyu/vagrant](https://github.com/xdtianyu/vagrant)

## License

MIT
