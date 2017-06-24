---
title: 字符串和正则表达式
date: 2017-06-20 10:58:27
categories: 编程
tags: [Java]
---

### 基础

#### 正则表达式匹配
&emsp;&emsp;一般来说，正则表达式就是以某种方式来描述字符串。例如，“要找一个数字，他**可能**有一个负号在最前面”，则用`-?`表示。
&emsp;&emsp;在正则表达式中，`\d`表示一位数字。但在Java中，需要用`\\`表示后面的字符有特殊的意义，所以一位数字应该用`\\d`表示。
&emsp;&emsp;要表示“一个或多个之前的表达式”，应该使用`+`。例如，“表示一个负号，后面跟着一位或多位数字”，表达式为：
&emsp;&emsp;`-?\\d+`

&emsp;&emsp;检查一个String是否匹配如上所诉的正则表达式
```Java
public class IntegerMatch{

    public static void main(String[] args){
        System.out.println("-1234".matches("-?\\d+"));//true
        System.out.println("1234".matches("-?\\d+"));//true
        System.out.println("+1234".matches("-?\\d+"));//false
        System.out.println("+1234".matches("(-|\\+)?\\d+"));//true
    }
}
```
前面两个字符串满足对应的正则表达式，匹配成功。第三个字符串开头`+`，它也是一个合法的字符，但对应的正则表达式不匹配。正则表达式应该描述为“可能以一个加号或减号开头”。在正则表达中，括号`()`具有分组的效果，而竖线`|`则表示“或”操作，表达式为：
&emsp;&emsp;`(-|\\+)?\\d+`
这个正则表达式表示“字符串的起始字符**可能**是一个`-`或`+`，或者二者皆没有（因为后面跟着`?`修饰符），另外字符`+`在正则表达式中有特殊意义，所以需要用`\\`转义”。

#### Java的split和replace方法
+ `split()`方法，旨在将字符串从正则表达式匹配的地方切开
```Java
public class Splitting(){

    public static String knights = "Then, hello world !";

    public static void Splitting(String regex){
        System.out.println(Arrays.toString(knights.split(regex)));
    }

    public static void main(String[] args){
        Splitting(" ");//[Then,,hello,world,!]
        Splitting("\\W+");//[Then, hello, world]
        Splitting("n\\W+");//[The,hello,world!]
    }
}
```
第二个和第三个表达式都用到了`\W`，它的意思是“非单词字符”（如果`W`小写，`\w`，则表示“一个单词字符”）

+ `replace()`方法，旨在替换匹配正则表达式的子字符串
```Java
public class Replacing(){

    static String s = Splitting.knights;

    public static void replaceFirsting(String regex, String str){
        System.out.println(s.replaceAll(regex, str));
    }

    public static void replaceAlling(String regex, String str){
        System.out.println(s.replaceAll(regex, str));
    }

    public static void main(String[] args){
        repaceFirsting("o\\w+","boy");//Then, hello wboy !
        repaceAlling("en|lo|ld","boy");//Thboy, helboy worboy !
    }
}
```
第二个表达式用分隔符`|`，表示“或”。


### 创建

正则表达式的完整构造子列表
* 常用字符

| 表达式 | 字符
| --- | ---
| B | 指定字符
| \xhh | 十六进制值为0xhh
| \xhhhhh | 十六进制表示为0xhhhh的Unicode字符
| \t | 制表符Tab
| \n | 换行符
| \r | 回车
| \f | 换页
| \e | 转义（Esc）

* 常用字符类

| 表达式 | 字符
| --- | ---
| . | 任意字符
| [abc] | 包含a，b，c的任何字符（同 ‘a或b或c’）
| [^abc] | 除a，b，c之外的任何字符
| [a-zA-Z] | 从a~z和A~Z的任何字符（范围）
| abc[hij] | 同 ‘a或b或c或h或i或j’(合并
| a-z&&[hij] | 任意h，i，j(交集)
| \s | 空白符(空格，tab，换行，回车，换页)
| \S | 非空白符，（同[^\s]）
| \d | 数字0~9
| \D | 非数字，（同[^0-9]）
| \w | 词字符[a-zA-Z0-9]
| \W | 非词字符，（同[^\w]）

### 常用

#### 校验数字的表达式

1. 数字：`(-?\d*)(\.\d+)?`
2. 带1-2位小数的正数或负数：`^(\-)?\d+(\.\d{1,2})?$ `
3. 非零的正整数：`^[1-9]\d*$` 或 `^([1-9][0-9]*){1,3}$` 或 `^\+?[1-9][0-9]*$`

#### 校验字符的表达式

1. 汉字：`^[\u4e00-\u9fa5]{0,}$`
2. 英文和数字：`^[A-Za-z0-9]+$` 或 `^[A-Za-z0-9]{4,40}$`
3. 长度为3-20的所有字符：`^.{3,20}$`
4. 中文、英文、数字但不包括下划线等符号：`^[\u4E00-\u9FA5A-Za-z0-9]+$` 或 `^[\u4E00-\u9FA5A-Za-z0-9]{2,20}$`
5. 可以输入含有`^%&',;=?$\"`等字符：`[^%&',;=?$\x22]+`

#### 特殊需求表达式

1. Email地址：`^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$`
2. 域名：`[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(/.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+/.?`
3. InternetURL：`(h|H)(r|R)(e|E)(f|F) *= *('|")?(\w|\\|\/|\.)+('|"| *|>)?`
4. 手机号码：`^1[34578]\d{9}$` 或 `^1(3|4|5|7|8)\d{9}$` 或 `^1[0-9]{10}$`
5. 5 电话号码：`^(\(\d{3,4}-)|\d{3.4}-)?\d{7,8}$`  
6. 身份证号(15位、18位数字)：`(^\d{15}$)|(^\d{17}([0-9]|X)$)`
7. 日期格式：`^\d{4}-\d{1,2}-\d{1,2}`
8. 中文字符的正则表达式：`[\u4e00-\u9fa5]`
9. 空白行的正则表达式：`\n\s*\r` (可以用来删除空白行)
10. 首尾空白字符的正则表达式：`^\s*|\s*$或(^\s*)|(\s*$)`    (可以用来删除行首行尾的空白字符(包括空格、制表符、换页符等等)，非常有用的表达式)
11. IP地址：`\d+\.\d+\.\d+\.\d+`    (提取IP地址时有用)
12. 中国邮政编码：`[1-9]\d{5}(?!\d)`    (中国邮政编码为6位数字)
13. 腾讯QQ号：`[1-9][0-9]{4,}`    (腾讯QQ号从10000开始)
