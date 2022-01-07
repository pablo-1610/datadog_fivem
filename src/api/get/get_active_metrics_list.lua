-- https://docs.datadoghq.com/fr/api/latest/metrics/#get-active-metrics-list

---performGetActiveMetricsList
---@param consumer function
---@param from string
---@param host string
---@param tag_filter string
---@return void
function DataDogApplication:performGetActiveMetricsList(consumer, from, host, tag_filter)
    if (not (from)) then
        DataDogAPI:throw("missing argument #1 (from)")
        return
    end
    self:validateAction(function()
        local URL = ("%s?from=%s"):format(API_URL.METRICS, from) .. (host and ("&host=%s"):format(host) or "") .. (tag_filter and (("&tag_filter=%s"):format(tag_filter)) or "")
        PerformHttpRequest(URL, function(code, data)
            self:trace("GetActiveMetricsList", URL, code)
            consumer(code == 200 and json.decode(data) or {})
        end, API_METHOD.GET, nil, self:getRequestHeaders())
    end)
end