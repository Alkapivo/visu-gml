///@package io.alkapivo.visu.editor.service.brush

function VEBrushService() constructor {

  ///@type {Map<String, Array>}
  templates = new Map(String, Array)

  ///@description init templates with VEBrushType keys
  VEBrushType.keys().forEach(function(key, index, templates) {
    templates.add(new Array(VEBrushTemplate), VEBrushType.get(key))
  }, this.templates)

  ///@param {VEBrushType} type
  ///@return {?Array}
  fetchTemplates = function(type) {
    var templates = this.templates.get(type)
    return Optional.is(templates) ? Assert.isType(templates, Array) : null
  }

  ///@param {VEBrushTemplate}
  ///@param {?Number} idx
  ///@return {VEBrushService}
  saveTemplate = function(template, idx = null) {
    if (!Core.isType(template, VEBrushTemplate)) {
      Logger.warn("VEBrushService::saveTemplate", $"Template must be type of VEBrushTemplate")
      return this
    }

    var templates = this.templates.get(template.type)
    if (!Core.isType(templates, Array)) {
      Logger.warn("VEBrushService", $"Unable to find template for type '{template.type}'")
      return this
    }

    var index = templates.findIndex(function(template, index, name) {
      return template.name == name
    }, template.name)

    if (Optional.is(index)) {
      //Logger.info("VEBrushService", $"Template of type '{template.type}' updated: '{template.name}'")
      templates.set(index, template)
    } else {
      //Logger.info("VEBrushService", $"Template of type '{template.type}' added: '{template.name}'")
      if (Core.isType(idx, Number)) {
        templates.add(template, idx)
      } else {
        templates.add(template)
      }
    }

    ///@description migration
    if (!Core.getProperty("visu.editor.migrate", false)) {
      return this
    }

    switch (template.type) {
      case VEBrushType.SHADER_SPAWN:
        var parsedTemplate = new VEBrushTemplate(JSON.clone(template.toStruct()))
        parsedTemplate.type = VEBrushType.EFFECT_SHADER
        parsedTemplate.properties = migrateShaderSpawnEvent(parsedTemplate)
        this.saveTemplate(parsedTemplate)
        break
      case VEBrushType.SHADER_OVERLAY:
        var parsedTemplate = new VEBrushTemplate(JSON.clone(template.toStruct()))
        parsedTemplate.type = VEBrushType.GRID_CONFIG
        ///@todo
        parsedTemplate.properties = migrateShaderOverlayEvent(parsedTemplate)
        this.saveTemplate(parsedTemplate)
        break
      case VEBrushType.SHADER_CLEAR:
        var parsedTemplate = new VEBrushTemplate(JSON.clone(template.toStruct()))
        parsedTemplate.type = VEBrushType.EFFECT_CONFIG
        ///@todo
        parsedTemplate.properties = migrateShaderClearEvent(parsedTemplate)
        this.saveTemplate(parsedTemplate)
        break
      case VEBrushType.SHADER_CONFIG:
        var parsedTemplate = new VEBrushTemplate(JSON.clone(template.toStruct()))
        parsedTemplate.type = VEBrushType.EFFECT_CONFIG
        parsedTemplate.properties = migrateShaderConfigEvent(parsedTemplate)
        this.saveTemplate(parsedTemplate)
        break
      case VEBrushType.SHROOM_SPAWN:
        var parsedTemplate = new VEBrushTemplate(JSON.clone(template.toStruct()))
        parsedTemplate.type = VEBrushType.ENTITY_SHROOM
        parsedTemplate.properties = migrateShroomSpawnEvent(parsedTemplate)
        this.saveTemplate(parsedTemplate)
        break
      case VEBrushType.SHROOM_CLEAR:
        var parsedTemplate = new VEBrushTemplate(JSON.clone(template.toStruct()))
        parsedTemplate.type = VEBrushType.ENTITY_CONFIG
        ///@todo
        parsedTemplate.properties = migrateShroomClearEvent(parsedTemplate)
        this.saveTemplate(parsedTemplate)
        break
      case VEBrushType.SHROOM_CONFIG:
        var parsedTemplate = new VEBrushTemplate(JSON.clone(template.toStruct()))
        parsedTemplate.type = VEBrushType.ENTITY_CONFIG
        ///@todo
        parsedTemplate.properties = migrateShroomConfigEvent(parsedTemplate)
        this.saveTemplate(parsedTemplate)
        break
      case VEBrushType.GRID_OLD_CHANNEL:
        var parsedTemplate = new VEBrushTemplate(JSON.clone(template.toStruct()))
        parsedTemplate.type = VEBrushType.GRID_COLUMN
        parsedTemplate.properties = migrateGridOldChannelEvent(parsedTemplate)
        this.saveTemplate(parsedTemplate)
        break
      case VEBrushType.GRID_OLD_COIN:
        var parsedTemplate = new VEBrushTemplate(JSON.clone(template.toStruct()))
        parsedTemplate.type = VEBrushType.ENTITY_COIN
        parsedTemplate.properties = migrateGridOldCoinEvent(parsedTemplate)
        this.saveTemplate(parsedTemplate)
        break
      case VEBrushType.GRID_OLD_CONFIG:
        var parsedTemplate = new VEBrushTemplate(JSON.clone(template.toStruct()))
        parsedTemplate.type = VEBrushType.GRID_CONFIG
        ///@todo
        parsedTemplate.properties = migrateGridOldConfigEvent(parsedTemplate)
        this.saveTemplate(parsedTemplate)

        parsedTemplate = new VEBrushTemplate(JSON.clone(template.toStruct()))
        parsedTemplate.type = VEBrushType.GRID_AREA
        ///@todo
        parsedTemplate.properties = migrateGridOldConfigToGridAreaEvent(parsedTemplate)
        this.saveTemplate(parsedTemplate)

        parsedTemplate = new VEBrushTemplate(JSON.clone(template.toStruct()))
        parsedTemplate.type = VEBrushType.ENTITY_CONFIG
        ///@todo
        parsedTemplate.properties = migrateGridOldConfigToEntityConfigEvent(parsedTemplate)
        this.saveTemplate(parsedTemplate)
        break
      case VEBrushType.GRID_OLD_PARTICLE:
        var parsedTemplate = new VEBrushTemplate(JSON.clone(template.toStruct()))
        parsedTemplate.type = VEBrushType.EFFECT_PARTICLE
        parsedTemplate.properties = migrateGridOldParticleEvent(parsedTemplate)
        this.saveTemplate(parsedTemplate)
        break
      case VEBrushType.GRID_OLD_PLAYER:
        var parsedTemplate = new VEBrushTemplate(JSON.clone(template.toStruct()))
        parsedTemplate.type = VEBrushType.ENTITY_PLAYER
        parsedTemplate.properties = migrateGridOldPlayerEvent(parsedTemplate)
        this.saveTemplate(parsedTemplate)

        parsedTemplate = new VEBrushTemplate(JSON.clone(template.toStruct()))
        parsedTemplate.type = VEBrushType.ENTITY_CONFIG
        ///@todo
        parsedTemplate.properties = migrateGridOldPlayerToEntityConfigEvent(parsedTemplate)
        this.saveTemplate(parsedTemplate)
        break
      case VEBrushType.GRID_OLD_SEPARATOR:
        var parsedTemplate = new VEBrushTemplate(JSON.clone(template.toStruct()))
        parsedTemplate.type = VEBrushType.GRID_ROW
        parsedTemplate.properties = migrateGridOldSeparatorEvent(parsedTemplate)
        this.saveTemplate(parsedTemplate)
        break
      case VEBrushType.VIEW_OLD_WALLPAPER:
        var parsedTemplate = new VEBrushTemplate(JSON.clone(template.toStruct()))
        parsedTemplate.type = VEBrushType.VIEW_WALLPAPER
        ///@todo
        parsedTemplate.properties = migrateViewOldWallpaperEvent(parsedTemplate)
        this.saveTemplate(parsedTemplate)
        break
      case VEBrushType.VIEW_OLD_CAMERA:
        var parsedTemplate = new VEBrushTemplate(JSON.clone(template.toStruct()))
        parsedTemplate.type = VEBrushType.VIEW_CAMERA
        ///@todo
        parsedTemplate.properties = migrateViewOldCameraEvent(parsedTemplate)
        this.saveTemplate(parsedTemplate)
        break
      case VEBrushType.VIEW_OLD_LYRICS:
        var parsedTemplate = new VEBrushTemplate(JSON.clone(template.toStruct()))
        parsedTemplate.type = VEBrushType.VIEW_SUBTITLE
        parsedTemplate.properties = migrateViewOldLyricsEvent(parsedTemplate)
        this.saveTemplate(parsedTemplate)
        break
      case VEBrushType.VIEW_OLD_GLITCH:
        var parsedTemplate = new VEBrushTemplate(JSON.clone(template.toStruct()))
        parsedTemplate.type = VEBrushType.EFFECT_GLITCH
        parsedTemplate.properties = migrateViewOldGlitchEvent(parsedTemplate)
        this.saveTemplate(parsedTemplate)
        break
      case VEBrushType.VIEW_OLD_CONFIG:
        var parsedTemplate = new VEBrushTemplate(JSON.clone(template.toStruct()))
        parsedTemplate.type = VEBrushType.VIEW_CONFIG
        ///@todo
        parsedTemplate.properties = migrateViewOldConfigEvent(parsedTemplate)
        this.saveTemplate(parsedTemplate)

        parsedTemplate = new VEBrushTemplate(JSON.clone(template.toStruct()))
        parsedTemplate.type = VEBrushType.ENTITY_CONFIG
        ///@todo
        parsedTemplate.properties = migrateViewOldConfigToEntityConfigEvent(parsedTemplate)
        this.saveTemplate(parsedTemplate)
        break
    }

    return this
  }

  ///@param {VEBrushTemplate}
  ///@return {VEBrushService}
  removeTemplate = function(template) {
    if (!Core.isType(template, VEBrushTemplate)) {
      Logger.warn("VEBrushService::removeTemplate", $"Template must be type of VEBrushTemplate")
      return this
    }

    var templates = this.templates.get(template.type)
    if (!Core.isType(templates, Array)) {
      Logger.warn("VEBrushService::removeTemplate", $"Unable to find template for type '{template.type}'")
      return this
    }

    var index = templates.findIndex(function(template, index, name) {
      return template.name == name
    }, template.name)

    if (Optional.is(index)) {
      Logger.info("VEBrushService::removeTemplate", $"Template of type '{template.type}' removed: '{template.name}'")
      templates.remove(index)
    } else {
      Logger.warn("VEBrushService::removeTemplate", $"Template of type '{template.type}' wasn't found: '{template.name}'")
    }

    return this
  }

  ///@param {VEBrushTemplate}
  ///@return {VEBrush}
  templateToBrush = function(template) {
    return new VEBrush(template)
  }

  ///@param {VEBrush}
  ///@return {VEBrushTemplate}
  brushToTemplate = function(brush) {
    var json = {
      name: Assert.isType(brush.store.getValue("brush-name"), String),
      type: Assert.isEnum(brush.type, VEBrushType),
      color: Assert.isType(brush.store.getValue("brush-color"), Color).toHex(),
      texture: Assert.isType(brush.store.getValue("brush-texture"), String),
    }

    var properties = brush.store.container
      .filter(function(item) {
        return item.name != "brush-name" 
          && item.name != "brush-color" 
          && item.name != "brush-texture" 
      })
      .toStruct(function(item) { 
        return item.stringify()
      })
    
    if (Struct.size(properties) > 0) {
      Struct.set(json, "properties", properties)
    }

    return new VEBrushTemplate(json)
  }

  ///@return {VEBrushTemplate}
  clearTemplates = function() {
    this.templates.forEach(function(array) {
      array.clear()
    })
    return this
  }
}