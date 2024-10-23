#!/bin/bash

#定义变量
login_IP='校园网登录IP'
not_sign_in_title='上网登录页'
result_return='"result":1'
sign_parameter='请求URL的文本链接'
signed_in_title='注销页'

# 发送HTTP请求，尝试访问登录页面
req=$(curl -s --max-time 1 "$login_IP" | iconv -f gb2312 -t utf-8)

# 检查是否已经登录
if echo "$req" | grep -q "$signed_in_title"; then
    echo "该设备已经登录"
    exit 0
fi

# 检查是否显示上网登录页
if echo "$req" | grep -q "$not_sign_in_title"; then
    req=$(curl -s --max-time 1 "$sign_parameter")

    # 判断登录是否成功
    if echo "$req" | grep -q "$result_return"; then
        echo "登录成功"
    else
        echo "登录失败"
    fi

    exit 0
fi

# 未连接到校园网的情况
echo "未连接到校园网"
exit 0