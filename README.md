# AlamofirePackage
Alamofire请求框架进一步封装使用
封装的结构需要依赖  Alamofire 框架去做操作。  请使用cocopods 安装对应的依赖，如果你还不懂怎么使用cocopods，请移步谷歌。
把工程里面的Network文件夹引入到自己对应的项目中， 根据示例demo TestApi 继承Network，重写指定的func 就可以请求对应的接口了。可以很方便的响应网络层架构。

新建一个class 
``` swift
class TestApi : Network {
  func requestUrl() -> String {
    return "/test/info";
  }
  func requestTimeoutInterval -> Double {
    return 10;  
  }
}
```

以下对func 使用介绍:
1.func requestUrl() -> String {} 
重写override func 获取到指定的接口名称

2.func requestTimeoutInterval() -> Double {}
重写override func 获取到该次网络请求的超时时间

3.func requestMethod() ->RequestMethod {}
重写override func 获取到该次请求的请求方式，可选.post,.get,.patch,.put。不满足你需求你可以自己添加对应的上去。

4.func requestParams() -> Any? {}
重写override func 获取指定的传递参数。

headers 也可以传参数或者链接url中也可以传递对应的参数，需要的实现方式可以自己拓展。

please contact with me by iOSLiuYong2012@163.com
