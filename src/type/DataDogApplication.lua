---@class DataDogApplication
---@field public applicationKey string
---@field public debug boolean
DataDogApplication = {}

---new
---@param applicationKey string
---@return DataDogApplication
---@public
function DataDogApplication:new(applicationKey, debug)
    local object = {}
    setmetatable(object, self)
    self.__index = self
    self.debug = (debug or false)
    self.applicationKey = applicationKey
    return self
end

---getApplicationKey
---@return string
---@public
function DataDogApplication:getApplicationKey()
    return self.applicationKey
end

---getRequestHeaders
---@return table
---@public
function DataDogApplication:getRequestHeaders()
    return {
        ["Content-Type"] = HEADER_CONTENT_TYPE.APPLICATION_JSON,
        ["DD-API-KEY"] = DataDogAPI:getApiKey(),
        ["DD-APPLICATION-KEY"] = self.applicationKey
    }
end

---getCustomRequestHeaders
---@return table
---@public
function DataDogApplication:getCustomRequestHeaders(contentType)
    return {
        ["Content-Type"] = contentType,
        ["DD-API-KEY"] = DataDogAPI:getApiKey(),
        ["DD-APPLICATION-KEY"] = self.applicationKey
    }
end

---validateAction
---@param action string
---@return void
---@public
function DataDogApplication:validateAction(action)
    if (not (self.applicationKey) or not (DataDogAPI:getIsReady())) then
        DataDogAPI:severe("Application key is not set or DataDog is not ready")
        return
    end
    action()
end

---trace
---@param method string
---@param code string
---@return void
---@public
function DataDogApplication:trace(method, url, code, data)
    if (self.debug) then
        DataDogAPI:log(("[^5?^7] Method ^5%s^7 (^6%s^7) returned code ^5%s^7"):format(method, url, code))
        if (data) then
            DataDogAPI:log(("[^5?^7] Data: ^5%s^7"):format(data))
        end
    end
end