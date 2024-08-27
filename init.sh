#!/bin/bash

home_path=/snow
root_path=$home_path/snow-env

run_cmd() {
    echo -e "\033[0;32mExecuting: $*\033[0m"
    "$@"
    local status=$?
    if [ $status -ne 0 ]; then
        echo -e "\033[0;31mError: Command failed with status $status\033[0m"
        exit $status
    fi
}

# 打印备注事项
print_help() {
    echo "使用方法："
    echo "-h  打印备注事项"
    echo "-   创建/snow, 下载/snow/snow-env, 给与权限，查看路径是否含有，没有就加，.env设置环境路径（所有脚本基于这个路径）"
}

# 创建/snow目录并下载snow-env文件
setup_snow() {
    # 下载创建文件
    if [ ! -f $home_path ];then
        run_cmd mkdir -p $home_path
    if
    cd $home_path
    if [ ! -f $root_path ];then
        run_cmd git clone https://github.com/GDPU-JEE-Group/snow-env.git
    if
    
    # 给权限
    run_cmd chmod +x $root_path/*.sh

    # 检查路径是否存在于环境变量中 设置环境变量
    keyword="snow-env"
    fpath="~/.bashrc"
    if grep -q "$keyword" "$fpath"; then
        echo "文件 $fpath 包含keyword $keyword"
    else
        echo "文件 $fpath 不包含keyword $keyword"
        run_cmd cat $root_path/config >> $fpath
    fi
}

# 解析命令行参数
while getopts ":h" opt; do
    case ${opt} in
        h )
            print_help
            exit 0
            ;;
        \? )
            echo "无效的选项: $OPTARG" 1>&2
            exit 1
            ;;
    esac
done

# 执行主要功能
setup_snow
