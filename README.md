# api-param-limit

该插件用于对定义的由kong代理的api进行参数校验操作，校验内容主要包括参数类型/min/max值等

## 目录结构

```
api-param-limit
├─ api-param-limit-0.0.1-1.rockspec  //插件使用luarocks安装卸载，rockspec是插件包的安装描述文件
└─ kong
   └─ plugins
      └─ api-param-limit
         ├─ handler.lua //基础模块，封装openresty的不同阶段的调用接口
         ├─ schema.lua //schema配置模块，定义插件的config配置
         ├─ access.lua //access阶段的处理模块
         └─ path_params.lua //path参数处理模块
```

## 使用说明

该插件主要应用于kong route对象，支持http/https协议。kong插件配置说明：

```
config.api_fr_path kong代理的api请求路径，path中可携带参数，比如/get/{id}/info
config.api_fr_params  kong代理的api中，在path上的请求参数组成的列表，比如/get/{id2}/info/{name},即为id2,name
config.param_limits[].name api参数名称
config.param_limits[].location api参数位置
config.param_limits[].required 参数是否必填
config.param_limits[].default 默认值
config.param_limits[].type 参数类型
config.param_limits[].max 参数最大值（应用与数字类型）
config.param_limits[].min 参数最小值（应用与数字类型）

```

## 例子

假设用户想通过kong代理的对外暴露的api定义为：
```
HEAD
...
b x
...
GET /anything/{id}/info?a=x&c=x
```
其中定义：
1. a的值为数字类型，范围[1,10]，必填
2. b的值为string,在请求头,必填
3. c为非必填参数，默认值为10，数字类型
4. id的值为num

则对应于`api-param-limit`插件，其定义为：
```json
{
    "name": "api-param-limit",
    "config": {
        "api_fr_path":"/anything/{id}/info",
        "api_fr_params":["id"],
        "param_limits": [
            {
                "name": "a",
                "location": "query",
                "required": true,
                "type": "number",
                "max": 10,
                "min": 10
            },
            {
                "name": "b",
                "location": "head",
                "required": true,
                "type": "string"
            },
            {
                "name": "c",
                "location": "query",
                "required": false,
                "default": "10",
                "type": "number"
            },
            {
                "name": "id",
                "location": "path",
                "required": true,
                "default": "11",
                "type": "string"
            }
        ]
    }, 
    "enabled": true
}
```



