local BasePlugin = require "kong.plugins.base_plugin"
local access = require "kong.plugins.api-param-limit.access"


local ApiParamLimitHandler = BasePlugin:extend()

function ApiParamLimitHandler:new()
  ApiParamLimitHandler.super.new(self, "api-param-limit")
end

function ApiParamLimitHandler:access(conf)
  ApiParamLimitHandler.super.access(self)
  access.execute(conf)
end

--before api transformer
ApiParamLimitHandler.PRIORITY = 16

return ApiParamLimitHandler
