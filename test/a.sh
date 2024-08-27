#!/bin/bash

# 检查输入参数
if [ $# -ne 2 ]; then
    echo "使用方法: $0 <fpath> <keyword>"
    exit 1
fi

fpath=$1
keyword=$2

# 检查文件是否存在
if [ ! -f "$fpath" ]; then
    echo "文件 $fpath 不存在"
    exit 1
fi

# 检查文件是否包含keyword
if grep -q "$keyword" "$fpath"; then
    echo "文件 $fpath 包含keyword $keyword"
else
    echo "文件 $fpath 不包含keyword $keyword"
fi
