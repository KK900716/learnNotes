# GitLab

```bash
sudo yum install -y curl policycoreutils-python openssh-server perl
sudo systemctl enable sshd
sudo systemctl start sshd

sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo systemctl reload firewalld

sudo yum install postfix
sudo systemctl enable postfix
sudo systemctl start postfix

curl -fsSL https://packages.gitlab.cn/repository/raw/scripts/setup.sh | /bin/bash


sudo EXTERNAL_URL="http://192.168.125.129" yum install -y gitlab-jh
```

```bash
gitlab-ctl start
gitlab-ctl stop
gitlab-ctl start
gitlab-ctl status
gitlab-ctl reconfigure
vi /etc/gitlab/gitlab.rb
gitlab-ctl tail
```

