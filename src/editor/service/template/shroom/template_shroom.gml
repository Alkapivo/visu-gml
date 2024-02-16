///@package io.alkapivo.visu.editor.api.template

///@param {Struct} json
///@return {Struct}
function template_shroom(json = null) {
  var template = {
    name: Assert.isType(json.name, String),
    store: new Map(String, Struct, {
      "shroom_texture": {
        type: Sprite,
        value: SpriteUtil.parse(json.sprite),
      },
      "use_shroom_mask": {
        type: Boolean,
        value: Struct.getDefault(json, "mask", false) == true,
      },
      "shroom_mask": {
        type: Rectangle,
        value: new Rectangle(Struct.getDefault(json, "mask", null)),
      },
      "feature": {
        type: String,
        value: Assert.isType(Core.getPrototypeName(AngleFeature), String),
        validate: function(value) {
          Assert.isTrue(this.data.contains(value))
        },
        data: new Array(String, [
          Assert.isType(Core.getPrototypeName(AngleFeature), String),
          Assert.isType(Core.getPrototypeName(BooleanFeature), String),
          Assert.isType(Core.getPrototypeName(CounterFeature), String),
          Assert.isType(Core.getPrototypeName(FollowPlayerFeature), String),
          Assert.isType(Core.getPrototypeName(KillFeature), String),
          Assert.isType(Core.getPrototypeName(LifespawnFeature), String),
          Assert.isType(Core.getPrototypeName(ParticleFeature), String),
          Assert.isType(Core.getPrototypeName(ShootFeature), String),
          Assert.isType(Core.getPrototypeName(SpeedFeature), String),
          Assert.isType(Core.getPrototypeName(SpriteFeature), String),
          Assert.isType(Core.getPrototypeName(SwingFeature), String)
        ]),
      },
      "condition": {
        type: String,
        value: VISU_GRID_CONDITIONS.getFirst(),
        validate: function(value) {
          Assert.isTrue(this.data.contains(value))
        },
        data: VISU_GRID_CONDITIONS.keys(),
      },
    }),
    components: new Array(Struct, [
      {
        name: "shroom_texture",
        template: VEComponents.get("texture-field-speed"),
        layout: VELayouts.get("texture-field-speed"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          title: {
            label: { text: "Set texture" },
          },
          texture: {
            label: { text: "Texture" }, 
            field: { store: { key: "shroom_texture" } },
          },
          frame: {
            label: { text: "Frame" },
            field: { store: { key: "shroom_texture" } },
          },
          speed: {
            label: { text: "Speed" },
            field: { store: { key: "shroom_texture" } },
          },
          alpha: {
            label: { text: "Alpha" },
            field: { store: { key: "shroom_texture" } },
            slider: { 
              minValue: 0.0,
              maxValue: 1.0,
              store: { key: "shroom_texture" },
            },
          },
          preview: {
            image: { name: "texture_empty" },
            store: { key: "shroom_texture" },
          },
        },
      },
      {
        name: "shroom_mask",
        template: VEComponents.get("vec4-field"),
        layout: VELayouts.get("vec4-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          title: {
            label: {
              text: "Mask",
              enable: { key: "use_shroom_mask" },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "use_shroom_mask" },
            },
          },
          x: {
            label: {
              text: "X",
              enable: { key: "use_shroom_mask" },
            },
            field: {
              store: { key: "shroom_mask" },
              enable: { key: "use_shroom_mask" },
            },
          },
          y: {
            label: {
              text: "Y",
              enable: { key: "use_shroom_mask" },
            },
            field: {
              store: { key: "shroom_mask" },
              enable: { key: "use_shroom_mask" },
            },
          },
          z: {
            label: {
              text: "Width",
              enable: { key: "use_shroom_mask" },
            },
            field: {
              store: { key: "shroom_mask" },
              enable: { key: "use_shroom_mask" },
            },
          },
          a: {
            label: {
              text: "Height",
              enable: { key: "use_shroom_mask" },
            },
            field: {
              store: { key: "shroom_mask" },
              enable: { key: "use_shroom_mask" },
            },
          },
        },
      },
      {
        name: "shroom_gamemode_bullethell",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "BulletHell" },
        },
      },
      {
        name: "bullethell_add-feature_spin-select",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Feature" },
          previous: { store: { key: "feature" } },
          preview: Struct.appendRecursive({ 
            store: { key: "feature" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: { store: { key: "feature" } },
        },
      },
      {
        name: "bullethell_add-feature_button",
        template: VEComponents.get("button-wrapper"),
        layout: VELayouts.get("button-wrapper"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          backgroundColor: VETheme.color.accept,
          backgroundMargin: { top: 5, bottom: 5, left: 5, right: 5 },
          callback: function() { 
            Core.print("MOCK add feature to shroom template")
          },
          label: { text: "Add feature" },
        },
      },
      {
        name: "shroom_gamemode_platformer",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Platformer" },
        },
      },
      {
        name: "platformer_add-feature_spin-select",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Feature" },
          previous: { store: { key: "feature" } },
          preview: Struct.appendRecursive({ 
            store: { key: "feature" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: { store: { key: "feature" } },
        },
      },
      {
        name: "platformer_add-feature_button",
        template: VEComponents.get("button"),
        layout: VELayouts.get("button"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          backgroundColor: VETheme.color.accept,
          backgroundMargin: { top: 5, bottom: 5, left: 5, right: 5 },
          callback: function() { 
            Core.print("MOCK add feature to shroom template")
          },
          label: { text: "Add feature" },
        },
      },
      {
        name: "shroom_gamemode_idle",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Idle" },
        },
      },
      {
        name: "idle_add-feature_spin-select",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Feature" },
          previous: { store: { key: "feature" } },
          preview: Struct.appendRecursive({ 
            store: { key: "feature" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: { store: { key: "feature" } },
        },
      },
      {
        name: "idle_add-feature_button",
        template: VEComponents.get("button"),
        layout: VELayouts.get("button"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          backgroundColor: VETheme.color.accept,
          backgroundMargin: { top: 5, bottom: 5, left: 5, right: 5 },
          callback: function() { 
            Core.print("MOCK add feature to shroom template")
          },
          label: { text: "Add feature" },
        },
      },
    ]),
  }

  return template
}