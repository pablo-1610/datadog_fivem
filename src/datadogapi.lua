---@class DatadogAPI
---@field public apiKey string
---@field public ready boolean
DataDogAPI = {}

DataDogAPI.ready = false

---log
---@param message string
---@return void
---@public
function DataDogAPI:log(message)
    print(("[^5DatadogAPI^7] %s"):format(message))
end

---severe
---@param message string
---@return void
---@public
function DataDogAPI:severe(message)
    print(("[^5DatadogAPI^7] (^1!^7) %s"):format(message))
end

---throw
---@param message string
---@return void
---@public
function DataDogAPI:throw(message)
    error(("[DatadogAPI] %s"):format(message))
end

---getApiKey
---@return string
---@public
function DataDogAPI:getApiKey()
    return self.apiKey
end

---getIsReady
---@return boolean
---@public
function DataDogAPI:getIsReady()
    return self.ready
end

---getRequestHeaders
---@return table
---@public
function DataDogAPI:getRequestHeaders()
    return {
        ["Content-Type"] = HEADER_CONTENT_TYPE.APPLICATION_JSON,
        ["DD-API-KEY"] = self.apiKey
    }
end

---getCustomRequestHeaders
---@param contentType string
---@return table
---@public
function DataDogAPI:getCustomRequestHeaders(contentType)
    return {
        ["Content-Type"] = contentType,
        ["DD-API-KEY"] = self.apiKey
    }
end

---setApiKey
---@param apiKey string
---@return void
---@public
function DataDogAPI:setApiKey(apiKey)
    self.apiKey = apiKey
    self:validateApiKey()
end

---validateApiKey
---@return void
---@public
function DataDogAPI:validateApiKey()
    self:log("Validating API key...")
    PerformHttpRequest(API_URL.API_KEY_VALIDATION, function(code, _, _)
        if (code ~= 200) then
            error(("[DatadogAPI] API key validation failed with code %s"):format(code))
        else
            self.ready = true
            self:log("API key is valid")
        end
    end, 'GET', nil, self:getRequestHeaders())
end

---newApplication
---@param applicationKey string
---@param debug boolean
---@return DataDogApplication
---@public
function DataDogAPI:newApplication(applicationKey, debug)
    return DataDogApplication:new(applicationKey, debug)
end

local defaultApiKey = GetConvar("datadog_api_key", "undefined")
if (defaultApiKey == "undefined") then
    DataDogAPI:log("No API key set. Please set the ^5datadog_api_key^7 convar or set the apiKey via ^5DataDogAPI:setApiKey(apiKey) ^7!")
else
    DataDogAPI:setApiKey(defaultApiKey)
end

