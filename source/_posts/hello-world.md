---
title: Git和Hexo命令行
date: 2016-08-20 10:58:27
categories: hexo
tags: [HEXO]
---

## Git开始会用

### 基础知识

* 0.配置用户信息
``` bash
git config --global user.name "userName"
git config --global user.email "emailAddress"
```

* 1.添加文件到stage
``` bash
$ git add
```

* 2.查询stage或版本库里的文件有无改动
``` bash
$ git status
```

* 3.提交文件到git版本库
``` bash
$ git commit
```

* 4.关联一个远程库，先创建当前用户的SSH key（id_rsa私钥，id_rsa.pub公钥），使用公钥绑定远程repository，再remote关联，origin可以为项目名称
``` bash
$ cd ~/.ssh
$ git-keygen -t rsa -C "emailAddress"
$ git remote add origin repositoryAddress
```

* 5.第一次推送，以后推送，可以没有‘-u’，origin可以为项目名称,master为当前分支名称
``` bash
$ git push -u origin master
```

* 6.从远程pull到本地，origin可以为项目名称,master为当前分支名称
``` bash
$ git pull origin master
```

* 7.查看commit日志,可以得到<commit id>
``` bash
$ git log
$ git reflog
$ git log --pretty=oneline
```

* 8.查看文件编辑日志
``` bash
$ git diff file.*
```

## Git深入使用

### 版本控制

* 1.回退版本，当前版本用HEAD表示，上一个版本是HEAD^,再往上HEAD^^，在往上10个可表示为HEAD~10等
``` bash
$ git reset --hard HEAD^
```

* 2.回到指定的版本号
``` bash
$ git reset --hard <commit id>
```

### 撤销修改

* 1.文件修改后没有add或commit操作,即文件还在工作区
``` bash
$ git checkout -- file.*
```

* 2.文件修改后已实现add或commit操作，即文件已添加到了暂存区或者版本区
``` bash
$ git reset --hard <commit id>
```

### 删除文件

* 1.先在工作区删除
``` bash
$ rm file.*
```
备注：这里可以使用`git checkout -- file.*` 撤销工作区的文件删除

* 2.把删除提交到暂存区
``` bash
$ git rm file.*
```

* 3.在版本库中删除
``` bash
$ git commit -m "delete file.*"
```

### 创建分支和合并分支

* 1.查看分支
``` bash
$ git branch
```

* 2.创建分支dev
``` bash
$ git branch dev
```

* 3.切换分支dev
``` bash
$ git checkout dev
```

* 4.切回主分支，合并dev分支
``` bash
$ git checkout master
$ git merge dev
```

* 5.删除分支
``` bash
$ git branch -d dev
```

* 6.禁用Fast forward模式合并，可以生成commit的日志信息
``` bash
$ git merge --no-ff -m"禁用Fast forward模式合并" dev
```

### 添加标签*

* 1.添加标签，相当于commit的提交日志（-m " info "）
``` bash
$ git tag v1.0
```

* 2.给以前的提交打标签,先查询出所有的提交,再给<commit id>打标签
``` bash
$ git log --pretty=oneline --abbrev-commit
$ git tag v1.0 <commit id>
```

* 3.带说明的标签，用`-a`指定标签名，用`-m`指定标签说明
``` bash
$ git tag -a v1.0 -m"1.0版本" <commit id>
```

* 4.查看标签
``` bash
$ git tag
```

* 5.查看指定标签的说明
``` bash
$ git show v1.0
```

### 操作标签*

* 1.删除标签
``` bash
$ git tag -d v1.0
```

* 2.推送标签
``` bash
$ git push origin v1.0
```

* 3.推送所有标签
``` bash
$ git push origin --tags
```

* 4.本地删除远程标签，先删除本地
``` bash
$ git tag -d v1.0
$ git push origin :refs/tags/v1.0
```

### 忽略文件*

* 1.在工作区的根目录下创建一个特殊(类似`.git`)的`.gitignore`文件，然后把啊啊要忽略的文件填好
查看官方解决方案：https://github.com/github/gitignore，例如
``` bash
# 忽略掉下面的文件:
fileName.class
fileName.temp

```

* 2.提交`.gitignore`文件


* 3.忽略`.gitignore`规则，强制提交其中属于忽略的文件
``` bash
$ git add -f fileName.class
```

* 4.检查`.gitignore`中定义的fileName.class文件

``` bash
$ git check-ignore -v fileName.class
```
