///@package io.alkapivo.visu.editor.service.brush

///@enum
function _VEBrushType(): Enum() constructor {
  #region Old API
  SHADER_SPAWN = "brush_shader_spawn"
  SHADER_OVERLAY = "brush_shader_overlay"
  SHADER_CLEAR = "brush_shader_clear"
  SHADER_CONFIG = "brush_shader_config"
  SHROOM_SPAWN = "brush_shroom_spawn"
  SHROOM_CLEAR = "brush_shroom_clear"
  SHROOM_CONFIG = "brush_shroom_config"
  VIEW_OLD_WALLPAPER = "brush_view_old_wallpaper"
  VIEW_OLD_CAMERA = "brush_view_old_camera"
  VIEW_OLD_LYRICS = "brush_view_old_lyrics"
  VIEW_OLD_GLITCH = "brush_view_old_glitch"
  VIEW_OLD_CONFIG = "brush_view_old_config"
  GRID_OLD_CHANNEL = "brush_grid_old_channel"
  GRID_OLD_COIN = "brush_grid_old_coin"
  GRID_OLD_CONFIG = "brush_grid_old_config"
  GRID_OLD_PARTICLE = "brush_grid_old_particle"
  GRID_OLD_PLAYER = "brush_grid_old_player"
  GRID_OLD_SEPARATOR = "brush_grid_old_separator"
  #endregion

  EFFECT_SHADER = "brush_effect_shader"
  EFFECT_GLITCH = "brush_effect_glitch"
  EFFECT_PARTICLE = "brush_effect_particle"
  EFFECT_CONFIG = "brush_effect_config"
  ENTITY_SHROOM = "brush_entity_shroom"
  ENTITY_COIN = "brush_entity_coin"
  ENTITY_PLAYER = "brush_entity_player"
  ENTITY_CONFIG = "brush_entity_config"
  GRID_AREA = "brush_grid_area"
  GRID_COLUMN = "brush_grid_column"
  GRID_ROW = "brush_grid_row"
  GRID_CONFIG = "brush_grid_config"
  VIEW_CAMERA = "brush_view_camera"
  VIEW_WALLPAPER = "brush_view_wallpaper"
  VIEW_SUBTITLE = "brush_view_subtitle"
  VIEW_CONFIG = "brush_view_config"
}
global.__VEBrushType = new _VEBrushType()
#macro VEBrushType global.__VEBrushType


///@static
///@type {Struct}
global.__VEBrushTypeNames = {
  #region Old API
  "brush_shader_spawn": "Shader spawn",
  "brush_shader_overlay": "Shader overlay",
  "brush_shader_clear": "Shader clear",
  "brush_shader_config": "Shader config",
  "brush_shroom_spawn": "Shroom spawn",
  "brush_shroom_clear": "Shroom clear",
  "brush_shroom_config": "Shroom config",
  "brush_view_old_wallpaper": "View wallpaper",
  "brush_view_old_camera": "View camera",
  "brush_view_old_lyrics": "View subtitle",
  "brush_view_old_glitch": "View glitch",
  "brush_view_old_config": "View config",
  "brush_grid_old_channel": "Grid columns",
  "brush_grid_old_coin": "Spawn coin",
  "brush_grid_old_config": "Grid config",
  "brush_grid_old_particle": "Spawn particle",
  "brush_grid_old_player": "Spawn player",
  "brush_grid_old_separator": "Grid rows",
  #endregion

  "brush_effect_shader": "Effect shader",
  "brush_effect_glitch": "Effect glitch",
  "brush_effect_particle": "Effect particle",
  "brush_effect_config": "Effect config",
  "brush_entity_shroom": "Entity shroom",
  "brush_entity_coin": "Entity coin",
  "brush_entity_player": "Entity player",
  "brush_entity_config": "Enttiy config",
  "brush_grid_area": "Grid area",
  "brush_grid_column": "Grid column",
  "brush_grid_row": "Grid row",
  "brush_grid_config": "Grid config",
  "brush_view_camera": "View camera",
  "brush_view_wallpaper": "View wallpaper",
  "brush_view_subtitle": "View subtitle",
  "brush_view_config": "View config"
}
#macro VEBrushTypeNames global.__VEBrushTypeNames


///@static
///@type {Array<String>}
global.__BRUSH_TEXTURES = [
  "texture_white",
  "texture_baron",
  "texture_bazyl",
  "texture_coin_life",
  "texture_coin_bomb",
  "texture_coin_force",
  "texture_coin_point",
  "texture_missing",
  "texture_bullet",
  "texture_bullet_circle",
  "texture_visu_editor_icon_event_shader",
  "texture_visu_editor_icon_event_shader_spawn",
  "texture_visu_editor_icon_event_shader_overlay",
  "texture_visu_editor_icon_event_shader_clear",
  "texture_visu_editor_icon_event_shader_config",
  "texture_visu_editor_icon_event_shroom",
  "texture_visu_editor_icon_event_shroom_spawn",
  "texture_visu_editor_icon_event_shroom_clear",
  "texture_visu_editor_icon_event_shroom_config",
  "texture_visu_editor_icon_event_grid",
  "texture_visu_editor_icon_event_grid_channel",
  "texture_visu_editor_icon_event_grid_separator",
  "texture_visu_editor_icon_event_grid_particle",
  "texture_visu_editor_icon_event_grid_player",
  "texture_visu_editor_icon_event_grid_config",
  "texture_visu_editor_icon_event_view",
  "texture_visu_editor_icon_event_view_background",
  "texture_visu_editor_icon_event_view_foreground",
  "texture_visu_editor_icon_event_view_camera",
  "texture_visu_editor_icon_event_view_config",
  "texture_button_next",
  "texture_button_previous",
  "visu_texture_checkbox_on",
  "visu_texture_checkbox_off",
  "visu_texture_checkbox_muted_on",
  "visu_texture_checkbox_muted_off",
  "texture_ve_trackcontrol_button_pause",
  "texture_ve_trackcontrol_button_play",
  "texture_ve_trackcontrol_button_rewind_left",
  "texture_ve_trackcontrol_button_rewind_right"
]
#macro BRUSH_TEXTURES global.__BRUSH_TEXTURES


///@param {VEBrushTemplate} template
function VEBrush(template) constructor {
  
  ///@type {VEBrushType}
  type = Assert.isEnum(template.type, VEBrushType)
   
  ///@type {Store}
  store = new Store({
    "brush-name": {
      type: String,
      value: template.name,
    },
    "brush-color": {
      type: Color,
      value: ColorUtil.fromHex(Struct.get(template, "color"), ColorUtil.fromHex("#FFFFFF")),
      passthrough: function(value) {
        return Core.isType(value, Color) ? value : this.value
      },
    },
    "brush-texture": {
      type: String,
      value: Struct.getIfType(template, "texture", String, "texture_missing"),
      passthrough: function(value) {
        return Core.isType(TextureUtil.parse(value), Texture)
            && GMArray.contains(BRUSH_TEXTURES, value)
              ? value
              : this.value
      },
      data: new Array(String, BRUSH_TEXTURES),
    }
  })

  ///@type {Array<Struct>}
  components = new Array(Struct, [
    {
      name: "event-type",
      template: VEComponents.get("property"),
      layout: VELayouts.get("property"),
      config: { 
        layout: { type: UILayoutType.VERTICAL },
        label: { text: $"{Struct.get(VEBrushTypeNames, template.type)}" },
      },
    },
    {
      name: "brush_name",
      template: VEComponents.get("text-field"),
      layout: VELayouts.get("text-field"),
      config: { 
        layout: { type: UILayoutType.VERTICAL },
        label: { text: "Name" },
        field: { store: { key: "brush-name" } },
      },
    },
    {
      name: "brush_texture",
      template: VEComponents.get("spin-select"),
      layout: VELayouts.get("spin-select"),
      config: {
        layout: { type: UILayoutType.VERTICAL },
        label: { text: "Texture" },
        previous: { store: { key: "brush-texture" } },
        preview: Struct.appendRecursive({ 
          store: { key: "brush-texture" },
          imageBlendStoreKey: "brush-color",
          updateCustom: function() {
            var key = Struct.get(this, "imageBlendStoreKey")
            if (!Optional.is(this.store)
              || !Core.isType(key, String) 
              || !Core.isType(this.image, Sprite)) {
              return
            }

            var store = this.store.getStore()
            if (!Optional.is(store)) {
              return
            }

            var item = store.get("brush-color")
            if (!Optional.is(item)) {
              return
            }
            this.image.blend = item.get().toGMColor()
          },
        }, Struct.get(VEStyles.get("spin-select-image"), "preview"), false),
        next: { store: { key: "brush-texture" } },
      }
    },
    {
      name: "brush_color",
      template: VEComponents.get("color-picker"),
      layout: VELayouts.get("color-picker"),
      config: {
        layout: { type: UILayoutType.VERTICAL },
        //title: { 
        //  label: { text: "Icon" },
        //  input: { store: { key: "brush-color" } }
        //},
        red: {
          label: { text: "Red" },
          field: { store: { key: "brush-color" } },
          slider: { store: { key: "brush-color" } },
        },
        green: {
          label: { text: "Green" },
          field: { store: { key: "brush-color" } },
          slider: { store: { key: "brush-color" } },
        },
        blue: {
          label: { text: "Blue" },
          field: { store: { key: "brush-color" } },
          slider: { store: { key: "brush-color" } },
        },
        hex: { 
          label: { text: "Hex" },
          field: { store: { key: "brush-color" } },
        },
      },
    },
    {
      name: "brush_start-properties-line-h",
      template: VEComponents.get("line-h"),
      layout: VELayouts.get("line-h"),
      config: { layout: { type: UILayoutType.VERTICAL } },
    }
  ])

  var eventHandler = Assert.isType(Beans.get(BeanVisuController).trackService.handlers.get(this.type), Struct)
  
  ///@type {Callable}
  serializeData = Assert.isType(Struct.get(eventHandler, "serialize"), Callable)

  ///@return {VEBrushTemplate}
  toTemplate = function() {
    var json = {
      name: Assert.isType(this.store.getValue("brush-name"), String),
      type: Assert.isEnum(this.type, VEBrushType),
      color: Assert.isType(this.store.getValue("brush-color"), Color).toHex(),
      texture: Assert.isType(this.store.getValue("brush-texture"), String),
    }

    var properties = this.serializeData(this.store.container
      .filter(function(item) {
        return item.name != "brush-name" 
            && item.name != "brush-color" 
            && item.name != "brush-texture" 
      })
      .toStruct(function(item) { 
        return item.serialize()
      })
    )
    
    if (Struct.size(properties) > 0) {
      Struct.set(json, "properties", properties)
    }

    return new VEBrushTemplate(json)
  }

  ///@description append data
  var uiHandler = Assert.isType(Callable.get(this.type), Callable)
  var eventParser = Assert.isType(Struct.get(eventHandler, "parse"), Callable)
  var data = Assert.isType(eventParser(Struct.getIfType(template, "properties", Struct, { })), Struct)
  var properties = Assert.isType(uiHandler(data), Struct)

  ///@description append StoreItems to default template
  properties.store.forEach(function(json, name, store) {
    store.add(new StoreItem(name, json))
  }, this.store)

  ///@description append components to default template
  properties.components.forEach(function(component, index, components) {
    components.add(component)
  }, this.components)

  ///@description append ending line
  this.components.add({
    name: "brush_finish-properties-line-h",
    template: VEComponents.get("line-h"),
    layout: VELayouts.get("line-h"),
    config: { layout: { type: UILayoutType.VERTICAL } },
  })
}
