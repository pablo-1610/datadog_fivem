<img align="right" src="https://cdn-ak.f.st-hatena.com/images/fotolife/n/nekonenene/20170508/20170508180215.png" height="200" width="200">

![GitHub labels](https://img.shields.io/github/labels/PABLO-1610/datadog-fivem/help-wanted)
![GitHub pull requests](https://img.shields.io/github/issues-pr/PABLO-1610/datadog-fivem)
![GitHub issues](https://img.shields.io/github/issues/PABLO-1610/datadog-fivem)
![Twitter Follow](https://img.shields.io/twitter/follow/Pablo1610_?style=social)
![GitHub Repo stars](https://img.shields.io/github/stars/PABLO-1610/datadog-fivem?style=social)

# DataDog FiveM Library (DDFL)

DDFL allows your FiveM server to interact with the DataDog REST API through HTTP requests.
This can be useful if you want to monitor your server, measure its growth or simply collect statistics.

## Installation

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



                                                                                                                               
