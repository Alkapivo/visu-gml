# Websocket

Run `wscat -c ws://localhost:8082`, API:
```json
{
  "event": "spawn-track-event",
  "data": {
    "callable":"brush_effect_shader",
    "config": {
      "ef-shd_pipeline":"BACKGROUND",
      "ef-shd_template":"star nest 01",
      "ef-shd_use-merge-cfg":false,
      "ef-shd_alpha":1.0,
      "icon":{
        "name":"texture_ve_icon_effect_shader",
        "blend":"#3564C5"
      },
      "ef-shd_duration":22.5,
      "ef-shd_fade-in":0.25,
      "ef-shd_fade-out":1.0,
      "ef-shd_merge-cfg":{
      }
    }
  }
}
```