///@package io.alkapivo.visu.ui

///@type {Map<String, Callable>}
global.__VisuStyles = new Map(String, Callable, {
  "menu-title": {
    label: {
      align: { v: VAlign.CENTER, h: HAlign.CENTER },
      font: "font_kodeo_mono_28_bold",
      color: "#ffffff",
      offset: { x: 12 },
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
      backgroundAlpha: 0.7,
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
      backgroundAlpha: 0.7,
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
        backgroundAlpha: 0.7,
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
      backgroundAlpha: 0.7,
    },
    preview: {
      align: { v: VAlign.CENTER, h: HAlign.CENTER },
      font: "font_kodeo_mono_18_bold",
      color: "#ffffff",
      enableColorWrite: false,
      colorHoverOver: VETheme.color.accentShadow,
      backgroundAlpha: 0.7,
    }
  },
})
#macro VisuStyles global.__VisuStyles