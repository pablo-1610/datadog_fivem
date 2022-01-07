-- This is an example of how to use the DataDog FiveM API.

---@type DataDogApplication
local application = DataDogAPI:newApplication("yourApplicationKey", true)

-- Get metric(s)
RegisterCommand("ddf_get_metrics", function()
    local time = (os.time() - (60 * 60))
    application:performGetActiveMetricsList(function(data)
        -- Consumer
        print("Active metrics:")
        for metricId, metric in pairs(data.metrics) do
            print(("- %s"):format(metric))
        end
    end, time, nil, nil) -- You can also include tag_filter or host
end)

-- Get metric data
RegisterCommand("ddf_get_metricMetadata", function()
    local myMetricName = "test.datadog.fivem"
    application:performGetMetricMetadata(function(data)
        -- Consumer
        print("Metadata for metric " .. myMetricName .. ":")
        print(json.encode(data))
    end, myMetricName)
end)

-- Submit a single metric
RegisterCommand("ddf_submit_metric", function()
    local myMetric = MetricBuilder:new()
                                  :setName("test.datadog.fivem.single")
                                  :setType(METRIC_TYPE.GAUGE)
                                  :addPoint({ os.time(), 2.0 })
    application:performSubmitMetric(function(success)
        if (success) then
            print("Oh nice, your metric has been submitted!")
        end
    end, myMetric)
end)

-- Submit a single metric with multiple points
RegisterCommand("ddf_submit_metric2", function()
    local myMetric = MetricBuilder:new()
                                  :setName("test.datadog.fivem.multiple")
                                  :setType(METRIC_TYPE.GAUGE)
                                  :addPoint({ os.time(), 2.0 })
                                  :addPoint({ os.time() - (60 * 5), 3.0 })
    application:performSubmitMetric(function(success)
        if (success) then
            print("Oh nice, your metric has been submitted, and your second point has been submitted too!")
        end
    end, myMetric)
end)

-- Submit a single metric with tags
RegisterCommand("ddf_submit_metric3", function()
    local myMetric = MetricBuilder:new()
                                  :setName("test.datadog.fivem.tag")
                                  :setType(METRIC_TYPE.GAUGE)
                                  :addPoint({ os.time(), 2.0 })
                                  :addTag("type:test")
                                  :addTag("user:myself")
    application:performSubmitMetric(function(success)
        if (success) then
            print("Oh nice, your metric has been submitted with tags!")
        end
    end, myMetric)
end)

-- Submit multiple metrics
RegisterCommand("ddf_submit_metric4", function()
    local myMetric1 = MetricBuilder:new()
                                  :setName("test.datadog.fivem.multiple1")
                                  :setType(METRIC_TYPE.GAUGE)
                                  :addPoint({ os.time(), 2.0 })
    local myMetric2 = MetricBuilder:new()
                                  :setName("test.datadog.fivem.multiple2")
                                  :setType(METRIC_TYPE.GAUGE)
                                  :addPoint({ os.time() - (60 * 5), 3.0 })
    application:performSubmitMetrics(function(success)
        if (success) then
            print("Oh nice, your metrics have been submitted!")
        end
    end, { myMetric1, myMetric2 })
end)