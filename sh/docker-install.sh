#!/bin/bash
################
# CentOS һ����װ
# From: sgfoot.com
#################

# ж�ؾɰ汾
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine


# ���òֿ�
sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

# ʹ�ð���Դ��ַ
sudo yum-config-manager \
    --add-repo \
    http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo


# ��װ Docker Engine
sudo yum install docker-ce docker-ce-cli containerd.io -y

# ����
systemctl start docker

# ����һ��
sudo docker run hello-world

echo "��װ���"