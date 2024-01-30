# Shroom:
 - template: String
 - ?spawn: Vector2
 - ?angle: Number
 - ?speed: Number
```json
{
  "time": 0.12,
  "type": "Shroom",
  "data": {
    "template": "shroom-01",
    "spawn": { "x": 0.5, "y": 0.0 }
  }
}
```

# Particle:
 - particle: String
 - coords: Vector4
 - ?system: String
 - ?shape: ParticleShape
 - ?loop: Number
 - ?duration: Number
 - ?amount: Number
 - ?distribution: ParticleDistribution
```json
{
  "time": 0.44,
  "type": "Particle",
  "data": {
    "particle": "particle_boom",
    "coords": { "x": 0.5, "y": 0.5, "w": 0.2, "h": 0.2 },
    "amount": 20,
    "duration": 1
  }
}
```

# Background:
 - name: String
 - ?frame: Number
 - ?speed: Number
 - ?alpha: Number
 - ?angle: Number
 - ?blend: Color
 - ?animate: Boolean
```json
{
  "time": 0.99,
  "type": "Background",
  "data": {
    "name": "texture_bkg_01",
    "frame": 4,
    "animate": false
  }
}
```

# Foreground:
 - name: String
 - ?frame: Number
 - ?speed: Number
 - ?alpha: Number
 - ?angle: Number
 - ?blend: Color
 - ?animate: Boolean
```json
{
  "time": 0.99,
  "type": "Foreground",
  "data": {
    "name": "texture_bkg_02",
    "alpha": 0.5
  }
}
```

# Camera:
 - ?roll: Transform
 - ?pitch: Transform
 - ?zoom: Transform
```json
{
  "time": 1.44,
  "type": "Camera",
  "data": {
    "zoom": {
      "target": 2,
      "increase": 0.01
    }
  }
}
```

# Video:
 - render: Boolean
```json
{
  "time": 1.76,
  "type": "Video",
  "data": {
    "render": true
  }
}
```

# Shader:
 - template: String
 - duration: Number
```json
{
  "time": 2.41,
  "type": "Shader",
  "data": {
    "template": "Wave-template",
    "duration": 6.0
  }
}
```

# Lyrics:
 - template: String
```json
{
  "time": 2.93,
  "type": "Lyrics",
  "data": {
    "template": "Lyrics-01"
  }
}
```

# Grid:
 - property: String
 - transformer: Transformer
```json
{
  "time": 3.63,
  "type": "Grid",
  "data": {
    "primaryChannelsColor": {
      "target": "#5d67ca",
      "factor": 0.01
    },
    "channels": {
      "target": 10,
      "factor": 0.02
    }
  }
}
```