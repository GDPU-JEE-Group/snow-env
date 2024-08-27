#!/bin/bash

# 目标路径
TARGET_PATH=$1

# 检查输入的路径是否为空
if [ -z "$TARGET_PATH" ]; then
    echo "请提供一个路径作为参数。"
    exit 1
fi

# 检查~/.bashrc文件是否存在
if [ ! -f ~/.bashrc ]; then
    echo "~/.bashrc 文件不存在。"
    exit 1
fi

# 检查路径是否已经在~/.bashrc中
if grep -q "export PATH=.*$TARGET_PATH" ~/.bashrc; then
    echo "路径 $TARGET_PATH 已经在 ~/.bashrc 中。"
else
    # 添加路径到~/.bashrc中
    echo "export PATH=\$PATH:$TARGET_PATH" >> ~/.bashrc
    echo "路径 $TARGET_PATH 已添加到 ~/.bashrc 中。"
    cat ~/.bashrc
    
    # 提示用户是否立即生效
    read -p "是否立即使新路径生效？(y/n) " choice
    if [ "$choice" = "y" ]; then
        source ~/.bashrc
        echo "新路径已生效。"
    else
        echo "路径将在下次登录时生效。"
    fi
fi
