# Vagrant Gitlab Runner for Android projects

This vagrant box has included Android sdk and Android ndk inside, gitlab runner will be registered after the first run of `bootstrap.sh` script.

## Usage

1. Install Vagrant and VirtualBox

2. Checkout this repo and modify `bootstrap.sh` environment variables:

```
URL="YOUR_GITLAB_URL"
TOKEN="YOUR_TOKEN"
PROXY_HOST="YOUR_PROXY_HOST"
PROXY_PORT="YOUR_PROXY_PORT"
```

3. Run the follow commands to get start:

```
vagrant up --provision
```

## Destroy

Run the follow commands to destroy gitlab runner virtual machine

```
vagrant destroy
```

And then remove the dead runner from gitlab.

