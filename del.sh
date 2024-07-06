#!/bin/bash

# 检查是否提供了参数
if [ $# -ne 1 ]; then
  echo "Usage: $0 <file_or_directory>"
  exit 1
fi

target=$1

# 白名单列表
whitelist=(
  "/"
  "/*"
  "/snow"
  "/userdata"
  "/snow/snow-env/test/12.txt"
)

# 列出目标文件或目录
if [ -e "$target" ]; then
  ls -l "$target"
else
  echo "Error: $target does not exist."
  exit 1
fi

# 检查目标是否在白名单中
for item in "${whitelist[@]}"; do
  if [[ "$target" == "$item" ]]; then
    echo -e "\033[31mError: $target is in the whitelist and cannot be deleted!!!\033[0m"
    exit 1
  fi
done

# 请求用户确认
echo "Are you sure you want to delete $target? Type 'yes' to confirm:"
read confirmation

if [ "$confirmation" = "yes" ]; then
  rm -rf "$target"
  echo "$target has been deleted."
else
  echo "Deletion of $target cancelled."
fi
