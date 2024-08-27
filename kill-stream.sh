source util.sh

str="arm-stream -i"
num=$1


run_cmd "kill \$(ps -ef | grep '$str $num' | grep -v grep | awk '{print \$2}')"

run_cmd "docker exec android_$num start adbd"


