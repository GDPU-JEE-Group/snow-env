#!/bin/bash

source .env

# 获取 .env 文件中的键值对
get() {
    local key="$1"
    local value=$(grep -m 1 "^${key}=" .env | cut -d '=' -f2-)
    echo "$value"
    return 0
}

# 设置 .env 文件中的键值对
set() {
    local key="$1"
    local value="$2"
    if grep -q "^${key}=" .env; then
        sed -i "s/^${key}=.*/${key}=${value}/" .env
        echo "更新成功: ${key}=${value}"
    else
        echo "${key}=${value}" >> .env
        echo "追加成功: ${key}=${value}"
    fi
    return 0
}

# 读取某个文件中包含关键字的行
read() {
    local file_path="$1"
    local key="$2"
    local line=$(grep -m 1 "${key}" "${file_path}")
    echo "$line"
    return 0
}

# 替换某个文件中包含关键字的行内容
write() {
    local file_path="$1"
    local key="$2"
    local new_value="$3"
    local old_line=$(grep -m 1 "${key}" "${file_path}")

    if [[ -n "$old_line" ]]; then
        sed -i "s|${old_line}|${new_value}|g" "$file_path"
        echo "替换前: $old_line"
        echo "替换后: $new_value"
    else
        echo "替换前: 空行"
        echo "替换后: 空行"
    fi
    return 0
}

# 主函数
main() {
    local command="$1"
    shift  # 移除第一个参数

    case "$command" in
        get)
            get "$@"
            ;;
        set)
            set "$@"
            ;;
        read)
            read "$@"
            ;;
        write)
            write "$@"
            ;;
        *)
            echo "未知命令: $command"
            echo "可用命令: get, set, read, write"
            return 1
            ;;
    esac
    return 0
}

# 调用主函数
main "$@"
