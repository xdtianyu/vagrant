# Vagrant Gitlab Runner for Android projects

[中文：(Android 工程的 Vagrant Gitlab Runner)](https://busy.im/post/vagrant-gitlab-runner-for-android/)

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

Set `PROXY_HOST` and `PROXY_PORT` to empty if you are not using proxy.

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

You can also host the box file at your LAN server, and then edit `Vagrantfile` and modify the following line: 

```
# config.vm.box_url = ["https://YOUR_LAN_HOSTING/gitlab-runner.box"]
```
For example, if you host this box file at `http://10.0.0.1:8080/gitlab-runner.box`, then update the config to:

```
config.vm.box_url = ["http://10.0.0.1:8080/gitlab-runner.box"]
```
Then distribute this repo with `.env` to your colleagues for quick setup, they can start the runner vm by running `vagrant up --provision` command.

## Login to vm runner

Use the following command to login vm runner:

```
vagrant ssh
```

The default user is `vagrant` and the password for `vagrant` and `root` user is `vagrant`. You can run command with `sudo` without password.

## Start automatically after Windows restart

You can run `bash add-windows-startup.sh` in `git-bash` to add a batch file `gitlab-runner.bat` in your startup directory.

Or you can manually create `gitlab-runner.bat` file with the following content and save it in `%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup`. Please note that modify `D:/code/vagrant/gitlab-runner` to your own path.

```batch
@echo off
echo Starting GitLab Runner ...
cd /D D:/code/vagrant/gitlab-runner
vagrant up --provision
::pause
```

## .gitlab-ci.yml example

Check out project [xdtianyu/CallerInfo](https://github.com/xdtianyu/CallerInfo) 's `.gitlab-ci.yml` for more details. You can also config ndk build, unit test, android ui test with this vm runner.


## Project

[https://github.com/xdtianyu/vagrant](https://github.com/xdtianyu/vagrant)

## License

MIT
