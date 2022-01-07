---@type table
local applications = {}

---applicationExists
---@param name string
---@return boolean
---@public
local function applicationExists(applicationId)
    for applicationId, _ in pairs(applications) do
        if applicationId == applicationId then
            return true
        end
    end
    return false
end

AddEventHandler("ddfl:setApiKey", function(apiKey)
    DataDogAPI:setApiKey(apiKey)
end)

AddEventHandler("ddfl:setApplication", function(name, applicationKey, debug)
    local application = DataDogAPI:newApplication(applicationKey, debug)
    if (debug) then
        DataDogAPI:log(("New application instance created for %s"):format(name))
    end
    applications[name] = application
end)

-- GET
AddEventHandler("ddfl:getActiveMetrics", function(applicationId, consumer, from, host, tag_filer)
    if (not (applicationExists(applicationId))) then
        DataDogAPI:severe(("Trying to use an invalid application: %s"):format(applicationId))
        return
    end
    ---@type DataDogApplication
    local application = applications[applicationId]
    application:performGetActiveMetricsList(consumer, from, host, tag_filer)
end)

AddEventHandler("ddfl:getMetricMetadata", function(applicationId, consumer, metric_name)
    if (not (applicationExists(applicationId))) then
        DataDogAPI:severe(("Trying to use an invalid application: %s"):format(applicationId))
        return
    end
    ---@type DataDogApplication
    local application = applications[applicationId]
    application:performGetMetricMetadata(consumer, metric_name)
end)

AddEventHandler("ddfl:getMetricTagConfiguration", function(applicationId, consumer, metric_name)
    if (not (applicationExists(applicationId))) then
        DataDogAPI:severe(("Trying to use an invalid application: %s"):format(applicationId))
        return
    end
    ---@type DataDogApplication
    local application = applications[applicationId]
    application:performGetMetricMetadata(consumer, metric_name)
end)

---@param metricBuilder MetricBuilder
AddEventHandler("ddfl:submitMetric", function(applicationId, consumer, metricTable)
    if (not (applicationExists(applicationId))) then
        DataDogAPI:severe(("Trying to use an invalid application: %s"):format(applicationId))
        return
    end
    ---@type DataDogApplication
    local application = applications[applicationId]
    local metricBuilder = MetricBuilder.getMetricBuilderFromTableData(metricTable)
    application:performSubmitMetric(consumer, metricBuilder)
end)