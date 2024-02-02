# Instalar sshfs
## 1 añadir repositorio PowerTools ARM64
```
sudo yum-config-manager --add-repo=https://rpmfind.net/linux/centos/8-stream/PowerTools/aarch64/os/
```
## 2 editar /etc/yum.repos.d/rpmfind.net_linux_centos_8-stream_PowerTools_aarch64_os_.repo
```
gpgcheck=0
```
## 3 instalar paquete
```
sudo yum update
sudo yum install fuse-sshfs
```
