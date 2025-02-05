# Render pipeline

render():
 - if render bkgSurface then select bkgSurface
 - if bkgClear then draw clear bkgColor
 - if video then draw video
 - draw bkg
 - reset surface target 

 - if render bkgShaderSurface then select bkgShaderSurface
 - if bkShaderSurfaceClear then draw clear bkgShaderSurfaceColor
 - for each bkgShader draw bkgSurface
 - reset surface target

 - if render gridSurface then select gridSurface
 - if gridClear then draw clear gridColor
 - draw grid
 - reset surface target

 - if render gridShaderSurface then select gridShaderSurface
 - if gridShaderClear then draw clear gridShaderColor
 - for each gridShader draw gridSurface
 - reset surface target

 - select gameSurface
 - draw clear black with alpha 0.0
 - if render bkgSurface then draw bkgSurface
 - if render bkgShaderSurface then draw bkgShaderSurface
 - if render gridSurface then draw gridSurface
 - if render gridShaderSurface then draw gridShaderSurface
 - if render helpGrid then draw gridSurface with helpGridSettings
 - if render foreground then draw foreground
 - reset surface target

 - if render combinedShaderSurface then select combinedShaderSurface
 - draw clear black with alpha 0.0
 - for each combinedShader draw gameSurface
 - reset surface target

renderGUI():
 - if render bktGlitch then draw gameSurface with bktGlitchSettings else draw gameSurface
 - if render subtitle then draw subtitle
 - if render HUD then draw HUD 


# Fancy blending concept
For each task in overlayrenderer:
- Clear source
- Clear target
- On target draw surface
- On source draw task
- On surface set shader with target as a sampler, draw source
```gml
///@description pseudocode

backgroundSurface.clear()
backgrounds.forEach(function(background) {
  backgroundTmpSurface
    .clear(c_black, 0.0)
    .render(function(data) {
      data.render()
    }, background)

  backgroundSurface
    .render(function(data) {
      data.shader.set().setUniform("u_BlendMode", data.blendMode)
      data.backgroundTmpSurface.render()
      data.shader.reset()
    })
})

source.clear().render(background)
surface_set(surface)
shader_set(blending)
shader_set_uniform_i(blendmode)
texture_set_stage(target)
draw_surface(sourc0e)
shader_reset()
surface_reset()
```