
|    学习讨论小组🍻    |           打赏（赠送学习资料：[webNote](https://github.com/Cc-Edit/webNote)） :confetti_ball:     | 
|:-------------------------------------------------------------------------------:|:--------------------------------------------------------------------:| 
| ![wechat.png](https://static.sisjs.com/images/WeChatGroup.png)  | ![img.png](https://static.sisjs.com/images/img.png) |

# CcHook
有帮助的话记得给个Star哟 🥰  

个人服务器轻量级 CICD 方案（替代 jenkins）前端自动部署、前端自动化工具、消息推送、邮件发送、前端定时任务、个人信息自动更新
有帮助的话记得给个Star哟 🥰
 
## 介绍
[https://zhuanlan.zhihu.com/p/630007999](https://zhuanlan.zhihu.com/p/630007999)


## 使用流程
1. 将项目 clone 到任意目录
2. 修改路径
    1. [cchook.service](cchook.service) 中地址
    2. [hooks.json](hooks.json) 中脚本地址、工作空间地址，secret密钥（千万不要泄露）㊙️
3. 启动任务  ```$ ./start.sh```
4. 使用 [cchook.service](cchook.service) 实现开机自启(可选)
5. 配置域名，代理到9000端口
``` 
location /
  {
    proxy_pass http://127.0.0.1:9000/;
  }
```
6. 配置gitHub webhook
  
## 注意
1. 新添加的脚本需要修改执行权限才能在服务器运行，命令:
```shell
    git update-index --add --chmod=+x *.sh
    git commit -m 'Make sh executable'
    git push
```

## WebHook 启动参数

`-cert`
- HTTPS 证书 pem 文件的路径（默认为“cert.pem”）

`-cipher-suites`
- 支持的 TLS 密码套件的逗号分隔列表

`-debug`
- 显示调试输出

`-header`
- 返回的response header，以name=value的格式指定，多次使用可设置多个headers

`-hooks`
- 包含 webhook 应该服务的已定义钩子的 json 文件的路径，使用多次从不同的文件加载

`-hotreload`
- 观察挂钩文件的变化并自动重新加载它们

`-http-methods`
- 全局限制允许的 HTTP 方法； 用逗号分隔方法

`-ip`
- ip webhook 应该提供挂钩（默认“0.0.0.0”）

`-key`
- HTTPS 证书私钥 pem 文件的路径（默认为“key.pem”）

`-list-cipher-suites`
- 列出可用的 TLS 密码套件

`-logfile`
- 将日志输出发送到文件； 隐式启用详细日志记录

`-nopanic`
- 如果在 webhook 未在详细模式下运行时无法加载挂钩，请不要惊慌

`-pidfile`
- 在给定路径创建 PID 文件

`-port`
- Webhook 应该在其上提供挂钩的端口（默认 9000）

`-secure`
- 使用 HTTPS 而不是 HTTP

`-setgid`
- 打开监听端口后设置组ID； 必须与 setuid 一起使用

`-setuid`
- 打开监听端口后设置用户ID； 必须与 setgid 一起使用

`-template`
- 将 hooks 文件解析为 Go 模板

`-tls-min-version`
- 最低 TLS 版本（1.0、1.1、1.2、1.3）（默认“1.2”）

`-urlprefix`
- 用于服务挂钩的 url 前缀 (protocol://yourserver:port/PREFIX/:hook-id) (default "hooks")

`-verbose`
- 显示详细输出

`-version`
- 显示 webhook 版本并退出

`-x-request-id`
- 使用 X-Request-Id 标头（如果存在）作为请求 ID

`-x-request-id-limit`
- 截断 X-Request-Id 标头以限制； 默认无限制

## json 字段说明

`id`
- 指定挂钩的 ID。 此值用于创建 HTTP 端点 (http://yourserver:port/hooks/your-hook-id)

`execute-command`
- 指定触发钩子时应执行的命令

`command-working-directory`
- 指定执行脚本时将用于脚本的工作目录

`response-message`
- 指定将返回给挂钩发起者的字符串

`response-headers`
- 指定格式为 {"name": "X-Example-Header", "value": "it works"} 的标头列表，这些标头将在钩子的 HTTP 响应中返回

`success-http-response-code`
- 指定成功时返回的 HTTP 状态码

`incoming-payload-content-type`
- 设置传入 HTTP 请求的内容类型（即 application/json）； 当请求缺少 Content-Type 或发送错误值时很有用

`http-methods`
- 允许的 HTTP 方法列表，例如 POST 和 GET

`include-command-output-in-response`
- 布尔值 webhook 是否应该等待命令完成并将原始输出作为对 hook 启动器的响应返回。 如果命令执行失败或在执行响应时遇到任何错误，将导致 500 Internal Server Error HTTP 状态代码，否则将返回 200 OK 状态代码。

`include-command-output-in-response-on-error`
- 布尔值 webhook 是否应包括命令 stdout & stderror 作为失败执行的响应。 它仅在 include-command-output-in-response 设置为 true 时有效。

`parse-parameters-as-json`
- 指定包含 JSON 字符串的参数列表。 这些参数将被 webhook 解码，您可以像访问规则中的常规对象一样访问它们，并将参数传递给命令。

`pass-arguments-to-command`
- 指定将传递给命令的参数列表。 检查引用请求值页面以了解如何从请求中引用值。 如果要将静态字符串值传递给命令，可以将其指定为 { "source": "string", "name": "argumentvalue" }

`pass-environment-to-command`
- 指定将作为环境变量传递给命令的参数列表。 如果您未在引用值中指定“envname”字段，则挂钩将采用“HOOK_argumentname”格式，否则将使用“envname”字段作为其名称。 检查引用请求值页面以了解如何从请求中引用值。 如果要将静态字符串值传递给命令，可以将其指定为 { "source": "string", "envname": "SOMETHING", "name": "argumentvalue" }

`pass-file-to-command`
- 指定将序列化为文件的条目列表。 传入的数据将在请求临时文件中序列化（否则挂钩的并行调用将导致文件的并发覆盖）。 后续脚本中要寻址的文件名是通过环境变量提供的。 使用 envname 指定环境变量的名称。 如果未提供 envname，则使用 HOOK_ 和用于引用请求值的名称。 定义 command-working-directory 将相对于此位置存储文件，如果未提供，将使用系统临时文件目录。 如果 base64decode 为真，则传入的二进制数据将在将其存储到文件之前进行 base 64 解码。 默认情况下，相应的文件将在 webhook 退出后被删除。

`trigger-rule`
- 指定将评估的规则以确定是否应触发挂钩。 检查 Hook 规则页面以查看有效规则列表及其用法

`trigger-rule-mismatch-http-response-code`
- 指定不满足触发规则时要返回的 HTTP 状态代码

`trigger-signature-soft-failures`
- 允许 Or 规则中的签名验证失败； 默认情况下，签名失败被视为错误。












































