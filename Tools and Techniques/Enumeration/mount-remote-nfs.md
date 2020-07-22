# Mounting a Remote NFS Share on a Target Server
An NFS share might be found during an `nmap` scan as such,
```
2049/tcp open  nfs_acl    2-3 (RPC #100227)
```
To attempt to mount an remote NFS file share like this, do the following:

```
root@kali:~# apt install nfs-common -y # required
root@kali:~# mkdir /mnt/remotenfs # local mount point
root@kali:~# mount (TARGET IP ADDRESS):/ /mnt/remotenfs # mounting the root of the NFS share
```
