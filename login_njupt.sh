#!/bin/bash

#定义变量
login_IP="https://p.njupt.edu.cn/a79.htm"
not_sign_in_title="上网登录页"
result_return="\"result\":1"
sign_parameter="https://p.njupt.edu.cn:802/eportal/portal/login?callback=dr1003&login_method=1&user_account=%2C0%2C1222067026%40njxy&user_password=Zhujihong%400673&wlan_user_ip=10.161.239.24&wlan_user_ipv6=&wlan_user_mac=00000000000&wlan_ac_ip=&wlan_ac_name=&jsVersion=4.1.3&terminal_type=1&lang=zh-cn&v=5807&lang=zh"
signed_in_title="注销页"

function login()
{
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
}

if ping -c 1 -w 1 110.242.68.66 > /dev/null;then
  echo "网络已连接"
  exit 0
else
  echo "正在联网"
  login
  exit 0
fi

