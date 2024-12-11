///@package io.alkapivo.visu.editor.service.brush.view

///@param {?Struct} [json]
///@return {Struct}
function brush_view_camera(json = null) {
  return {
    name: "brush_view_camera",
    store: new Map(String, Struct, {
      "vw-cam_use-lock-x": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-cam_use-lock-x", Boolean, false),
      },
      "vw-cam_lock-x": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-cam_lock-x", Boolean, false),
      },
      "vw-cam_use-lock-y": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-cam_use-lock-y", Boolean, false),
      },
      "vw-cam_lock-y": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-cam_lock-y", Boolean, false),
      },
      "vw-cam_follow": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-cam_follow", Boolean, false),
      },
      "vw-cam_use-follow-x": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-cam_use-follow-x", Boolean, false),
      },
      "vw-cam_follow-x": {
        type: Number,
        value: Struct.getIfType(json, "vw-cam_follow-x", Number, 0.35),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 0.5)
        },
      },
      "vw-cam_use-follow-y": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-cam_use-follow-y", Boolean, false),
      },
      "vw-cam_follow-y": {
        type: Number,
        value: Struct.getIfType(json, "vw-cam_follow-y", Number, 0.40),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 0.5)
        },
      },
      "vw-cam_follow-smooth": {
        type: Number,
        value: Struct.getIfType(json, "vw-cam_follow-smooth", Number, 32),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 1.0, 256.0)
        },
      },
      "vw-cam_use-follow-smooth": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-cam_use-follow-smooth", Boolean, false),
      },
      "vw-cam_use-x": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-cam_use-x", Boolean, false),
      },
      "vw-cam_x": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getDefault(json, "vw-cam_x", { 
          value: 0.0, 
          target: 4096.0, 
          factor: 1.0, 
          increase: 0.0,
        })),
        passthrough: function(value) {
          if (!Core.isType(value, NumberTransformer)) {
            return this.value
          }

          value.value = clamp(value.value, 0.0, 99999.9)
          value.target = clamp(value.target, 0.0, 99999.9)
          return value
        },
      },
      "vw-cam_change-x": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-cam_change-x", Boolean, false),
      },
      "vw-cam_use-y": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-cam_use-y", Boolean, false),
      },
      "vw-cam_y": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getDefault(json, "vw-cam_y", {
          value: 0.0, 
          target: 5356.0, 
          factor: 1.0, 
          increase: 0.0,
        })),
        passthrough: function(value) {
          if (!Core.isType(value, NumberTransformer)) {
            return this.value
          }

          value.value = clamp(value.value, 0.0, 99999.9)
          value.target = clamp(value.target, 0.0, 99999.9)
          return value
        },
      },
      "vw-cam_change-y": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-cam_change-y", Boolean, false),
      },
      "vw-cam_use-z": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-cam_use-z", Boolean, false),
      },
      "vw-cam_z": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getDefault(json, "vw-cam_z", {
          value: 0.0, 
          target: 5000.0, 
          factor: 1.0, 
          increase: 0.0,
        })),
        passthrough: function(value) {
          if (!Core.isType(value, NumberTransformer)) {
            return this.value
          }

          value.value = clamp(value.value, 0.0, 99999.9)
          value.target = clamp(value.target, 0.0, 99999.9)
          return value
        },
      },
      "vw-cam_change-z": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-cam_change-z", Boolean, false),
      },
      "vw-cam_use-dir": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-cam_use-dir", Boolean, false),
      },
      "vw-cam_dir": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getDefault(json, "vw-cam_dir", {
          value: 0.0, 
          target: 270.0, 
          factor: 0.1, 
          increase: 0.0,
        })),
        passthrough: function(value) {
          if (!Core.isType(value, NumberTransformer)) {
            return this.value
          }

          value.value = clamp(value.value, -9999.9, 9999.9)
          value.target = clamp(value.target, -9999.9, 9999.9)
          return value
        },
      },
      "vw-cam_change-dir": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-cam_change-dir", Boolean, false),
      },
      "vw-cam_use-pitch": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-cam_use-pitch", Boolean, false),
      },
      "vw-cam_pitch": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getDefault(json, "vw-cam_pitch", {
          value: 0.0, 
          target: -70.0, 
          factor: 0.1, 
          increase: 0.0,
        })),
        passthrough: function(value) {
          if (!Core.isType(value, NumberTransformer)) {
            return this.value
          }

          value.value = clamp(value.value, -9999.9, 9999.9)
          value.target = clamp(value.target, -9999.9, 9999.9)
          return value
        },
      },
      "vw-cam_change-pitch": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-cam_change-pitch", Boolean, false),
      },
      "vw-cam_use-move-speed": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-cam_use-move-speed", Boolean, false),
      },
      "vw-cam_move-speed": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getDefault(json, "vw-cam_move-speed", {
          value: 0.0, 
          target: 1.0, 
          factor: 0.01, 
          increase: 0.0,
        })),
        passthrough: function(value) {
          if (!Core.isType(value, NumberTransformer)) {
            return this.value
          }

          value.value = clamp(value.value, 0.0, 999.9)
          value.target = clamp(value.target, 0.0, 999.9)
          return value
        },
      },
      "vw-cam_change-move-speed": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-cam_change-move-speed", Boolean, false),
      },
      "vw-cam_use-move-angle": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-cam_use-move-angle", Boolean, false),
      },
      "vw-cam_move-angle": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getDefault(json, "vw-cam_move-angle", {
          value: 0.0, 
          target: 90.0, 
          factor: 0.1, 
          increase: 0.0,
        })),
        passthrough: function(value) {
          if (!Core.isType(value, NumberTransformer)) {
            return this.value
          }

          value.value = clamp(value.value, -9999.9, 9999.9)
          value.target = clamp(value.target, -9999.9, 9999.9)
          return value
        },
      },
      "vw-cam_change-move-angle": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-cam_change-move-angle", Boolean, false),
      },
    }),
    components: new Array(Struct, [
      {
        name: "vw-cam_view-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Camera view",
            backgroundColor: VETheme.color.accentShadow,
          },
          input: { backgroundColor: VETheme.color.accentShadow },
          checkbox: { backgroundColor: VETheme.color.accentShadow },
        },
      },
      {
        name: "vw-cam_use-lock-x",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Lock X",
            enable: { key: "vw-cam_use-lock-x" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-cam_use-lock-x" },
          },
          input: { 
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "vw-cam_lock-x" },
            enable: { key: "vw-cam_use-lock-x" },
          },
        },
      },
      {
        name: "vw-cam_use-lock-y",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Lock Y",
            enable: { key: "vw-cam_use-lock-y" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-cam_use-lock-y" },
          },
          input: { 
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "vw-cam_lock-y" },
            enable: { key: "vw-cam_use-lock-y" },
          },
        },
      },
      {
        name: "vw-cam_follow-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Follow",
            enable: { key: "vw-cam_follow" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-cam_follow" },
          },
        },
      },
      {
        name: "vw-cam_follow-x",
        template: VEComponents.get("text-field-increase-checkbox"),
        layout: VELayouts.get("text-field-increase-checkbox"),
        config: {
          layout: { type: UILayoutType.VERTICAL},
          label: { 
            text: "X margin",
            enable: { key: "vw-cam_use-follow-x" },
          },
          field: { 
            store: { key: "vw-cam_follow-x" },
            enable: { key: "vw-cam_use-follow-x" },
          },
          decrease: {
            store: { key: "vw-cam_follow-x" },
            enable: { key: "vw-cam_use-follow-x" },
            factor: -0.001,
          },
          increase: {
            store: { key: "vw-cam_follow-x" },
            enable: { key: "vw-cam_use-follow-x" },
            factor: 0.001,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-cam_use-follow-x" },
          },
          title: { 
            text: "Enable",
            enable: { key: "vw-cam_use-follow-x" },
          },
        }
      },
      {
        name: "vw-cam_follow-y",
        template: VEComponents.get("text-field-increase-checkbox"),
        layout: VELayouts.get("text-field-increase-checkbox"),
        config: {
          layout: { type: UILayoutType.VERTICAL},
          label: { 
            text: "Y margin",
            enable: { key: "vw-cam_use-follow-y" },
          },
          field: { 
            store: { key: "vw-cam_follow-y" },
            enable: { key: "vw-cam_use-follow-y" },
          },
          decrease: {
            store: { key: "vw-cam_follow-y" },
            enable: { key: "vw-cam_use-follow-y" },
            factor: -0.001,
          },
          increase: {
            store: { key: "vw-cam_follow-y" },
            enable: { key: "vw-cam_use-follow-y" },
            factor: 0.001,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-cam_use-follow-y" },
          },
          title: { 
            text: "Enable",
            enable: { key: "vw-cam_use-follow-y" },
          },
        }
      },
      {
        name: "vw-cam_follow-smooth",
        template: VEComponents.get("text-field-increase-checkbox"),
        layout: VELayouts.get("text-field-increase-checkbox"),
        config: {
          layout: { type: UILayoutType.VERTICAL},
          label: { 
            text: "Smooth",
            enable: { key: "vw-cam_use-follow-smooth" },
          },
          field: { 
            store: { key: "vw-cam_follow-smooth" },
            enable: { key: "vw-cam_use-follow-smooth" },
          },
          decrease: {
            store: { key: "vw-cam_follow-x" },
            enable: { key: "vw-cam_use-follow-smooth" },
            factor: -0.25,
          },
          increase: {
            store: { key: "vw-cam_follow-smooth" },
            enable: { key: "vw-cam_use-follow-smooth" },
            factor: 0.25,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-cam_use-follow-smooth" },
          },
          title: { 
            text: "Enable",
            enable: { key: "vw-cam_use-follow-smooth" },
          },
        }
      },
      {
        name: "vw-cam_pos-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "vw-cam_pos-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Camera position",
            backgroundColor: VETheme.color.accentShadow,
          },
          input: { backgroundColor: VETheme.color.accentShadow },
          checkbox: { backgroundColor: VETheme.color.accentShadow },
        },
      },
      {
        name: "vw-cam_x",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Camera X",
              font: "font_inter_10_bold",
              color: VETheme.color.textFocus,
              enable: { key: "vw-cam_use-x" },
            },
            field: {
              store: { key: "vw-cam_x" },
              enable: { key: "vw-cam_use-x" },
            },
            decrease: { 
              store: { key: "vw-cam_x" },
              enable: { key: "vw-cam_use-x" },
              factor: -10.0,
            },
            increase: { 
              store: { key: "vw-cam_x" },
              enable: { key: "vw-cam_use-x" },
              factor: 10.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-cam_use-x" },
            },
            title: { 
              text: "Override",
              enable: { key: "vw-cam_use-x" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "vw-cam_change-x" },
            },
            field: {
              store: { key: "vw-cam_x" },
              enable: { key: "vw-cam_change-x" },
            },
            decrease: { 
              store: { key: "vw-cam_x" },
              enable: { key: "vw-cam_change-x" },
              factor: -10.0,
            },
            increase: { 
              store: { key: "vw-cam_x" },
              enable: { key: "vw-cam_change-x" },
              factor: 10.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-cam_change-x" },
            },
            title: { 
              text: "Change",
              enable: { key: "vw-cam_change-x" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "vw-cam_change-x" },
            },
            field: {
              store: { key: "vw-cam_x" },
              enable: { key: "vw-cam_change-x" },
            },
            decrease: { 
              store: { key: "vw-cam_x" },
              enable: { key: "vw-cam_change-x" },
              factor: -1.0,
            },
            increase: { 
              store: { key: "vw-cam_x" },
              enable: { key: "vw-cam_change-x" },
              factor: 1.0,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "vw-cam_change-x" },
            },
            field: {
              store: { key: "vw-cam_x" },
              enable: { key: "vw-cam_change-x" },
            },
            decrease: { 
              store: { key: "vw-cam_x" },
              enable: { key: "vw-cam_change-x" },
              factor: -0.001,
            },
            increase: { 
              store: { key: "vw-cam_x" },
              enable: { key: "vw-cam_change-x" },
              factor: 0.001,
            },
          },
        },
      },
      {
        name: "vw-cam_x-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "vw-cam_y",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Camera Y",
              font: "font_inter_10_bold",
              color: VETheme.color.textFocus,
              enable: { key: "vw-cam_use-y" },
            },
            field: {
              store: { key: "vw-cam_y" },
              enable: { key: "vw-cam_use-y" },
            },
            decrease: { 
              store: { key: "vw-cam_y" },
              enable: { key: "vw-cam_use-y"},
              factor: -10.0,
            },
            increase: { 
              store: { key: "vw-cam_y" },
              enable: { key: "vw-cam_use-y" },
              factor: 10.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-cam_use-y" },
            },
            title: { 
              text: "Override",
              enable: { key: "vw-cam_use-y" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "vw-cam_change-y" },
            },
            field: {
              store: { key: "vw-cam_y" },
              enable: { key: "vw-cam_change-y" },
            },
            decrease: { 
              store: { key: "vw-cam_y" },
              enable: { key: "vw-cam_change-y" },
              factor: -10.0,
            },
            increase: { 
              store: { key: "vw-cam_y" },
              enable: { key: "vw-cam_change-y" },
              factor: 10.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-cam_change-y" },
            },
            title: { 
              text: "Change",
              enable: { key: "vw-cam_change-y" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "vw-cam_change-y" },
            },
            field: {
              store: { key: "vw-cam_y" },
              enable: { key: "vw-cam_change-y" },
            },
            decrease: { 
              store: { key: "vw-cam_y" },
              enable: { key: "vw-cam_change-y" },
              factor: -1.0,
            },
            increase: { 
              store: { key: "vw-cam_y" },
              enable: { key: "vw-cam_change-y" },
              factor: 1.0,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "vw-cam_change-y" },
            },
            field: {
              store: { key: "vw-cam_y" },
              enable: { key: "vw-cam_change-y" },
            },
            decrease: { 
              store: { key: "vw-cam_y" },
              enable: { key: "vw-cam_change-y" },
              factor: -0.001,
            },
            increase: { 
              store: { key: "vw-cam_y" },
              enable: { key: "vw-cam_change-y" },
              factor: 0.001,
            },
          },
        },
      },
      {
        name: "vw-cam_y-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "vw-cam_z",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Camera Z",
              font: "font_inter_10_bold",
              color: VETheme.color.textFocus,
              enable: { key: "vw-cam_use-z" },
            },
            field: {
              store: { key: "vw-cam_z" },
              enable: { key: "vw-cam_use-z" },
            },
            decrease: { 
              store: { key: "vw-cam_z" },
              enable: { key: "vw-cam_use-z"},
              factor: -10.0,
            },
            increase: { 
              store: { key: "vw-cam_z" },
              enable: { key: "vw-cam_use-z" },
              factor: 10.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-cam_use-z" },
            },
            title: { 
              text: "Override",
              enable: { key: "vw-cam_use-z" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "vw-cam_change-z" },
            },
            field: {
              store: { key: "vw-cam_z" },
              enable: { key: "vw-cam_change-z" },
            },
            decrease: { 
              store: { key: "vw-cam_z" },
              enable: { key: "vw-cam_change-z" },
              factor: -10.0,
            },
            increase: { 
              store: { key: "vw-cam_z" },
              enable: { key: "vw-cam_change-z" },
              factor: 10.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-cam_change-z" },
            },
            title: { 
              text: "Change",
              enable: { key: "vw-cam_change-z" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "vw-cam_change-z" },
            },
            field: {
              store: { key: "vw-cam_z" },
              enable: { key: "vw-cam_change-z" },
            },
            decrease: { 
              store: { key: "vw-cam_z" },
              enable: { key: "vw-cam_change-z" },
              factor: -1.0,
            },
            increase: { 
              store: { key: "vw-cam_z" },
              enable: { key: "vw-cam_change-z" },
              factor: 1.0,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "vw-cam_change-z" },
            },
            field: {
              store: { key: "vw-cam_z" },
              enable: { key: "vw-cam_change-z" },
            },
            decrease: { 
              store: { key: "vw-cam_z" },
              enable: { key: "vw-cam_change-z" },
              factor: -0.001,
            },
            increase: { 
              store: { key: "vw-cam_z" },
              enable: { key: "vw-cam_change-z" },
              factor: 0.001,
            },
          },
        },
      },
      {
        name: "vw-cam_z-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "vw-cam_dir",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Angle",
              font: "font_inter_10_bold",
              color: VETheme.color.textFocus,
              enable: { key: "vw-cam_use-dir" },
            },
            field: {
              store: { key: "vw-cam_dir" },
              enable: { key: "vw-cam_use-dir" },
            },
            decrease: { 
              store: { key: "vw-cam_dir" },
              enable: { key: "vw-cam_use-dir"},
              factor: -0.25,
            },
            increase: { 
              store: { key: "vw-cam_dir" },
              enable: { key: "vw-cam_use-dir" },
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-cam_use-dir" },
            },
            title: { 
              text: "Override",
              enable: { key: "vw-cam_use-dir" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "vw-cam_change-dir" },
            },
            field: {
              store: { key: "vw-cam_dir" },
              enable: { key: "vw-cam_change-dir" },
            },
            decrease: { 
              store: { key: "vw-cam_dir" },
              enable: { key: "vw-cam_change-dir" },
              factor: -0.25,
            },
            increase: { 
              store: { key: "vw-cam_dir" },
              enable: { key: "vw-cam_change-dir" },
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-cam_change-dir" },
            },
            title: { 
              text: "Change",
              enable: { key: "vw-cam_change-dir" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "vw-cam_change-dir" },
            },
            field: {
              store: { key: "vw-cam_dir" },
              enable: { key: "vw-cam_change-dir" },
            },
            decrease: { 
              store: { key: "vw-cam_dir" },
              enable: { key: "vw-cam_change-dir" },
              factor: -0.01,
            },
            increase: { 
              store: { key: "vw-cam_dir" },
              enable: { key: "vw-cam_change-dir" },
              factor: 0.01,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "vw-cam_change-dir" },
            },
            field: {
              store: { key: "vw-cam_dir" },
              enable: { key: "vw-cam_change-dir" },
            },
            decrease: { 
              store: { key: "vw-cam_dir" },
              enable: { key: "vw-cam_change-dir" },
              factor: -0.001,
            },
            increase: { 
              store: { key: "vw-cam_dir" },
              enable: { key: "vw-cam_change-dir" },
              factor: 0.001,
            },
          },
        },
      },
      {
        name: "vw-cam_dir-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "vw-cam_pitch",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Pitch",
              enable: { key: "vw-cam_use-pitch" },
              font: "font_inter_10_bold",
              color: VETheme.color.textFocus,
            },
            field: {
              store: { key: "vw-cam_pitch" },
              enable: { key: "vw-cam_use-pitch" },
            },
            decrease: { 
              store: { key: "vw-cam_pitch" },
              enable: { key: "vw-cam_use-pitch"},
              factor: -0.1,
            },
            increase: { 
              store: { key: "vw-cam_pitch" },
              enable: { key: "vw-cam_use-pitch" },
              factor: 0.1,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-cam_use-pitch" },
            },
            title: { 
              text: "Override",
              enable: { key: "vw-cam_use-pitch" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "vw-cam_change-pitch" },
            },
            field: {
              store: { key: "vw-cam_pitch" },
              enable: { key: "vw-cam_change-pitch" },
            },
            decrease: { 
              store: { key: "vw-cam_pitch" },
              enable: { key: "vw-cam_change-pitch" },
              factor: -0.1,
            },
            increase: { 
              store: { key: "vw-cam_pitch" },
              enable: { key: "vw-cam_change-pitch" },
              factor: 0.1,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-cam_change-pitch" },
            },
            title: { 
              text: "Change",
              enable: { key: "vw-cam_change-pitch" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "vw-cam_change-pitch" },
            },
            field: {
              store: { key: "vw-cam_pitch" },
              enable: { key: "vw-cam_change-pitch" },
            },
            decrease: { 
              store: { key: "vw-cam_pitch" },
              enable: { key: "vw-cam_change-pitch" },
              factor: -0.01,
            },
            increase: { 
              store: { key: "vw-cam_pitch" },
              enable: { key: "vw-cam_change-pitch" },
              factor: 0.01,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "vw-cam_change-pitch" },
            },
            field: {
              store: { key: "vw-cam_pitch" },
              enable: { key: "vw-cam_change-pitch" },
            },
            decrease: { 
              store: { key: "vw-cam_pitch" },
              enable: { key: "vw-cam_change-pitch" },
              factor: -0.001,
            },
            increase: { 
              store: { key: "vw-cam_pitch" },
              enable: { key: "vw-cam_change-pitch" },
              factor: 0.001,
            },
          },
        },
      },
      {
        name: "vw-cam_pitch-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "vw-cam_move-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Camera movement",
            backgroundColor: VETheme.color.accentShadow,
          },
          input: { backgroundColor: VETheme.color.accentShadow },
          checkbox: { backgroundColor: VETheme.color.accentShadow },
        },
      },
      {
        name: "vw-cam_move-angle",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Angle",
              font: "font_inter_10_bold",
              color: VETheme.color.textFocus,
              enable: { key: "vw-cam_use-move-angle" },
            },
            field: {
              store: { key: "vw-cam_move-angle" },
              enable: { key: "vw-cam_use-move-angle" },
            },
            decrease: { 
              store: { key: "vw-cam_move-angle" },
              enable: { key: "vw-cam_use-move-angle" },
              factor: -0.25,
            },
            increase: { 
              store: { key: "vw-cam_move-angle" },
              enable: { key: "vw-cam_use-move-angle" },
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-cam_use-move-angle" },
            },
            title: { 
              text: "Override",
              enable: { key: "vw-cam_use-move-angle" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "vw-cam_change-move-angle" },
            },
            field: {
              store: { key: "vw-cam_move-angle" },
              enable: { key: "vw-cam_change-move-angle" },
            },
            decrease: { 
              store: { key: "vw-cam_move-angle" },
              enable: { key: "vw-cam_change-move-angle" },
              factor: -0.25,
            },
            increase: { 
              store: { key: "vw-cam_move-angle" },
              enable: { key: "vw-cam_change-move-angle" },
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-cam_change-move-angle" },
            },
            title: { 
              text: "Change",
              enable: { key: "vw-cam_change-move-angle" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "vw-cam_change-move-angle" },
            },
            field: {
              store: { key: "vw-cam_move-angle" },
              enable: { key: "vw-cam_change-move-angle" },
            },
            decrease: { 
              store: { key: "vw-cam_move-angle" },
              enable: { key: "vw-cam_change-move-angle" },
              factor: -0.01,
            },
            increase: { 
              store: { key: "vw-cam_move-angle" },
              enable: { key: "vw-cam_change-move-angle" },
              factor: 0.01,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "vw-cam_change-move-angle" },
            },
            field: {
              store: { key: "vw-cam_move-angle" },
              enable: { key: "vw-cam_change-move-angle" },
            },
            decrease: { 
              store: { key: "vw-cam_move-angle" },
              enable: { key: "vw-cam_change-move-angle" },
              factor: -0.001,
            },
            increase: { 
              store: { key: "vw-cam_move-angle" },
              enable: { key: "vw-cam_change-move-angle" },
              factor: 0.001,
            },
          },
        },
      },
      {
        name: "vw-cam_move-angle-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "vw-cam_move-speed",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Speed",
              font: "font_inter_10_bold",
              color: VETheme.color.textFocus,
              enable: { key: "vw-cam_use-move-speed" },
            },
            field: {
              store: { key: "vw-cam_move-speed" },
              enable: { key: "vw-cam_use-move-speed" },
            },
            decrease: { 
              store: { key: "vw-cam_move-speed" },
              enable: { key: "vw-cam_use-move-speed" },
              factor: -0.25,
            },
            increase: { 
              store: { key: "vw-cam_move-speed" },
              enable: { key: "vw-cam_use-move-speed" },
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-cam_use-move-speed" },
            },
            title: { 
              text: "Override",
              enable: { key: "vw-cam_use-move-speed" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "vw-cam_change-move-speed" },
            },
            field: {
              store: { key: "vw-cam_move-speed" },
              enable: { key: "vw-cam_change-move-speed" },
            },
            decrease: { 
              store: { key: "vw-cam_move-speed" },
              enable: { key: "vw-cam_change-move-speed" },
              factor: -0.25,
            },
            increase: { 
              store: { key: "vw-cam_move-speed" },
              enable: { key: "vw-cam_change-move-speed" },
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-cam_change-move-speed" },
            },
            title: { 
              text: "Change",
              enable: { key: "vw-cam_change-move-speed" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "vw-cam_change-move-speed" },
            },
            field: {
              store: { key: "vw-cam_move-speed" },
              enable: { key: "vw-cam_change-move-speed" },
            },
            decrease: { 
              store: { key: "vw-cam_move-speed" },
              enable: { key: "vw-cam_change-move-speed" },
              factor: -0.01,
            },
            increase: { 
              store: { key: "vw-cam_move-speed" },
              enable: { key: "vw-cam_change-move-speed" },
              factor: 0.01,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "vw-cam_change-move-speed" },
            },
            field: {
              store: { key: "vw-cam_move-speed" },
              enable: { key: "vw-cam_change-move-speed" },
            },
            decrease: { 
              store: { key: "vw-cam_move-speed" },
              enable: { key: "vw-cam_change-move-speed" },
              factor: -0.001,
            },
            increase: { 
              store: { key: "vw-cam_move-speed" },
              enable: { key: "vw-cam_change-move-speed" },
              factor: 0.001,
            },
          },
        },
      },
    ]),
  }
}