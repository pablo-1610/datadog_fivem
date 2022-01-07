-- https://docs.datadoghq.com/fr/api/latest/metrics/#list-tag-configuration-by-name

--[[

Note: Use of this endpoint for count/gauge/rate metric types is only accessible for Metrics without Limits™ beta customers.

--]]

---performGetMetricTagConfiguration
---@param consumer function
---@param metric_name string
---@return void
function DataDogApplication:performGetMetricTagConfiguration(consumer, metric_name)
    if (not (metric_name)) then
        DataDogAPI:throw("missing argument #1 (metric_name)")
        return
    end
    self:validateAction(function()
        local URL = ("%s/%s/tags"):format(API_URL.V2_METRICS, metric_name)
        PerformHttpRequest(URL, function(code, data)
            self:trace("GetMetricTagConfiguration", URL, code)
            consumer(code == 200 and json.decode(data) or {})
        end, API_METHOD.GET, nil, self:getRequestHeaders())
    end)
end