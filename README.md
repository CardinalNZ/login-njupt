# login-njupt
[(理论上)各大高校都适用的 全平台校园网自动登录实现方法 - 哔哩哔哩 (bilibili.com)](https://www.bilibili.com/read/cv16042718/)
关于安卓、ios和Windows的自动登录方法，上面的链接已经详细写了，本人因自建NAS的需求补充一个Linux的shell脚本
## 一、获取校园网信息
浏览器打开校园网登陆页面，按F12打开开发人员工具
![1](picture/Pasted%20image%2020241023113500.png)
切换到网络界面，勾选保留日志，输入账号密码、运营商选择（如果有选择运营商），登录
![2](picture/Pasted%20image%2020241023114125.png)
在开发人员工具界面，寻找相关资源文件(login?callback=......)，点击文件并切换到标头，查看请求URL后面的文本中是否有自己的账号和密码，如果没有请重试。复制该文本的全部内容
![3](picture/Pasted%20image%2020241023114318.png)
退出校园网登录，将复制的文本粘贴在浏览器地址栏中，回车得到下面信息，记录页面出现的信息。并检查互联网是否连接成功。
![4](picture/Pasted%20image%2020241023115047.png)
## 修改脚本
### 1、工具检查
#### a、iconv
检查iconv是否安装`iconv -V`
Ubuntu中iconv的安装命令如下：
`sudo apt-get install iconv`
#### b、dos2unix
`sudo apt-get install dos2unix`
### 2、修改变量
脚本内容见login-njupt.sh,这里介绍脚本中要修改的变量
```
login_IP=""
not_sign_in_title="上网登录页"
result_return="\"result\":1"
sign_parameter=""
signed_in_title="注销页"
```
`login_IP`：校园网登录IP
`not_sign_in_title`：登录界面的title
`result_return`：请求URL的返回信息，例如，'“result”:1'
`sign_parameter`：请求URL的文本链接
`signed_in_title`：登录成功界面的title
### 3、保存脚本
修改完成后，`chmod +777`修改脚本权限，执行脚本并查看登录情况
