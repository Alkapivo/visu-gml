///@package io.alkapivo.visu.ui

///@type {Map<String, Callable>}
global.__VisuStyles = new Map(String, Callable, {
  "menu-title": {
    label: {
      align: { v: VAlign.CENTER, h: HAlign.CENTER },
      font: "font_kodeo_mono_28_bold",
      color: "#ffffff",
      enableColorWrite: false,
    },
  },
  "menu-button-entry": {
    label: {
      align: { v: VAlign.CENTER, h: HAlign.LEFT },
      font: "font_kodeo_mono_18_bold",
      color: "#ffffff",
      offset: { x: 12 },
      enableColorWrite: false,
      colorHoverOver: VETheme.color.accentShadow,
      colorHoverOut: VETheme.color.dark,
      backgroundAlpha: 0.9,
    },
  },
  "menu-spin-select-entry": {
    label: {
      align: { v: VAlign.CENTER, h: HAlign.LEFT },
      font: "font_kodeo_mono_18_bold",
      color: "#ffffff",
      offset: { x: 12 },
      enableColorWrite: false,
      colorHoverOver: VETheme.color.accentShadow,
      colorHoverOut: VETheme.color.dark,
      backgroundAlpha: 0.9,
    },
    previous: {
      sprite: { name: "texture_button_previous", scaleX: 0.33, scaleY: 0.33 }
    },
    preview: {
      label: {
        align: { v: VAlign.CENTER, h: HAlign.CENTER },
        font: "font_kodeo_mono_18_bold",
        color: "#ffffff",
        enableColorWrite: false,
        colorHoverOver: VETheme.color.accentShadow,
        colorHoverOut: VETheme.color.dark,
        backgroundAlpha: 0.9,
      },
    },
    next: {
      sprite: { name: "texture_button_next", scaleX: 0.33, scaleY: 0.33 }
    },
  },
  "menu-keyboard-key-entry": {
    label: {
      align: { v: VAlign.CENTER, h: HAlign.LEFT },
      font: "font_kodeo_mono_18_bold",
      color: "#ffffff",
      offset: { x: 12 },
      enableColorWrite: false,
      colorHoverOver: VETheme.color.accentShadow,
      colorHoverOut: VETheme.color.dark,
      backgroundAlpha: 0.9,
    },
    preview: {
      align: { v: VAlign.CENTER, h: HAlign.CENTER },
      font: "font_kodeo_mono_18_bold",
      color: "#ffffff",
      enableColorWrite: false,
      colorHoverOver: VETheme.color.accentShadow,
      colorHoverOut: VETheme.color.dark,
      backgroundAlpha: 0.9,
    }
  },
})
#macro VisuStyles global.__VisuStyles