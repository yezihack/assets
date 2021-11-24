#!/bin/bash
####################
# prometheus node_exporter 监控端安装
# 技术站: sgfoot.com
####################
set +x
# 参数定义
name="node_exporter"
local=/usr/local
install_path=$local/$name
download_url=http://img.sgfoot.com/soft/node_exporter-1.0.1.linux-amd64.tar.gz
file_name_tar=${download_url##*/}
file_name=${file_name_tar/\.tar\.gz/}

# 检查是否安装过

exist=`ps -ef |grep -w $name|grep -v grep|wc -l`
if [ $exist -gt 0 ];then
	echo "node_exporter 已经安装"
	exit 0
fi

# 检查是否是CentOS7系统
version=$(cat /etc/redhat-release|sed -r 's/.* ([0-9]+)\..*/\1/')
if [ $version -lt 7 ];then
	echo "请安装在 CentOS 7"
	exit 0
fi

# 下载安装包 
wget $download_url

# 解压安装包
tar -zxvf $file_name_tar -C $local

# 对解压后的安装包重命名
mv $local/$file_name $install_path 

# 制作 systemd 守护进程
cat > /usr/lib/systemd/system/$name.service << EOF
[Unit]
Description=$name
Documentation=https://prometheus.io/
After=network.target

[Service]
Type=simple
User=root
ExecStart=$install_path/$name
KillMode=process
Restart=on-failure
RestartSec=10s

[Install]
WantedBy=multi-user.target
EOF

# systemctl 重启，启动，状态
systemctl daemon-reload
systemctl enable $name
systemctl start $name
systemctl status $name

# 删除安装包
if [ -f $file_name_tar ];then
	rm -rf $file_name_tar
fi 

# 打印安装后的信息
netstat -nplt
echo "安装完毕"
echo "安装路径:$install_path"
echo "systemctl 管理 $name"
echo "启动：systemctl start $name"
echo "停止：systemctl stop $name"
echo "重启：systemctl restart $name"
