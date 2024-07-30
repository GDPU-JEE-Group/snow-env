num=$1
docker stop android_$num  
docker rm  android_$num
rm -rf /userdata/container/android_data/data_$num

