# 简单的博客项目
## 数据库表
- USER(id,username,passwordHash,salt,email,work,phone,address,registerTime,isChecked)
- HOBBY(id,hobby,userID)
- ROLE(id,role,permission)
- PERMISSION(id,permission,role)
## 目标功能
- 用户注册
- [X] 判断用户是否存在
- [X] 发送邮箱验证用户
- [X] 密码加盐加密存取
- 用户登录
- [X] 判断用户是否存在
- [X] 判断用户是否验证
- [X] 判断用户密码正确
- 忘记密码
- [X] 发送邮箱验证并修改密码
- 主页部分
- [X] 显示用户信息
- [X] 用户修改信息
- [ ] 自定义头像
- 博客部分
- [ ] 用户撰写博客
- [ ] 根据博客主题生成图片
- [ ] 查看博客内容
- [ ] 博客目录分类
- [ ] 修改博客内容
- [ ] 删除博客
