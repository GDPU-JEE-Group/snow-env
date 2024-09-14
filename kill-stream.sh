source util.sh

str="arm-stream -i"
num=$1

if [ "$num" == "-a" ]; then
  for i in {0..3}; do
    run_cmd "kill \$(ps -ef | grep '$str $i' | grep -v grep | awk '{print \$2}')"
    run_cmd "docker exec android_$i start adbd"
  done
else
  run_cmd "kill \$(ps -ef | grep '$str $num' | grep -v grep | awk '{print \$2}')"
  run_cmd "docker exec android_$num start adbd"
fi
