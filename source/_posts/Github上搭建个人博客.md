---
title: 记录我在Github上搭建个人博客
date: 2016-07-25 22:30:15
categories: hexo
tags: [博客之路,HEXO]
---
### 写在前面
很庆幸生活在一个互联网高度发达的时代，网上有海量的信息，不乏是自己的兴趣的所在，尤其遇到我是喜欢学习的知识，所以我几乎每天都会打开电脑接受知识的洗礼，也是为了做一个活到老学到老的人~

### Github的背景与理解
>Git是一个分布式的版本控制系统，最初由Linus Torvalds编写，用作Linux内核代码的管理。在推出后，Git在其它项目中也取得了很大成功，尤其是在Ruby社区中。目前，包括Rubinius和Merb在内的很多知名项目都使用了Git。Git同样可以被诸如Capistrano和Vlad the Deployer这样的部署工具所使用。Github就是托管各种git库，并提供一个web界面的一款易于使用的git图形客户端。当你做了一个程序放在git上，别人感兴趣，对你的代码进行了一些修改，提交上去，你看了觉得很好，就立刻用提交的代码合并进去。目前，Github拥有140多万开发者用户，可以说Github是一个社交化的编程网站。

### 搭建个人博客
* 1.注册Github账号，按照提示很快就得到了一个免费的域名，比如我的：bubblelin.github.io
* 2.New repository,命名为bubblelin.github.io
* 3.在地址栏打开bubblelin.github.io，这样就到达了个人博客网站了！

### 安装Git和Hexo
    我用的版本：
    * Git: Git-2.9.2-64-bit
    * Hexo: node-v6.3.1-x64
    一直默认安装就行了

### Git常用的命令
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
* 4.关联一个远程库
``` bash
$ git remote add origin https://github.com/bubblelin/bubblelin.github.io.git
```
* 5.第一次推送，以后推送，可以没有‘-u’
``` bash
$ git push -u origin master
```
* ...

### Hexo常用的命令
* 1.在source目录下创建新博客
``` bash
$ hexo new "My New Post"
```
* 2.生成博客
``` bash
$ hexo generate
```
* 3.部署本地服务器
``` bash
$ hexo server
```
* 4.部署到远程GitHub
``` bash
$ hexo deploy
```
备注：hexo命令部署到远程Github，应部署到master分支，git命令推送源码到分支hexo上
