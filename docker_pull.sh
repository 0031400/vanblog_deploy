#! bash
mkdir /app
cd /app
docker run --name vanblog -d mereith/van-blog:latest 
sleep 3
docker exec vanblog sh -c "cd /app && tar czf vanblog.tar.gz ./*"
docker cp vanblog:/app/vanblog.tar.gz .
docker rm -f vanblog
