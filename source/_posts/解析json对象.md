---
title: 封装json对象和解析json对象
date: 2017-06-15 10:01:26
categories: 编程  
tags: [Java]
---

### 创建Person实体类

```java
public class Person {
    private String name;
    private String grade;
    private String sex;
    private String birth;
}
```

### 组装json的方法

```java
public String viewMagazine(){
    Person p1 = new Person();
    person.setBirth("1989-22-11");
    person.setGrade("07java");
    person.setName("happ");
    person.setSex("boy");

    Person p2 = new Person();
    person1.setBirth("1989-22-11");
    person1.setGrade("07java");
    person1.setName("helloworlda");
    person1.setSex("girl");

    List<Person> list = new ArrayList<>();
    list.add(p1);
    list.add(p2);

    JSONObject json = new JSONObject();
    JSONArray arr = JSONArray.fromObject(list);//构建json数组
    json.put("person",p1);//往json中添加对象
    json.put("personList", list);//往json中添加list集合
    //json.put("personArr", arr);//往json中添加JSONArray数组
    json.put("comCount", 3);
    System.out.println(json);
    return null;
}
```

### java解析json对象，解析出对象、字符串以及数组，然后遍历出相应的值

```java
private static void strJsonObj(){
    String json = "{'name':'helloworlda','array':[{'a':'111','b':'222','c':'333'},{'a':'999'}],'address':'111','people':{'name':'happ','sex':'girl'}}";
    //将json格式的字符串转换成json对象
    JSONObject json = JSONObject.fromObject(json);
    String name = json.getString("name");//字符串
    JSONArray array = json.getJSONArray("array");//数组
    JSONObject people = json.getJSONObject("people");//对象

    System.out.println("=======strJsonObj========");
    System.out.println("name : " + name);
    System.out.println("json : " + json);
    System.out.println("array :" + array);

    //遍历json对象：people
    Iterator<?> it = people.keys();
    while(it.hasNext){
        String key = (String)it.next().toString;
        String value = (String)people.getString(key);
        System.out.println(key + " : " + value);
    }

    //遍历json数组
    for(int i = 0; i < array.size(); i++){
        System.out.println("array元素 " + i + " : " + array.getString(i));
    }
}
```
