#!/bin/bash
################
# CentOS 一键安装
# From: sgfoot.com
#################

# 卸载旧版本
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine


# 设置仓库
sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

# 使用阿里源地址
sudo yum-config-manager \
    --add-repo \
    http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo


# 安装 Docker Engine
sudo yum install docker-ce docker-ce-cli containerd.io -y

# 启动
systemctl start docker

# 测试一下
sudo docker run hello-world

echo "安装完毕"