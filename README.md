<img align="right" src="https://cdn-ak.f.st-hatena.com/images/fotolife/n/nekonenene/20170508/20170508180215.png" height="200" width="200">

![GitHub pull requests](https://img.shields.io/github/issues-pr/PABLO-1610/datadog-fivem)
![GitHub issues](https://img.shields.io/github/issues/PABLO-1610/datadog-fivem)
![Twitter Follow](https://img.shields.io/twitter/follow/Pablo1610_?style=social)
![GitHub Repo stars](https://img.shields.io/github/stars/PABLO-1610/datadog-fivem?style=social)

# DataDog FiveM Library (DDFL)

DDFL allows your FiveM server to interact with the DataDog REST API through HTTP requests.
This can be useful if you want to monitor your server, measure its growth or simply collect statistics.

## Summary

1) [Credits](#credits)
3) [Installation](#how-to-install)
4) [Usage](#usage)
5) [Queries](#queries)
6) [To-do](#todo-list)

## Credits

DDFL by [Pablo Z.](https://github.com/PABLO-1610) ([Discord](https://discord.gg/Y9HJw4u6Hh))

## How to install

To install this library, you just need to download it (or clone it) 
and then add `ensure datadog-fivem` to your `server.cfg`.

If you want, you can define your API key directly using the convar `datadog_api_key`. 

Otherwise, use the `ddfl:setApiKey` event by passing your API key as a parameter to the event.

## Usage

To use DDFL, you must make sure that DDFL is started before any other script that will use it.

To make queries, you must authenticate with an application key. Create your authorization with this line;

`TriggerEvent('ddfl:setApplication', 'myApplicationName', 'myApplicationKey')`

`TriggerEvent('ddf:setApplication', 'myApplicationName', 'myApplicationKey', true)` (With logs)

## Queries

Here are the current possible queries

<hr/>

### [Submit metric(s)](https://docs.datadoghq.com/fr/api/latest/metrics/#submit-metrics)
#### Submit one metric
**Requiered**:
- `metricTable`
```lua
TriggerEvent("ddfl:submitMetric", "myApplication", function(success)
    -- Code
end, metricTable)
```
Example:
```lua
TriggerEvent("ddfl:submitMetric", "myApplication", function(success)
    if (success) then
        print("Metric submitted")
    else
        print("Metric failed to submit")
    end
end, { metric = "test.metric", type = "gauge", points = { { os.time(), 1.5 } }, tags = { "user:me", "test:ok" } })
```

<hr/>

### [Get active metrics](https://docs.datadoghq.com/fr/api/latest/metrics/#get-active-metrics-list)
**Requiered**:
- `from`

**Optional**:
- `host`
- `tag`
```lua
TriggerEvent("ddfl:getActiveMetrics", "myApplication", function(data)
    local metrics = data.metrics
    for k,v in pairs(metrics) do
      print("-> " .. v)
    end
end, from, host, tag)
```

<hr/>

### [Get metric metadata](https://docs.datadoghq.com/fr/api/latest/metrics/#get-metric-metadata)
**Requiered**:
- `metric_name`
```lua
TriggerEvent("ddfl:getMetricMetadata", "myApplication", function(data)
    print(json.encode(data))
end, metric_name)
```

<hr/>

### (⭐) [Get metric tag configuration](https://docs.datadoghq.com/fr/api/latest/metrics/#list-tag-configuration-by-name)
**__Warning__**: only accessible for Metrics without Limits™ users

**Requiered**:
- `metric_name`
```lua
TriggerEvent("ddfl:getMetricTagConfiguration", "myApplication", function(data)
    print(json.encode(data))
end, metric_name)
```

<hr/>

### TODO List
#### Done
✅ • [Submit Metrics](https://docs.datadoghq.com/fr/api/latest/metrics/#submit-metrics) ([usage](https://github.com/PABLO-1610/datadog-fivem#submit-metrics))<br/>
✅ • [Get active metrics](https://docs.datadoghq.com/fr/api/latest/metrics/#get-active-metrics-list) ([usage](https://github.com/PABLO-1610/datadog-fivem/#get-active-metrics))<br/>
✅ • [Get metric metadata](https://docs.datadoghq.com/fr/api/latest/metrics/#get-metric-metadata) ([usage](https://github.com/PABLO-1610/datadog-fivem/#get-metric-metadata))<br/>
✅ • [Get metric tag configuration](https://docs.datadoghq.com/fr/api/latest/metrics/#list-tag-configuration-by-name) ([usage](https://github.com/PABLO-1610/datadog-fivem/#-get-metric-tag-configuration))
#### To do
⌛ • [Create a tag configuration](https://docs.datadoghq.com/fr/api/latest/metrics/#create-a-tag-configuration)<br/>
⌛ • [Edit metric metadata](https://docs.datadoghq.com/fr/api/latest/metrics/#edit-metric-metadata)<br/>
⌛ • [Edit tag configuration](https://docs.datadoghq.com/fr/api/latest/metrics/#update-a-tag-configuration)<br/>
⌛ • [Delete tag configuration](https://docs.datadoghq.com/fr/api/latest/metrics/#delete-a-tag-configuration)<br/>
⌛ • [Search metrics](https://docs.datadoghq.com/fr/api/latest/metrics/#search-metrics)<br/>
⌛ • [List tag configuration](https://docs.datadoghq.com/fr/api/latest/metrics/#list-tag-configurations)<br/>
⌛ • [Get timeseries points](https://docs.datadoghq.com/fr/api/latest/metrics/#query-timeseries-points)<br/>
⌛ • [List tags by metric name](https://docs.datadoghq.com/fr/api/latest/metrics/#list-tags-by-metric-name)<br/>
⌛ • [List distinct metric volume by metric name](https://docs.datadoghq.com/fr/api/latest/metrics/#list-distinct-metric-volumes-by-metric-name)<br/>


                                                                                                                               
