# Templates
- show/hide toolbar: `F1` or button `<left>`
- show/hide zawartość: button `<switch>`

Button `Save template` - don't forget to press it after you made some changes in template.

## Shader
Name is used as an ID in `shader spawn brush`.

Shader contains dynamic fields, most of them are type of `NumberTransformer`.
`value` represents value at the begining. 
`target` set destination value. 
`factor` defines the number that will be added to `value` every frame.
`increase` defines the number that will be used to increment `factor` value every frame.

## Shroom
Name is used as an ID in `shroom spawn brush`.

### Set texture
Use texture name from `texture templates`.
If `Animate` is set to true then ignore `Frame` input.

### Mask
Define custom rectangular collision mask, usefull if sprite contains transparent borders.

### Bullethell, Platformer, Idle
Valid JSON Array of `Feature` objects. See `utilizing-json-for-behavior-definition.md`.

## Bullet
Name can be used as an ID in `shroom templates` within JSON configs (BulletHell, Platformer, Idle).

### Set texture
Use texture name from `texture templates`.
If `Animate` is set to true then ignore `Frame` input.

### Mask
Define custom rectangular collision mask, usefull if sprite contains transparent borders.

### Bullethell, Platformer, Idle
Valid JSON Array of `Feature` objects. See `utilizing-json-for-behavior-definition.md`.

## Lyrics
Name is used as an ID in `view lyrics brush`. 

### Lines
Type your lyrics here, use enter for next line. Single line can contain max 80 characters.

## Particle
Name is used as an ID in `grid particle brush`.

### Particle preview
Render preview on grid.

### Shape
Define the shape of the particle. Ignored if `Set texture` is enabled.

### Blend
Define if particles will be rendered with blend mode enabled.

### Set texture
Use texture name from `texture templates`.
If `Set texture` is set to true then previous input `Shape` will be ignored

### Start color
Definie initial color

### Halfway color
Define target color that will be reached at half of particle lifetime

### Finish color
Define target color that will be reached at the end of particle lifetime

### Alpha
Define alpha value of `start color`, `halfway color` and `finish color`

### Angle

### Size

### Speed

### Scale
XY scale of texture or shape of particle.

### Gravity
By applying gravity to particles you can change their movement.

### Life
Lifetime of particles will be a random number between `Min` and `Max`.

### Orientation


## Texture
Name is used in `shroom templates`, `bullet templates`, `particle templates` and `view wallpaper brush`.
Supported formats: 
 - png
 - gif
 - jpg
 - bmp
Remember that `gif` will load only first frame (GameMaker limitation). 
Animations can be imported from strips, which is a single image that contains every frame. 
If texture is a strip then you should set frames value to be equal of amount of frames within the image.
Example of strip image:
`<strip-image>`