@echo off
set N=%1
docker rm -f hadoop-master 2>NUL 1>NUL
echo "start master"
docker run -itd ^
--net=hadoop ^
-p 50070:50070 ^
-p 8088:8088 ^
--name hadoop-master ^
--hostname hadoop-master ^
kiwenlau/hadoop:1.0  >NUL
for /L %%i in (1,1,%N%) do (
	docker rm -f hadoop-slave%%i 2>NUL 1>NUL
	echo "start hadoop-slave%%i container..."
	docker run -itd ^
	   --net=hadoop ^
	   --name hadoop-slave%%i ^
	   --hostname hadoop-slave%%i ^
	   kiwenlau/hadoop:1.0 
)
docker exec -it hadoop-master bash
