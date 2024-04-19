# Utilizing JSON for Behavior Definition: A Solo Developer's Approach

In my game development project, I've opted to leverage JSON for defining enemy and bullet behaviors, eliminating the need for project compilation. JSON serves as a lightweight alternative, requiring only parsing without the necessity of compilation. This choice offers several advantages:

1. Simplicity: JSON provides a straightforward, human-readable format for defining behaviors, enabling quick iteration and adjustments without the overhead of compilation.

2. Flexibility: With JSON, I can easily tweak behavior parameters and patterns, facilitating rapid prototyping and experimentation during development.

3. Maintainability: Separating behavior definitions from core code ensures a cleaner, more manageable codebase, simplifying debugging and future updates.

4. Accessibility: JSON's intuitive structure makes it easy to understand and modify behavior definitions, even for non-programmers or collaborators who may not be familiar with the intricacies of game development.

By embracing JSON for behavior definition, I streamline my development process, allowing for more efficient iteration and ultimately delivering a polished gaming experience. Let's dive into how JSON empowers me to craft dynamic and engaging enemy and bullet behaviors for my game.

## Features

```json
[
  {
    "feature": "FEATURE_NAME",
    "conditions": [ ],
    "params...": "...values"
  }
]
```

A feature is an object placed within an array, which definitely contains a field called `feature`. The rest are optional; we can distinguish two categories: dedicated fields for specific "features" (see `params...`) and an array of objects `conditions`, which allows us to control under what conditions a given feature should operate.
The Feature is entered in the editor using a `text-area`.

As of today, there are `eleven` implemented features in `visu`:
- AngleFeature,
- BooleanFeature,
- CounterFeature,
- FollowPlayerFeature,
- KillFeature,
- LifespawnFeature,
- ParticleFeature,
- ShootFeature,
- SpeedFeature,
- SpriteFeature,
- SwingFeature.

### AngleFeature
Available fields:
- transform?: NumberTransformer
- add?: NumberTransformer

Usage example:
```json
[
  {
    "feature": "AngleFeature",
    "transform": {
      "value": 90.0,
      "target": 270.0,
      "factor": 1.0,
      "increase": 0.0
    }
  },
  {
    "feature": "AngleFeature",
    "add": {
      "target": 2.0,
      "factor": 0.01,
      "increase": 0.0
    }
  }
]
```
The difference between `transform` and `add` lies in how they affect the internal angle value of each object on the grid.
For transform, we specify that it should start from the `"value": 90.0` and end at `"target": 270.0`.
On the other hand, with add, the value is incremented each frame by `"factor": 0.01`, and then this value is directly added to the angle, which could be in any state.

### BooleanFeature
Available fields:
- field: String
- value?: Boolean

Usage example:
```json
[
  {
    "feature": "BooleanFeature",
    "field": "isBossKilled",
    "value": true
  }
]
```
Allows setting any `flag` that can later be read by other features or conditions.


### CounterFeature
Available fields:
- field: String
- value?: Number
- amount?: Number
- minValue?: Number
- maxValue?: Number

Usage example:
```json
[
  {
    "feature": "CounterFeature",
    "field": "hp",
    "value": 1,
    "amount": 0.5,
    "minValue": 1,
    "maxValue": 3,
  }
]
```
Allows setting a `numerical variable`. Additionally, we can specify whether we want the value to be incremented (or decremented if a negative value is provided) and within what range it should fall.


### FollowPlayerFeature
Available fields:
- value: NumberTransformer
- interval?: Number

Usage example:
```json
[
  {
    "feature": "FollowPlayerFeature",
    "interval": 1.0,
    "value": {
      "factor": 5.0,
      "increase": 0.1
    }
  }
]
```
This feature is designed to align the angle of the shroom with the player's angle. To specify the precision, you can use `interval` (i.e., how often the angle correction occurs). This parameter is optional, and you can provide only `value`, where you exceptionally omit value and target. These two values are dynamically replaced by the `FollowPlayerFeature` script.


### KillFeature
Usage example:
```json
[
  {
    "feature": "KillFeature"
  }
]
```
Adding such a feature without any conditions will cause the shroom to die immediately.


### LifespawnFeature
Available fields:
- duration: Number

Usage example:
```json
[
  {
    "feature":"LifespawnFeature",
    "duration": 10.0
  }
]
```
Using this feature, we can set the maximum lifespan for the shroom. In this case, when 10 seconds have passed since the mushroom's creation, it will be destroyed.


### ParticleFeature
Available fields:
- template: String,
- amount?: Number,
- interval?: Number,
- duration?: Number

Usage example:
```json
[
  {
    "feature":"ParticleFeature",
    "template": "particle_default",
    "amount": 10,
    "interval": 0.12,
    "duration": 1.2
  }
]
```
Allows emitting particles. The `amount` specifies the number of particles, while `duration` along with `interval` allow for their sequential emission. If we do not provide these two parameters, the `particles` will be created only once.


### ShootFeature
Available fields:
- bullet: String,
- speed: Number
- interval?: Number
- bullets?: Number

Usage example:
```json
[
  {
    "feature": "ShootFeature",
    "bullet": "bullet_default",
    "speed": 15,
    "interval": 0.5,
    "bullets": 7
  }
]
```
A simple feature allowing for shooting bullets. `bullets` allow specifying their finite amount (not providing this argument will be equivalent to an infinite amount of ammunition).


### SpeedFeature
Available fields:
- transform?: NumberTransformer
- add?: NumberTransformer
Usage example:

```json
[
  {
    "feature": "SpeedFeature",
    "transform": {
      "value": 90.0,
      "target": 270.0,
      "factor": 1.0,
      "increase": 0.0
    }
  },
  {
    "feature": "SpeedFeature",
    "add": {
      "value": 0.0,
      "target": 2.0,
      "factor": 0.01,
      "increase": 0.0
    }
  }
]
```
The principle of operation is exactly the same as in `AngleFeature`, with the difference that it modifies the internal variable `speed` instead of angle.


### SpriteFeature
Available fields:
- sprite: Sprite
- mask?: Rectangle

Usage example:
```json
[
  "feature": "SpriteFeature",
  "sprite": { "name": "texture_baron" },
  "mask": {
    "x": 32,
    "y": 32,
    "width": 128,
    "height": 128
  }
]
```
Using this feature, we can swap `textures` at runtime. `mask` allows for manipulating the `collision` mask.


### SwingFeature
Available fields:
- amount?: Number
- size?: Number

Usage example:
```json
[
  {
    "feature": "SwingFeature",
    "amount": 3.0,
    "size": 2.0
  }
]
```
With this feature, we can modify the trajectory of the shroom in such a way that it swings evenly.
The `amount` specifies by how much frames the timer looped in the range `from 0 to PI * 2` should be incremented, while the `size` value is used to multiply `cos(timer.update(amount)) * size`.



## Conditions

```json
[
  {
    "feature": "FEATURE_NAME",
    "conditions": [
      "type": "CONDITION_TYPE".
      "data": {
        "condition-params...": "...values"
      }
    ],
    "feature-params...": "...values"
  }
]
```

Conditions, like features, are objects placed within a collection. They are distinguished by the mandatory field `type`, which contains the name of the condition. Additional parameters can be added within the optional parameter `data`.
It is worth noting that Conditions do not exist independently of features, so they are also entered in the editor using a text-area.

As of today, there are `eight` implemented conditions in `visu`:
- boolean,
- kill,
- lifespawn,
- logic-gate
- numeric,
- player-distance,
- player-landed,
- player-leave.


### boolean
Available fields:
- value: Boolean
- field: String

Usage example:
```json
[
  {
    "feature": "BooleanFeature",
    "conditions": [
      {
        "type": "player-landed"
      }
    ],
    "field": "isBazyl",
    "value": true
  },
  {
    "feature":"SpriteFeature",
    "conditions": [
      {
        "type": "boolean",
        "data": {
          "field": "isBazyl",
          "value": true
        }
      }
    ],
    "sprite": {
      "name":"texture_bazyl"
    },
  }
]
```
When a player lands on a shroom with such features, its texture will be changed to `texture_bazyl`.


### kill
Usage example:
```json
[
  {
    "feature": "ParticleFeature",
    "conditions": [
      {
        "type": "kill"
      }
    ],
    "template": "particle_default",
    "amount": 100
  }
]
```
The feature will only be triggered at the moment of the shroom's death. As part of this event, 100 particles will be emitted from the template `particle_default` at the shroom coordinates.


### lifespawn
Available fields:
- value: Number
- operator: SimpleComparator

Usage example:
```json
[
  {
    "feature": "LifespawnFeature",
    "duration": 10.0
  },
  {
    "feature": "FollowPlayerFeature",
    "conditions": [
      {
        "type": "lifespawn",
        "data": {
          "opeartor": "greaterOrEqual",
          "value": 6.0
        }
      }
    ],
    "value": {
      "target": 360.0,
      "factor": 0.2
    }
  }
]
```
The shroom will start moving towards the player only after 6 seconds from its creation.
`SimpleOperator` is an enumeration type that can take the following values: `equal`, `greater`, `greaterOrEqual`, `less`, and `lessOrEqual`.


### logic-gate
Available fields:
- gate: SimpleLogicGate
- fieldA: String,
- fieldB: String

Usage example:
```json
[
  {
    "feature": "BooleanFeature",
    "conditions": [
      {
        "type": "player-landed"
      }
    ],
    "field": "A",
    "value": true
  },
  {
    "feature": "BooleanFeature",
    "conditions": [
      {
        "type": "player-leave"
      }
    ],
    "field": "B",
    "value": true
  },
  {
    "feature": "FollowPlayerFeature",
    "conditions": [
      {
        "type": "logic-gate",
        "data": {
          "operator": "and",
          "fieldA": "A",
          "fieldB": "B"
        }
      }
    ],
    "value": {
      "factor": 0.2,
      "increase": 0.01
    }
  }
]
```
The `FollowPlayerFeature` will start following the player only when the player lands on and leaves the `shroom`. The increase will increment the factor each frame, meaning that over time, the shroom will gradually move towards the `player`.
`SimpleLogicGate` is an enumeration type taht can take the following values: `and`, `or`, `not`, `nor`, `nand`, `xor`, `xnor`


### numeric
Available fields:
- value: Number
- field: String
- operator: SimpleComparator

Usage example:
```json
[
  {
    "feature": "CounterFeature",
    "conditions":[
      {
        "type":"player-landed"
      }
    ],
    "field": "hp",
    "value": 2,
    "amount": -1,
    "minValue": 0,
    "maxValue": 2,
  },
  {
    "feature": "KillFeature",
    "conditions": [
      {
        "type":"numeric",
        "data": {
          "operator": "lessOrEqual",
          "field": "hp",
          "value": 0.0
        }
      }
    ],
  }
]
```
In this case, you need to land twice on the same shroom for the `KillFeature` feature to be triggered.


### player-distance
Available fields:
- value: Number
- operator: SimpleComparator

Usage example:
```json
[
  {
    "feature": "AngleFeature",
    "conditions": [
      {
        "type": "player-distance",
        "data": {
          "value": 1.5,
          "operator": "less"
        }
      },
      {
        "type": "player-distance",
        "data": {
          "value": 0.5,
          "operator": "greater"
        }
      }
    ],
    "add": {
      "value": 0.0,
      "target": 2.0,
      "factor": 0.01,
      "increase": 0.0
    }
  }
]
```
If the shroom is at a distance from the player between `0.5` and `1.5`, it will rotate to the left at a maximum speed of `two degrees per frame`.


### player-landed
Usage example:
```json
[
  {
    "feature": "ParticleFeature",
    "conditions": [
      {
        "type": "player-landed"
      }
    ],
    "template": "particle_default",
    "amount": 10,
    "interval": 0.2,
    "duration": 1.5
  }
]
```
After the player lands on the shroom, for `1.5 seconds`, every `0.2` seconds, 10 `particle_default` particles will be generated.


### player-leave
Usage example:
```json
[
  {
    "feature": "ParticleFeature",
    "conditions": [
      {
        "type": "player-leave"
      }
    ],
    "template": "particle_default",
    "amount": 10,
    "interval": 0.2,
    "duration": 1.5
  }
]
```
Same as in `player-landed`, but triggered when the player leaves the shroom.
