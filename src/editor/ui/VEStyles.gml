///@package io.alkapivo.visu.editor.ui

///@static
///@type {Struct}
global.__VETheme = {
  color: null,
  ///@theme purple
  purple: {
    primary: "#3B3B53",
    primaryLight: "#455f82",
    primaryShadow: "#2B2B35",
    primaryDark: "#222227",
    dark: "#1B1B20",
    darkBetween: "#141418",
    darkShadow: "#0D0D0F",
    accent: "#7742b8",
    accentBetween: "#5f398e",
    accentShadow: "#462f63",
    accentDark: "#231832",
    text: "#D9D9D9",
    textShadow: "#878787",
    textFocus: "#ededed",
    textSelected: "#462f63",
    accept: "#74a892",
    acceptShadow: "#008585",
    deny: "#e35972",
    denyShadow: "#bf445d",
    ruler: "#E64B3D",
    header: "#963271",
  },
  ///@theme vscode
  vscode: {
    primary: "#464646",
    primaryLight: "#615b5b",
    primaryShadow: "#333333",
    primaryDark: "#1a1a1e",
    dark: "#282828",
    darkBetween: "#1A1A1A",
    darkShadow: "#131313",
    accent: "#436995",
    accentBetween: "#395b82",
    accentShadow: "#2f4c6e",
    accentDark: "#1b334f",
    text: "#D9D9D9",
    textShadow: "#9B9B9B",
    textFocus: "#FFFFFF",
    textSelected: "#B2DBE3",
    accept: "#469E59",
    acceptShadow: "#468a55",
    deny: "#A84545",
    denyShadow: "#823d3d",
    ruler: "#E64B3D",
    header: "#963271",
  },
}
#macro VETheme global.__VETheme

///@description Set theme
VETheme.color = VETheme.purple


///@static
///@type {Map<String, Struct>}
global.__VEStyles = new Map(String, Struct, {
  "visu-modal": {
    message: {
      color: VETheme.color.textFocus,
      font: "font_inter_10_regular",
      align: { v: VAlign.CENTER, h: HAlign.CENTER },
    },
    accept: {
      backgroundColor: VETheme.color.acceptShadow,
      label: {
        color: VETheme.color.textFocus,
        font: "font_inter_10_regular",
        align: { v: VAlign.CENTER, h: HAlign.CENTER },
      }
    },
    deny: {
      backgroundColor: VETheme.color.denyShadow,
      label: {
        color: VETheme.color.textFocus,
        font: "font_inter_10_regular",
        align: { v: VAlign.CENTER, h: HAlign.CENTER },
      }
    },
  },
  "ve-title-bar": {
    menu: {
      backgroundColorSelected: VETheme.color.primaryLight,
      backgroundColorOut: VETheme.color.darkShadow,  
      backgroundColor: VETheme.color.darkShadow,  
      label: {
        font: "font_inter_10_regular",
        color: VETheme.color.text,
        align: { v: VAlign.CENTER, h: HAlign.CENTER },
      }
    },
    version: {
      font: "font_inter_10_regular",
      color: VETheme.color.text,
      outline: true,
      outlineColor: VETheme.color.darkShadow,
      align: { v: VAlign.CENTER, h: HAlign.CENTER },
    },
    checkbox: {}
  },
  "ve-status-bar": {
    label: {
      font: "font_inter_10_regular",
      color: VETheme.color.textShadow,
      align: { v: VAlign.CENTER, h: HAlign.RIGHT },
    },
    value: {
      font: "font_inter_10_regular",
      color: VETheme.color.textShadow,
      align: { v: VAlign.CENTER, h: HAlign.LEFT },
    },
  },
  "ve-track-control": {
    slider: {},
    button: {},
    label: {
      font: "font_inter_10_regular",
      color: VETheme.color.textFocus,
      align: { v: VAlign.CENTER, h: HAlign.LEFT },
    },
  },
  "bar-title": {
    align: { v: VAlign.CENTER, h: HAlign.LEFT },
    font: "font_inter_8_regular",
    color: VETheme.color.textShadow,
    offset: { x: 4 },
  },
  "bar-button": {
    backgroundColor: "#000000",
    label: {
      align: { v: VAlign.CENTER, h: HAlign.CENTER },
      font: "font_inter_8_regular",
      color: VETheme.color.textShadow,
    }
  },
  "checkbox": {
    spriteOn: { name: "visu_texture_checkbox_on" },
    spriteOff: { name: "visu_texture_checkbox_off" },
  },
  "category-button": {
    label: {
      backgroundColorSelected: VETheme.color.primaryLight,
      backgroundColor: VETheme.color.dark,
      font: "font_inter_8_regular",
      color: VETheme.color.textFocus,
      align: { v: VAlign.CENTER, h: HAlign.CENTER },
    },
  },
  "channel-entry": {
    label: {
      backgroundColor: VETheme.color.primaryShadow,
      align: { v: VAlign.CENTER, h: HAlign.RIGHT },
      font: "font_inter_10_regular",
      color: VETheme.color.textShadow,
      offset: { x: -5 },
    },
    settings: {
      backgroundColor: VETheme.color.primaryShadow,
      label: {
        align: { v: VAlign.CENTER, h: HAlign.CENTER },
        font: "font_inter_10_regular",
        color: VETheme.color.textShadow,
        backgroundColor: VETheme.color.primaryShadow,
      }
    },
    remove: {
      backgroundColor: VETheme.color.primaryShadow,
      label: {
        align: { v: VAlign.CENTER, h: HAlign.CENTER },
        font: "font_inter_10_regular",
        color: VETheme.color.textShadow,
        backgroundColor: VETheme.color.primaryShadow,
      }
    },
    mute: {
      backgroundColor: VETheme.color.primaryShadow,
    },
  },
  "brush-entry": {
    image: {
      backgroundColor: VETheme.color.primaryShadow,
    },
    label: {
      backgroundColor: VETheme.color.primaryShadow,
      align: { v: VAlign.CENTER, h: HAlign.LEFT },
      font: "font_inter_10_regular",
      color: VETheme.color.textShadow,
      offset: { x: 4 },
    },
    remove: {
      backgroundColor: VETheme.color.primaryShadow,
      label: {
        align: { v: VAlign.CENTER, h: HAlign.CENTER },
        font: "font_inter_10_regular",
        color: VETheme.color.textShadow,
        backgroundColor: VETheme.color.primaryShadow,
      }
    },
    settings: {
      backgroundColor: VETheme.color.primaryShadow,
      label: {
        align: { v: VAlign.CENTER, h: HAlign.CENTER },
        font: "font_inter_10_regular",
        color: VETheme.color.textShadow,
        backgroundColor: VETheme.color.primaryShadow,
      }
    },
  },
  "template-entry": {
    settings: {
      backgroundColor: VETheme.color.primaryShadow,
      label: {
        align: { v: VAlign.CENTER, h: HAlign.CENTER },
        font: "font_inter_10_regular",
        color: VETheme.color.textShadow,
        backgroundColor: VETheme.color.primaryShadow,
      }
    },
    remove: {
      backgroundColor: VETheme.color.primaryShadow,
      label: {
        align: { v: VAlign.CENTER, h: HAlign.CENTER },
        font: "font_inter_10_regular",
        color: VETheme.color.textShadow,
        backgroundColor: VETheme.color.primaryShadow,
      }
    },
    label: {
      backgroundColor: VETheme.color.primaryShadow,
      align: { v: VAlign.CENTER, h: HAlign.LEFT },
      font: "font_inter_10_regular",
      color: VETheme.color.textShadow,
      offset: { x: 4 },
    },
  },
  "line-h": {
    image: {
      backgroundColor: VETheme.color.primaryShadow,
      backgroundAlpha: 1.0,
    },
  },
  "line-w": {
    image: {
      backgroundColor: VETheme.color.primaryShadow,
      backgroundAlpha: 1.0,
    },
  },
  "property": {
    checkbox: {
      backgroundColor: VETheme.color.primaryShadow,
    },
    label: {
      backgroundColor: VETheme.color.primaryShadow,
      offset: { x: 4 },
      font: "font_inter_10_bold",
      color: VETheme.color.textFocus,
      align: { v: VAlign.CENTER, h: HAlign.LEFT },
    },
    input: {
      backgroundColor: VETheme.color.primaryShadow,
    },
  },
  "property-bar": {
    checkbox: {
      backgroundColor: VETheme.color.accentShadow,
    },
    label: {
      backgroundColor: VETheme.color.accentShadow,
      offset: { x: 4 },
      font: "font_inter_10_bold",
      color: VETheme.color.textFocus,
      align: { v: VAlign.CENTER, h: HAlign.CENTER },
    },
    input: {
      backgroundColor: VETheme.color.accentShadow,
    },
  },
  "text-field": { 
    font: "font_inter_10_regular",
    colorBackgroundUnfocused: VETheme.color.primaryDark,
    colorBackgroundFocused: VETheme.color.primaryShadow,
    colorTextUnfocused: VETheme.color.textShadow,
    colorTextFocused: VETheme.color.textFocus,
    colorSelection: VETheme.color.textSelected,
    lh: 22.0000,
    padding: { top: 0, bottom: 0, left: 4, right: 0 }
  },
  "text-field-simple": { 
    font: "font_inter_10_regular",
    colorBackgroundUnfocused: VETheme.color.primaryDark,
    colorBackgroundFocused: VETheme.color.primaryShadow,
    colorTextUnfocused: VETheme.color.textShadow,
    colorTextFocused: VETheme.color.textFocus,
    colorSelection: VETheme.color.textSelected,
    lh: 20.0000,
    padding: { top: 0, bottom: 0, left: 4, right: 0 }
  },
  "text-field-button": { 
    font: "font_inter_10_regular",
    colorBackgroundUnfocused: VETheme.color.primaryDark,
    colorBackgroundFocused: VETheme.color.primaryShadow,
    colorTextUnfocused: VETheme.color.textShadow,
    colorTextFocused: VETheme.color.textFocus,
    colorSelection: VETheme.color.textSelected,
    lh: 22.0000,
    padding: { top: 0, bottom: 0, left: 4, right: 0 },
    label: {
      font: "font_inter_10_regular",
      color: VETheme.color.textShadow,
      align: { v: VAlign.CENTER, h: HAlign.RIGHT },
    },
    field: {
      font: "font_inter_10_regular",
      colorBackgroundUnfocused: VETheme.color.primaryDark,
      colorBackgroundFocused: VETheme.color.primaryShadow,
      colorTextUnfocused: VETheme.color.textShadow,
      colorTextFocused: VETheme.color.textFocus,
      colorSelection: VETheme.color.textSelected,
      lh: 22.0000,
      padding: { top: 0, bottom: 0, left: 4, right: 0 },
    },
    button: {
      label: {
        font: "font_inter_8_regular",
        color: VETheme.color.textFocus,
        align: { v: VAlign.CENTER, h: HAlign.CENTER },
      },
      backgroundColor: VETheme.color.accentShadow,
    },
  },
  "text-field-checkbox": { 
    font: "font_inter_10_regular",
    colorBackgroundUnfocused: VETheme.color.primaryDark,
    colorBackgroundFocused: VETheme.color.primaryShadow,
    colorTextUnfocused: VETheme.color.textShadow,
    colorTextFocused: VETheme.color.textFocus,
    colorSelection: VETheme.color.textSelected,
    lh: 22.0000,
    padding: { top: 0, bottom: 0, left: 4, right: 0 },
    label: {
      font: "font_inter_10_regular",
      color: VETheme.color.textShadow,
      align: { v: VAlign.CENTER, h: HAlign.RIGHT },
    },
    field: {
      font: "font_inter_10_regular",
      colorBackgroundUnfocused: VETheme.color.primaryDark,
      colorBackgroundFocused: VETheme.color.primaryShadow,
      colorTextUnfocused: VETheme.color.textShadow,
      colorTextFocused: VETheme.color.textFocus,
      colorSelection: VETheme.color.textSelected,
      lh: 22.0000,
      padding: { top: 0, bottom: 0, left: 4, right: 0 },
    },
    checkbox: { },
    title: {
      font: "font_inter_10_regular",
      color: VETheme.color.textShadow,
      align: { v: VAlign.CENTER, h: HAlign.LEFT },
    },
  },
  "text-field-button-checkbox": { 
    font: "font_inter_10_regular",
    colorBackgroundUnfocused: VETheme.color.primaryDark,
    colorBackgroundFocused: VETheme.color.primaryShadow,
    colorTextUnfocused: VETheme.color.textShadow,
    colorTextFocused: VETheme.color.textFocus,
    colorSelection: VETheme.color.textSelected,
    lh: 22.0000,
    padding: { top: 0, bottom: 0, left: 4, right: 0 },
    label: {
      font: "font_inter_10_regular",
      color: VETheme.color.textShadow,
      align: { v: VAlign.CENTER, h: HAlign.RIGHT },
    },
    field: {
      font: "font_inter_10_regular",
      colorBackgroundUnfocused: VETheme.color.primaryDark,
      colorBackgroundFocused: VETheme.color.primaryShadow,
      colorTextUnfocused: VETheme.color.textShadow,
      colorTextFocused: VETheme.color.textFocus,
      colorSelection: VETheme.color.textSelected,
      lh: 22.0000,
      padding: { top: 0, bottom: 0, left: 4, right: 0 },
    },
    button: {
      label: {
        font: "font_inter_10_regular",
        color: VETheme.color.textFocus,
        align: { v: VAlign.CENTER, h: HAlign.CENTER },
      },
      backgroundColor: VETheme.color.accentShadow,
    },
    checkbox: { }
  },
  "text-field_label": {
    font: "font_inter_10_regular",
    color: VETheme.color.textShadow,
    align: { v: VAlign.CENTER, h: HAlign.RIGHT },
  },
  "text-area": { 
    font: "font_consolas_10_regular",
    colorBackgroundUnfocused: VETheme.color.primaryDark,
    colorBackgroundFocused: VETheme.color.primaryShadow,
    colorTextUnfocused: VETheme.color.textShadow,
    colorTextFocused: VETheme.color.textFocus,
    colorSelection: VETheme.color.textSelected,
    lh: 22.0000,
    padding: { top: 0, bottom: 0, left: 4, right: 0 },
    field: {
      font: "font_consolas_10_regular",
      colorBackgroundUnfocused: VETheme.color.primaryDark,
      colorBackgroundFocused: VETheme.color.primaryShadow,
      colorTextUnfocused: VETheme.color.textShadow,
      colorTextFocused: VETheme.color.textFocus,
      colorSelection: VETheme.color.textSelected,
      lh: 22.0000,
      padding: { top: 0, bottom: 0, left: 4, right: 0 }
    }
  },
  "slider-horizontal": {
    pointer: {
      name: "texture_slider_pointer_simple",
      scaleX: 0.125,
      scaleY: 0.125,
      blend: VETheme.color.primary,
    },
    progress: {
      thickness: 0.9,
      blend: VETheme.color.accentBetween,
      line: { name: "texture_grid_line_bold" },
    },
    background: {
      thickness: 1.1,
      blend: VETheme.color.darkBetween,
      line: { name: "texture_grid_line_bold" },
    },
  },
  "spin-select": {
    previous: {
      label: {
        font: "font_inter_8_bold",
        color: VETheme.color.textFocus,
        align: { v: VAlign.CENTER, h: HAlign.CENTER },
      },
    },
    next: {
      label: {
        font: "font_inter_8_bold",        
        color: VETheme.color.textFocus,
        align: { v: VAlign.CENTER, h: HAlign.CENTER },
      },
    },
  },
  "spin-select-image": {
    preview: {
      image: { name: "texture_empty" },
      store: {
        callback: function(value, data) { 
          var image = SpriteUtil.parse({ name: value })
          if (!Core.isType(image, Sprite)) {
            return
          }
          Struct.set(data, "image", image)
        },
      }
    },
  },
  "spin-select-label": {
    preview: {
      label: { 
        text: "",
        color: VETheme.color.textFocus,
        outline: true,
        outlineColor: VETheme.color.darkShadow,
        font: "font_inter_8_bold",
        align: { v: VAlign.CENTER, h: HAlign.CENTER },
      },
      store: { 
        callback: function(value, data) {
          data.label.text = value
        },
      },
    },
  },
  "spin-select-label_no-store": {
    preview: {
      label: { 
        text: "",
        color: VETheme.color.textFocus,
        font: "font_inter_10_regular",
        align: { v: VAlign.CENTER, h: HAlign.CENTER },
      },
    },
  },
  "transform-numeric-uniform": {
    label: {
      font: "font_inter_10_regular",
      color: VETheme.color.textShadow,
      align: { v: VAlign.BOTTOM, h: HAlign.LEFT },
    }
  },
  "transform-vec2-uniform": {
    label: {
      font: "font_inter_10_regular",
      color: VETheme.color.textShadow,
      align: { v: VAlign.BOTTOM, h: HAlign.LEFT },
    }
  },
  "transform-vec3-uniform": {
    label: {
      font: "font_inter_10_regular",
      color: VETheme.color.textShadow,
      align: { v: VAlign.BOTTOM, h: HAlign.LEFT },
    }
  },
  "transform-vec4-uniform": {
    label: {
      font: "font_inter_10_regular",
      color: VETheme.color.textShadow,
      align: { v: VAlign.BOTTOM, h: HAlign.LEFT },
    }
  },
  "texture-field-ext": {
    resolution: {
      font: "font_inter_10_regular",
      color: VETheme.color.textShadow,
      align: { v: VAlign.CENTER, h: HAlign.CENTER },
    }
  },
  "preview-image-mask": {
    resolution: {
      font: "font_inter_10_regular",
      color: VETheme.color.textShadow,
      align: { v: VAlign.CENTER, h: HAlign.CENTER },
    }
  },
  "double-checkbox": {
    label: {
      offset: { x: 0 },
      font: "font_inter_10_bold",
      color: VETheme.color.textShadow,
      align: { v: VAlign.CENTER, h: HAlign.RIGHT },
    },
    checkbox1: { },
    label1: {
      offset: { x: 0 },
      font: "font_inter_10_regular",
      color: VETheme.color.textShadow,
      align: { v: VAlign.CENTER, h: HAlign.LEFT },
    },
    checkbox2: { },
    label2: {
      offset: { x: 0 },
      font: "font_inter_10_regular",
      color: VETheme.color.textShadow,
      align: { v: VAlign.CENTER, h: HAlign.LEFT },
    }
  },
})
#macro VEStyles global.__VEStyles
