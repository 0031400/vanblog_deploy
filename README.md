这个是为了在主机部署 vanblog ，但是不使用 docker 而写的仓库。  
原仓库地址 https://github.com/Mereithhh/van-blog  
使用方法
- 下载 release 文件，这个是服务端 nodejs 打包好的压缩包，对的，把node_modules都打包进去了。  
  https://github.com/0031400/vanblog_deploy/releases/download/v1.0/vanblog.tar.gz
- 解压压缩包，放到一个目录，比如说 /home/lxz/vanblog
- 把仓库的 app.sh 下载到目录
- 把仓库的 start.js 覆盖压缩包里面的 start.js
- 修改 app.sh 里面的变量
- 运行 app.sh 一次
- 以后直接使用 entrypoint.sh 运行  

注意:
- 需要安装 nodejs 和 caddy 和 mongodb
- 占用了 3000 3001 8360 端口

变量配置推荐修改:
- VAN_BLOG_DATABASE_URL  

不推荐修改:
- VAN_BLOG_SERVER_URL
- PORT
