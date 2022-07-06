### 🌈

Auto Deployment Multiple Node.js App in Docker Lab.

## Usage

### up & down & reboot

```bash
sh ./up.sh mysql # or nginx, redis, mysql
```

```bash
sh ./down.sh mysql # or nginx, redis, mysql
```

```bash
sh ./reboot.sh mysql # or nginx, redis, mysql
```

### reload nginx vhost

```bash
sh ./reload-nginx.sh
```


## Tips

### bach

if `sh ./xxx.sh` get error `Syntax error: redirection unexpected`, you can try `bash ./xxx.sh`.

### mysql

After init DB, You can set User Permissions and Create Table
`GRANT ALL PRIVILEGES ON *.* TO 'www-root'@'%'; FLUSH PRIVILEGES;`

### adminer

⚠️ if adminer not work, you can try PMA

Server input box Please input `service_name`, NOT `container_name`

In order to avoid confusion between the `prod` and `dev` env, the `dynamic-title-info` plugin is enabled by default, and the plugin is located in `./var/www/html/plugins`.

![dynamic-title-info-snapshop](./var/www/html/plugins/dynamic-title-info-snapshop.png)
