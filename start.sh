########## bulding images
cd mysql
echo "building mysql image"
docker build -t abbas/mysql .
cd ../downloader
echo "building downloader image"
docker build -t abbas/downloader .
cd ../phpfpm
echo "building phpfpm image"
docker build -t abbas/phpfpm .
cd ../nginx
echo "building nginx image"
docker build -t abbas/nginx .
### runniing conatiners
echo "Running mysql container"
docker run -d --name mysql abbas/mysql
#download container
echo "Running downloader container"
docker run -i -t --name downloader abbas/downloader
# app server containers
echo "Running phpfpm/app1 container"
docker run -d --name app1 --volumes-from downloader --link mysql:db abbas/phpfpm
echo "Running phpfpm/app2 container"
docker run -d --name app2 --volumes-from downloader --link mysql:db abbas/phpfpm
#nginx container 
echo "Running nginx container"
docker run -d -p 80:80 --name nginx --volumes-from downloader --link app1:app1 --link app2:app2 abbas/nginx
sleep 3
echo "Finished"
