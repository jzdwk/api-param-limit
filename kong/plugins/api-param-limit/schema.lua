local typedefs = require "kong.db.schema.typedefs"
--local Schema = require("kong.db.schema")

local PARAM_LOCATION = {
  "query","path","head"
}

local PARAM_TYPE = {
  "string","number"
}

local param_limits = {
  type = "array",
  require = true,
  elements = limit_conf,
}

local api_fr_path_params = {
  type = "array",
  default = {},
  elements = { type = "string", match = "^[^/]+$" },
}

local limit_conf = {
  type = "record"
  fields = {
   { name = { type = "string", required = true}},
   { location = { type = "string", required = true, one_of = LOCATION}},
   { required = {type = "boolean", required = false, default = false}},
   { default = {type = "string", required = false}},
   { type = {type = "string", required = true, one_of = PARAM_TYPE}},
   { max = {type = "number", required = false}},
   { min = {type = "number", required = false}},
 } 
}
--[[
"config":{
  "param_limits":[
  {
    "name":xxx,
    "location":0
    "required":false,
    "default":"xxxx",
    "type":"xxx",
    "max":"xx",
    "min":"xx"
  },
  {
    "name":xxx,
    "location":1
    "required":false,
    "default":"xxxx",
    "type":"xxx",
    "max":"xx",
    "min":"xx"
  }
  ]
}
]]--

return {
  name = 'api-param-limit',
  fields = {
    -- only valid in route
    { consumer = typedefs.no_consumer },
    { service = typedefs.no_service   }，
    {
      config = {
        type = "record",
        fields = {
          { api_fr_path = { type = "string"} },
          { api_fr_params = api_fr_path_params },
          { param_limits = param_limits }
          }
        }
      }
    }
  }
}
