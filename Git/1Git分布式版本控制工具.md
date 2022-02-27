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
      ```
         # 用于输出git提交日志
         alias git-log='git log --pretty=oneline --all --graph --abbrev-commit'
         # 用于输出当前目录所有文件及基本信息
         alias ll='ls -al'
      ```
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
5. git分支
   1. git branch 查看分支
   2. git-log
   3. git branch 分支名 创建分支
   4. git checkout 分支名 切换分支
      HEAD指向谁，谁就是当前分支
   5. git checkout -b 分支名 创建并切换分支
   6. git merge 分支名 将分支合并到当前分支 Esc+:+wq
   7. git branch -d 删除分支
   8. git branch -D 强制删除分支
   9. 冲突
      1. 需要手动解决冲突
      2. 修改主分支后提交即可
6. 分支在开发中使用的流程（一般作为企业规范）
   1. master/relese 生产分支
   2. develop 开发分支
   3. feature/xxxx 分支 从develop分支创建的分支，一般是同期并行开发，但不同期上线时创建的分支，分支上的研发任务完成后合并到develop分支
   4. hotfix/bug/xxxx 分支 从master派生的分支，一般作为线上bug修复使用，修复完成后需要合并到master、test、develop分支
   5. 还有一些其他分支，例如test、pre等等
7. 远程仓库
   1. github、gitee
   2. gitlab 企业常用
   3. git remote add origin 仓库地址 添加远程仓库
   4. git remote 查看远程仓库
   5. git push [-f] [--set-upstream] [远端名称[本地分支名]][:远端分支名] 推送远端仓库
      1. -f 强制
      2. --set-upstream 绑定关系示例如下
      3. git push --set-upstream origin master:master 绑定关系
   6. git branch -vv 查看本地分支和远程分支对应关系
   7. git clone 远程仓库地址 克隆
   8. git fetch [remote name][branch name] 抓取指令就是将仓库里的更新都抓取到本地，不会合并
   9. git pull [remote name][branch name] 拉去指令，会合并到本地分支
   10. 不指定远端名称会默认抓取master分支

8.