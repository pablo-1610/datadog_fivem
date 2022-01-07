-- https://docs.datadoghq.com/fr/api/latest/metrics/#get-metric-metadata

---performGetMetricMetadata
---@param consumer function
---@param metric_name string
---@return void
function DataDogApplication:performGetMetricMetadata(consumer, metric_name)
    if (not (metric_name)) then
        DataDogAPI:throw("missing argument #1 (metric_name)")
        return
    end
    self:validateAction(function()
        local URL = ("%s/%s"):format(API_URL.METRICS, metric_name)
        PerformHttpRequest(URL, function(code, data)
            self:trace("GetMetricMetadata", URL, code)
            consumer(code == 200 and json.decode(data) or {})
        end, API_METHOD.GET, nil, self:getRequestHeaders())
    end)
end