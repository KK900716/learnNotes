1. 概述
    a.开发的实际场景
        备份 代码还原 协同开发 追溯问题代码的编写人和编写时间
    b.集中式版本控制的方式
        SVN、CVS
    c.分布式版本控制方式
        Git
2. Git工作流程
    a.clone 从远程仓库中克隆代码
    b.checkout 从本地仓库中捡出一个仓库分支然后进行修订
    c.add 在提交前先将代码提交到暂存区
    d.commit 提交到本地仓库，本地仓库中保存修改的各个历史版本
    e.fetch 从远程库，抓取到本地仓库，不进行任何的合并，一般操作比较少
    f.pull 从远程库拉到本地库，自动进行合并merge，然后放到工作区，相当于fetch+merge
    g.push 修改完成后，需要和团队成员共享代码时，将代码推送到远程仓库
3. 基本配置
   1. 安装
   2. 配置
      1. git config --global user.name "名字" 设置名字
      2. git config --global user.email "邮箱" 设置邮箱
      3. git config --global user.name 查看名字
      4. git config --global user.email 查看邮箱
   3. 为常用指令设置别名
      1. 用户目录下创建.bashrc文件
   4. 解决中文乱码问题
      1. git config --global core.quotepath false
      2. zai etc/bash.bashrc文件最后加入下面两行
         1. export LANG="zh_CN.UTF-8"
         2. export LC_ALL="zh_CN.UTF-8"
4. git常用指令
   1. 本地仓库
      1. git init 初始化本地仓库
      2. git add 添加到暂存区
      3. git commit 提交到本地仓库
      4. git status 查看状态
         1. untracked未跟踪
         2. unstaged未暂存
      5. git log 查看日志
         1. --all 显示所有分支
         2. --pretty=oneline 将提交信息显示为一行
         3. --abbrev-commit 使得输出的commitld更简短
         4. --graph 以图形形式显示
      6. git reset --hard {commitID} 版本回退
      7. git reflog 查看操作记录，可以找到回退版本后丢失版本
      8. .gitignore 创建一个文件可以指定git在当前目录下排除管理的文件
         1. 文件名