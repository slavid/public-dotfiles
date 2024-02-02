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