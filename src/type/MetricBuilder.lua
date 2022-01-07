---@class MetricBuilder
---@field public host string
---@field public interval number
---@field public name string
---@field public points table
---@field public tags table
---@field public type MetricType
MetricBuilder = {}

---new
---@return MetricBuilder
---@public
function MetricBuilder:new()
    local object = {}
    setmetatable(object, self)
    self.__index = self
    self.points = {}
    self.tags = {}
    return self
end

---setHost
---@param host string
---@return MetricBuilder
---@public
function MetricBuilder:setHost(host)
    self.host = host
    return self
end

---setInterval
---@param interval number
---@return MetricBuilder
---@public
function MetricBuilder:setInterval(interval)
    self.interval = interval
    return self
end

---setName
---@param name string
---@return MetricBuilder
---@public
function MetricBuilder:setName(name)
    self.name = name
    return self
end

---setPoints
---@param points table
---@return MetricBuilder
---@public
function MetricBuilder:setPoints(points)
    self.points = points
    return self
end

---setTags
---@param tags table
---@return MetricBuilder
---@public
function MetricBuilder:setTags(tags)
    self.tags = tags
    return self
end

---setType
---@param type MetricType
---@return MetricBuilder
---@public
function MetricBuilder:setType(type)
    self.type = type
    return self
end


---addPoint
---@param point table
---@return MetricBuilder
---@public
function MetricBuilder:addPoint(point)
    table.insert(self.points, point)
    return self
end

---addTag
---@param tag table
---@return MetricBuilder
---@public
function MetricBuilder:addTag(tag)
    table.insert(self.tags, tag)
    return self
end

---valide
---@return boolean
---@public
function MetricBuilder:validate()
    return (self.name ~= nil and self.points ~= nil and #self.points > 0)
end

function MetricBuilder:build()
    if (not (self:validate())) then
        DataDogAPI:throw("Cannot build metric, invalid builder data")
        return nil
    end
    local body = {}
    body.host = self.host
    body.interval = self.interval
    body.metric = self.name
    body.points = self.points
    body.tags = self.tags
    body.type = self.type
    return body
end