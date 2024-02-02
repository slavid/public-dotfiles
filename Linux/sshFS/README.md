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
# Enable sshFS on Raspberry Pi
## permisos para usuario pi
```
sudo chown -R pi:pi /path/to/dest/folder
```
## ejecutar sshfs
```
sshfs -o cache=yes -o kernel_cache -o Compression=no user@remoteIP:/path/to/source/folder /path/to/dest/folder -o IdentityFile=/path/to/key.key
```
## desmontar unidad
```
fusermount -u /path/to/dest/folder
```
## mount fstab sshfs oracle
```
user@remoteIP:/path/to/source/folder /path/to/dest/folder  fuse.sshfs _netdev,user,idmap=user,follow_symlinks,identityfile=/path/to/key.key,allow_other,default_permissions,uid=1000,gid=1000 0 0
```