package = "kong-plugin-api-param-limit"
version = "0.0.1-1"

source = {
  url = "https://github.com/jzdwk/api-param-limit",
  tag = "v0.0.1-1"
}

supported_platforms = {"linux"}

description = {
  summary = "Api Plugin",
}

dependencies = {
   "lua >= 5.1"
}

build = {
  type = "builtin",
  modules = {
    ["kong.plugins.api-param-limit.handler"] = "kong/plugins/api-param-limit/handler.lua",
    ["kong.plugins.api-param-limit.schema"] = "kong/plugins/api-param-limit/schema.lua",
    ["kong.plugins.api-param-limit.access"] = "kong/plugins/api-param-limit/access.lua",
    ["kong.plugins.api-param-limit.path_params"] = "kong/plugins/api-param-limit/path_params.lua"
  }
}
