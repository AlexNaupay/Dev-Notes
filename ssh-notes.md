## Generate ssh key

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"

# Legacy
ssh-keygen  -t  rsa  -b  4096  -C "username@gmail.com"

```
    ➜ ssh-keygen  -t  rsa  -b  4096  -C "username@gmail.com"
    ➜ cat  ~/.ssh/ABC.pub

    ➜ ssh-copy-id   -i   path_ABC.pub  userremote@hostremote
    ➜ (remote)$ cat  ~/.ssh/authorized-keys

    ➜ ssh  user@hostremote  -i  path_private_key_to_use.pem

## TUNEL SSH
    ssh [-L|-R] origin_host:origin_port:dest_host:dest_pot remote_user@remote_host
    ssh [-L|-R] source_bind_host:source_bind_port:DEST_FINAL_HOST:DEST_FINAL_PORT remote_user@remote_reachable_host
    ssh -N -L local_port:127.0.0.1:remote_port remote_user@remote_ip
        Then: mysql -u mysql_remote_user -h 127.0.0.1 -P local_port -p
        Don't use localhost

    ssh -L 8080:ws5.pide.gob.pe:80 alexh@10.10.210.5
    ssh -L 8080:ultimosismo.igp.gob.pe:80 alexh@10.10.210.5  // Al tráfico en localhost:8080. Host remoto (.5), redirígelo al ultimosismo:80
    ssh -L 8443:ws5.pide.gob.pe:443 alexh@10.10.210.5 // https
    
    ssh -N -R 127.0.0.1:8085:10.10.150.47:1337 remote@remote_host

## Traer render de ventanas
    ssh -Xl USER SERVER
    ssh -XC user@server


## Increase iddle time
`ssh -o "ServerAliveInterval 60" USER@HOST`


## Delete mapped host
`ssh-keygen -f "/Users/eis/.ssh/known_hosts" -R "10.10.72.2"`

## Remote commands
```bash
ssh usuario@servidor "comando1; comando2 && comando3 || echo 'falló'"
#;: Ejecuta los comandos secuencialmente (aunque uno falle).
#&&: Ejecuta el siguiente comando solo si el anterior tuvo éxito.
#||: Ejecuta el siguiente comando solo si el anterior falló.

ssh usuario@servidor << 'EOF'
  comando1
  comando2
  if [ condicion ]; then
    comando3
  fi
EOF
# << 'EOF': Las variables no se expanden localmente (usa comillas para desactivar expansión).
# << EOF (sin comillas): Las variables se expanden en tu máquina local antes de enviarse.

cat script_local.sh | ssh usuario@servidor bash
```