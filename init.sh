#!/bin/bash

home_path=/snow
root_path=$home_path/snow-env
git_repo="https://github.com/GDPU-JEE-Group/snow-env.git"
git_repo_inland="https://gitee.com/trychar-no1/snow-env.git"

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

    # 第一步：检查 /userdata 目录是否存在，如果不存在就创建
    if [ ! -d "/userdata" ]; then
        mkdir /userdata
        echo "创建 /userdata 目录。"
    else
        echo "/userdata 目录已经存在。"
    fi

    # 第二步：检查 /userdata/snow 目录是否存在，如果不存在就创建
    if [ ! -d "/userdata/snow" ]; then
        mkdir /userdata/snow
        echo "创建 /userdata/snow 目录。"
    else
        echo "/userdata/snow 目录已经存在。"
    fi

    # 第三步：检查 /snow 是否存在，如果不存在就创建符号链接 /snow 指向 /userdata/snow
    if [ ! -e "/snow" ]; then
        ln -s /userdata/snow /snow
        echo "符号链接 /snow 已创建，指向 /userdata/snow。"
    else
        echo "/snow 已经存在。"
    fi

    # 第四步：检查 /snow/snow-env 是否存在，如果不存在就进行 git clone
    if [ ! -d "/snow/snow-env" ]; then
        echo "尝试从 $git_repo 克隆仓库到 /snow/snow-env..."
        
        # 尝试克隆第一个仓库
        if git clone $git_repo /snow/snow-env; then
            echo "成功从 $git_repo 克隆仓库到 /snow/snow-env。"
        else
            echo "克隆 $git_repo 失败，尝试从备用仓库 $git_repo_inland 克隆..."
            
            # 如果第一个仓库克隆失败，尝试克隆第二个仓库
            if git clone $git_repo_inland /snow/snow-env; then
                echo "成功从 $git_repo_inland 克隆仓库到 /snow/snow-env。"
            else
                echo "克隆备用仓库 $git_repo_inland 也失败了。"
                echo "错误：无法克隆仓库，脚本终止。"
                exit 1
            fi
        fi
    else
        echo "/snow/snow-env 已经存在。"
        cd $root_path
        run_cmd git pull
    fi

    # 给权限
    run_cmd chmod +x $root_path/*.sh

    # 检查路径是否存在于环境变量中 设置环境变量
    keyword="snow-env"
    fpath="$HOME/.bashrc"
    if grep -q "$keyword" "$fpath"; then
        echo "文件 $fpath 包含keyword $keyword"
    else
        echo "文件 $fpath 不包含keyword $keyword"
        echo "cat $root_path/config >> $fpath"
        cat $root_path/config >> $fpath
    fi


    # 成功
    echo "成功!"
    echo "source ~/.bashrc"
    run_cmd find /userdata/ -name build_image.sh
    run_cmd find /userdata/ -name android_ctl.sh
    echo "add-path.sh xxxxx/add-path.sh"
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
