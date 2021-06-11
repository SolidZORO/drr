Q: ERROR: for prod_nginx Cannot start service nginx: driver failed programming external connectivity on endpoint

A: sudo lsof -i :80, find and kill the app.


----


Q: 使用 acme.sh 自动部署 SSL？

A: 这里我只说一下我的个人经验，其实不推荐用于 production 环境，偶尔会由于网络波动，出现掉签现象。

嗯，安装、申请什么的读一下 `https://github.com/acmesh-official/acme.sh` 就好了，当然为了避免我以后跳过去读，这里还是记录一下：

```bash
# 安装
curl https://get.acme.sh | sh 

# 想马上使用需要 alias，不然只能退出 ssh 再进来一次才生效
alias acme.sh=~/.acme.sh/acme.sh
```

安装完成后，默认会给加上一条 crontab。

```bash
7 0 * * * "/var/www/.acme.sh"/acme.sh --cron --home "/var/www/.acme.sh" > /dev/null
```


我个人用的是 `DNSPod`，去官网拿到 Auth 后：

```bash
export DP_Id="1111"
export DP_Key="kkkkkkkkkkkkkk"

acme.sh --issue --dns dns_dp -d xxxx.com -d www.xxxx.com

# 也支持野卡 (因为 * 是特殊字符记得加引号)
acme.sh --issue --dns dns_dp -d "*.xxxx.com" -d xxxx.com
```

这里要等至少 120s。 然后就得到 SSL 证书了。接下来，把 SSL 证书丢到你自己的 ssl 目录：

```bash
# 如果你肯定有目录，这步可以省略
mkdir -p "/var/www/drr/etc/nginx/ssl.d/*.xxxx.com" &&

acme.sh --installcert -d "*.xxxx.com" \
--key-file        "/var/www/drr/etc/nginx/ssl.d/*.xxxx.com/key.pem" \
--fullchain-file  "/var/www/drr/etc/nginx/ssl.d/*.xxxx.com/cert.pem" \
--reloadcmd       "sh ~/drr/r-nginx-reload.sh"
```

上面这个命令会在 SSL 续签成功的时候再次执行，所以不用再自己写一个 bash 丢到 crontab 了。


启动 acme
```bash
#docker-compose -f docker-compose.acme.yml up -d
docker-compose -f docker-compose.acme.yml up

docker container ls
```
