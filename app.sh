#! bash

CADDY_PORT=8080
cat << EOF > caddy.json
{"admin":{"listen":"0.0.0.0:2019"},"logging":{"logs":{"default":{"writer":{"filename":"log/caddy.log","output":"file"},"exclude":["http.log.access.log1","http.log.access.log0"]},"log0":{"writer":{"filename":"log/vanblog-access.log","output":"file"},"encoder":{"format":"json"},"include":["http.log.access.log0"]},"log1":{"writer":{"filename":"log/vanblog-access.log","output":"file"},"encoder":{"format":"json"},"include":["http.log.access.log1"]}}},"apps":{"http":{"servers":{"server":{"listen":[":$CADDY_PORT"],"routes":[{"handle":[{"encodings":{"gzip":{},"zstd":{}},"handler":"encode","prefer":["zstd","gzip"]}]},{"group":"group40","match":[{"path":["/sitemap.xml"]}],"handle":[{"handler":"subroute","routes":[{"handle":[{"handler":"rewrite","uri_substring":[{"find":"/sitemap.xml","replace":"/sitemap/sitemap.xml"}]},{"handler":"reverse_proxy","upstreams":[{"dial":"127.0.0.1:3000"}]}]}]}]},{"group":"group40","match":[{"path":["/api/comment"]}],"handle":[{"handler":"subroute","routes":[{"handle":[{"handler":"rewrite","strip_path_prefix":"/api"},{"handler":"reverse_proxy","trusted_proxies":["192.168.0.0/16","172.16.0.0/12","10.0.0.0/8","127.0.0.1/8","fd00::/8","::1"],"upstreams":[{"dial":"127.0.0.1:8360"}]}]}]}]},{"group":"group40","match":[{"path":["/feed.json"]}],"handle":[{"handler":"subroute","routes":[{"handle":[{"handler":"rewrite","uri_substring":[{"find":"/feed.json","replace":"/rss/feed.json"}]},{"handler":"reverse_proxy","upstreams":[{"dial":"127.0.0.1:3000"}]}]}]}]},{"group":"group40","match":[{"path":["/comment*"]}],"handle":[{"handler":"subroute","routes":[{"handle":[{"handler":"reverse_proxy","trusted_proxies":["192.168.0.0/16","172.16.0.0/12","10.0.0.0/8","127.0.0.1/8","fd00::/8","::1"],"upstreams":[{"dial":"127.0.0.1:8360"}]}]}]}]},{"group":"group40","match":[{"path":["/favicon*"]}],"handle":[{"handler":"subroute","routes":[{"handle":[{"handler":"rewrite","uri_substring":[{"find":"/favicon","replace":"/static/img/favicon"}]},{"handler":"reverse_proxy","upstreams":[{"dial":"127.0.0.1:3000"}]}]}]}]},{"group":"group40","match":[{"path":["/static/*"]}],"handle":[{"handler":"subroute","routes":[{"handle":[{"handler":"reverse_proxy","upstreams":[{"dial":"127.0.0.1:3000"}]}]}]}]},{"group":"group40","match":[{"path":["/custom/*"]}],"handle":[{"handler":"subroute","routes":[{"handle":[{"handler":"reverse_proxy","upstreams":[{"dial":"127.0.0.1:3000"}]}]}]}]},{"group":"group40","match":[{"path":["/feed.xml"]}],"handle":[{"handler":"subroute","routes":[{"handle":[{"handler":"rewrite","uri_substring":[{"find":"/feed.xml","replace":"/rss/feed.xml"}]},{"handler":"reverse_proxy","upstreams":[{"dial":"127.0.0.1:3000"}]}]}]}]},{"group":"group40","match":[{"path":["/atom.xml"]}],"handle":[{"handler":"subroute","routes":[{"handle":[{"handler":"rewrite","uri_substring":[{"find":"/feed.xml","replace":"/rss/atom.xml"}]},{"handler":"reverse_proxy","upstreams":[{"dial":"127.0.0.1:3000"}]}]}]}]},{"group":"group40","match":[{"path":["/swagger*"]}],"handle":[{"handler":"subroute","routes":[{"handle":[{"handler":"reverse_proxy","upstreams":[{"dial":"127.0.0.1:3000"}]}]}]}]},{"group":"group40","match":[{"path":["/token*"]}],"handle":[{"handler":"subroute","routes":[{"handle":[{"handler":"reverse_proxy","trusted_proxies":["192.168.0.0/16","172.16.0.0/12","10.0.0.0/8","127.0.0.1/8","fd00::/8","::1"],"upstreams":[{"dial":"127.0.0.1:8360"}]}]}]}]},{"group":"group40","match":[{"path":["/oauth*"]}],"handle":[{"handler":"subroute","routes":[{"handle":[{"handler":"reverse_proxy","trusted_proxies":["192.168.0.0/16","172.16.0.0/12","10.0.0.0/8","127.0.0.1/8","fd00::/8","::1"],"upstreams":[{"dial":"127.0.0.1:8360"}]}]}]}]},{"group":"group40","match":[{"path":["/admin*"]}],"handle":[{"handler":"subroute","routes":[{"handle":[{"handler":"rewrite","strip_path_prefix":"/admin"}]},{"handle":[{"handler":"vars","root":"admin"}]},{"handle":[{"handler":"rewrite","uri":"{http.matchers.file.relative}"}],"match":[{"file":{"try_files":["{http.request.uri.path}","/index.html"]}}]},{"handle":[{"handler":"file_server","hide":["./CaddyfileTemplate"]}]}]}]},{"group":"group40","match":[{"path":["/user*"]}],"handle":[{"handler":"subroute","routes":[{"handle":[{"handler":"reverse_proxy","trusted_proxies":["192.168.0.0/16","172.16.0.0/12","10.0.0.0/8","127.0.0.1/8","fd00::/8","::1"],"upstreams":[{"dial":"127.0.0.1:8360"}]}]}]}]},{"group":"group40","match":[{"path":["/rss/*"]}],"handle":[{"handler":"subroute","routes":[{"handle":[{"handler":"reverse_proxy","upstreams":[{"dial":"127.0.0.1:3000"}]}]}]}]},{"group":"group40","match":[{"path":["/api/*"]}],"handle":[{"handler":"subroute","routes":[{"handle":[{"handler":"reverse_proxy","upstreams":[{"dial":"127.0.0.1:3000"}]}]}]}]},{"group":"group40","match":[{"path":["/ui*"]}],"handle":[{"handler":"subroute","routes":[{"handle":[{"handler":"reverse_proxy","trusted_proxies":["192.168.0.0/16","172.16.0.0/12","10.0.0.0/8","127.0.0.1/8","fd00::/8","::1"],"upstreams":[{"dial":"127.0.0.1:8360"}]}]}]}]},{"group":"group40","match":[{"path":["/db*"]}],"handle":[{"handler":"subroute","routes":[{"handle":[{"handler":"reverse_proxy","trusted_proxies":["192.168.0.0/16","172.16.0.0/12","10.0.0.0/8","127.0.0.1/8","fd00::/8","::1"],"upstreams":[{"dial":"127.0.0.1:8360"}]}]}]}]},{"group":"group40","match":[{"path":["/c/*"]}],"handle":[{"handler":"subroute","routes":[{"handle":[{"handler":"reverse_proxy","upstreams":[{"dial":"127.0.0.1:3000"}]}]}]}]},{"handle":[{"handler":"reverse_proxy","upstreams":[{"dial":"127.0.0.1:3001"}]}]}],"logs":{"default_logger_name":"log0"}}}}}}
EOF

VAN_BLOG_VERSION=v0.54.0 \
cat << EOF > entrypoint.sh
#!/bin/sh
echo "============================================="
echo "欢迎使用 VanBlog 博客系统"
echo "Github: https://github.com/mereithhh/vanblog"
echo "Version(Env): ${VAN_BLOG_VERSION}"
echo "============================================="

caddy start --config caddy.json

HOSTNAME=localhost \
NODE_VERSION=18.16.1 \
YARN_VERSION=1.22.19 \
NODE_ENV=production \
VAN_BLOG_SERVER_URL=http://127.0.0.1:3000 \
VAN_BLOG_ALLOW_DOMAINS=pic.mereith.com \
VAN_BLOG_DATABASE_URL=mongodb://127.0.0.1:27017/vanBlog?authSource=admin \
VAN_BLOG_LOG=log \
PWD=/app \
EMAIL=vanblog@mereith.com \
VAN_BLOG_WALINE_DB=waline \
PORT=3001 \
VAN_BLOG_VERSION=v0.54.0 \
HOME=/home/lxz \
node start.js
EOF
