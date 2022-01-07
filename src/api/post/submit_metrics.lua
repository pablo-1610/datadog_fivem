-- https://docs.datadoghq.com/fr/api/latest/metrics/#submit-metrics

local function createSeriesPayload(metrics)
    local payload = {}
    payload.series = {}
    for _, metric in pairs(metrics) do
        table.insert(payload.series, metric)
    end
    return json.encode(payload)
end

---performSubmitMetric
---@param consumer function
---@param metricBuilder MetricBuilder
---@return void
function DataDogApplication:performSubmitMetric(consumer, metricBuilder)
    if (not (metricBuilder)) then
        DataDogAPI:throw("missing argument #1 (metricBuilder)")
        return
    end
    self:validateAction(function()
        local URL = API_URL.SERIES
        local payload = createSeriesPayload({metricBuilder:build()})
        PerformHttpRequest(URL, function(code, data)
            self:trace("SubmitMetric", URL, code, data)
            consumer(code == 202)
        end, API_METHOD.POST, payload, DataDogAPI:getCustomRequestHeaders(HEADER_CONTENT_TYPE.TEXT_JSON))
    end)
end

-- TODO : Does not work, need to investigate
---performSubmitMetrics
---@param consumer function
---@param metricBuilders table<MetricBuilder>
---@return void
function DataDogApplication:performSubmitMetrics(consumer, metricBuilders)
    if (not (metricBuilders)) then
        DataDogAPI:throw("missing argument #1 (metricBuilders)")
        return
    end
    self:validateAction(function()
        local URL = API_URL.SERIES
        for k, v in pairs(metricBuilders) do
            metricBuilders[k] = v:build()
        end
        local payload = createSeriesPayload(metricBuilders)
        print(payload)
        PerformHttpRequest(URL, function(code, data)
            self:trace("SubmitMetrics", URL, code, data)
            consumer(code == 202)
        end, API_METHOD.POST, payload, DataDogAPI:getCustomRequestHeaders(HEADER_CONTENT_TYPE.TEXT_JSON))
    end)
end