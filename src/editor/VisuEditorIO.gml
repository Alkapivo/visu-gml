///@package io.alkapivo.visu.editor

#macro BeanVisuEditorIO "VisuEditorIO"
function VisuEditorIO() constructor {

  ///@type {Keyboard}
  keyboard = new Keyboard(
    { 
      renderLeftPane: KeyboardKeyType.F1,
      renderBottomPane: KeyboardKeyType.F2,
      renderRightPane: KeyboardKeyType.F3,
      renderTrackControl: KeyboardKeyType.F4,
      exitModal: KeyboardKeyType.ESC,
      newProject: "N",
      saveProject: "S",
      saveTemplate: "T",
      saveBrush: "U",
      selectTool: "S",
      eraseTool: "E",
      brushTool: "B",
      cloneTool: "C",
      previewBrush: "P",
      previewEvent: "I",
      snapToGrid: "G",
      zoomIn: KeyboardKeyType.PLUS,
      zoomOut: KeyboardKeyType.MINUS,
      numZoomIn: KeyboardKeyType.NUM_PLUS,
      numZoomOut: KeyboardKeyType.NUM_MINUS,
      controlLeft: KeyboardKeyType.CONTROL_LEFT,
    }
  )

  ///@private
  ///@param {VisuController} controller
  ///@param {VisuEditorController} editor
  ///@return {VisuEditorIO}
  controlTrackKeyboardEvent = function(controller, editor) {
    if (GMTFContext.isFocused()) {
      return
    }

    if (this.keyboard.keys.selectTool.pressed) {
      editor.store.get("tool").set("tool_select")
    }

    if (this.keyboard.keys.eraseTool.pressed) {
      editor.store.get("tool").set("tool_erase")
    }

    if (this.keyboard.keys.brushTool.pressed) {
      editor.store.get("tool").set("tool_brush")
    }

    if (this.keyboard.keys.cloneTool.pressed) {
      editor.store.get("tool").set("tool_clone")
    }

    if (this.keyboard.keys.zoomIn.pressed 
      || this.keyboard.keys.numZoomIn.pressed) {

      var item = editor.store.get("timeline-zoom")
      item.set(clamp(item.get() - 1, 5, 20))
    }

    if (this.keyboard.keys.zoomOut.pressed 
      || this.keyboard.keys.numZoomOut.pressed) {

      var item = editor.store.get("timeline-zoom")
      item.set(clamp(item.get() + 1, 5, 20))
    }

    if (this.keyboard.keys.snapToGrid.pressed) {
      var item = editor.store.get("snap")
      item.set(!item.get())
    }

    return this
  }

  ///@private
  ///@param {VisuController} controller
  ///@param {VisuEditorController} editor
  ///@return {VisuEditorIO}
  functionKeyboardEvent = function(controller, editor) {
    if (this.keyboard.keys.renderTrackControl.pressed) {
      editor.store.get("render-trackControl")
        .set(!editor.store.getValue("render-trackControl"))
    }

    if (this.keyboard.keys.renderLeftPane.pressed) {
      editor.store.get("render-event")
        .set(!editor.store.getValue("render-event"))
    }

    if (this.keyboard.keys.renderBottomPane.pressed) {
      editor.store.get("render-timeline")
        .set(!editor.store.getValue("render-timeline"))
    }

    if (this.keyboard.keys.renderRightPane.pressed) {
      editor.store.get("render-brush")
        .set(!editor.store.getValue("render-brush"))
    }

    return this
  }

  ///@private
  ///@param {VisuController} controller
  ///@param {VisuEditorController} editor
  ///@return {VisuEditorIO}
  modalKeyboardEvent = function(controller, editor) {
    if (!GMTFContext.isFocused() 
      && this.keyboard.keys.exitModal.pressed) {

      if (Core.isType(controller.uiService.find("visu-new-project-modal"), UI)) {
        editor.newProjectModal.send(new Event("close"))
      } else if (Core.isType(controller.uiService.find("visu-modal"), UI)) {
        editor.exitModal.send(new Event("close"))
      } else {
        editor.exitModal.send(new Event("open").setData({
          layout: new UILayout({
            name: "display",
            x: function() { return 0 },
            y: function() { return 0 },
            width: function() { return GuiWidth() },
            height: function() { return GuiHeight() },
          }),
        }))
        controller.visuRenderer.gridRenderer.camera.enableMouseLook = false
        controller.visuRenderer.gridRenderer.camera.enableKeyboardLook = false
      }
    }

    if (!GMTFContext.isFocused() 
      && this.keyboard.keys.controlLeft.on 
      && this.keyboard.keys.newProject.pressed) {
      
      editor.newProjectModal.send(new Event("open").setData({
        layout: new UILayout({
          name: "display",
          x: function() { return 0 },
          y: function() { return 0 },
          width: function() { return GuiWidth() },
          height: function() { return GuiHeight() },
        }),
      }))
    }

    return this
  }

  ///@private
  ///@param {VisuController} controller
  ///@param {VisuEditorController} editor
  ///@return {VisuEditorIO}
  titleBarKeyboardEvent = function(controller, editor) {
    if (GMTFContext.isFocused()) {
      return
    }

    if (this.keyboard.keys.controlLeft.on 
      && this.keyboard.keys.saveProject.pressed) {
      try {
        var path = FileUtil.getPathToSaveWithDialog({ 
          description: "Visu track file",
          filename: "manifest", 
          extension: "visu",
        })

        if (!Core.isType(path, String) || String.isEmpty(path)) {
          return
        }

        global.__VisuTrack.saveProject(path)

        controller.send(new Event("spawn-popup", 
          { message: $"Project '{controller.trackService.track.name}' saved successfully at: '{path}'" }))
      } catch (exception) {
        var message = $"Cannot save the project: {exception.message}"
        controller.send(new Event("spawn-popup", { message: message }))
        Logger.error("VETitleBar", message)
      }
    }

    return this
  }

  ///@private
  ///@param {VisuController} controller
  ///@param {VisuEditorController} editor
  ///@return {VisuEditorIO}
  templateToolbarKeyboardEvent = function(controller, editor) {
    if (GMTFContext.isFocused()) {
      return this
    }

    if (this.keyboard.keys.saveTemplate.pressed 
      && editor.store.getValue("render-event")) {
      
      editor.accordion.templateToolbar.send(new Event("save-template"))
    }

    if (this.keyboard.keys.previewEvent.pressed) {
      var event = editor.accordion.eventInspector.store.getValue("event")
      if (Core.isType(event, VEEvent)) {
        var handler = controller.trackService.handlers.get(event.type)
        handler(event.toTemplate().event.data)
      }
    }
    return this
  }

  ///@private
  ///@param {VisuController} controller
  ///@param {VisuEditorController} editor
  ///@return {VisuEditorIO}
  brushToolbarKeyboardEvent = function(controller, editor) {
    if (GMTFContext.isFocused()) {
      return this
    }
    
    if (this.keyboard.keys.saveBrush.pressed 
      && editor.store.getValue("render-brush")) {
      
      editor.brushToolbar.send(new Event("save-brush"))
    }

    if (!this.keyboard.keys.controlLeft.on 
      && this.keyboard.keys.previewBrush.pressed) {
      var brush = editor.brushToolbar.store.getValue("brush")
      if (Core.isType(brush, VEBrush)) {
        var handler = controller.trackService.handlers.get(brush.type)
        handler(brush.toTemplate().properties)
      }
    }

    return this
  }

  ///@return {VisuEditorIO}
  update = function() {
    try {
      this.keyboard.update()

      var editor = Beans.get(BeanVisuEditorController)
      if (!Core.isType(editor, VisuEditorController)) {
        return this
      }
      
      var controller = Beans.get(BeanVisuController)
      if (!Core.isType(controller, VisuController)) {
        return this
      }

      this.controlTrackKeyboardEvent(controller, editor)
      this.functionKeyboardEvent(controller, editor)
      this.titleBarKeyboardEvent(controller, editor)
      this.modalKeyboardEvent(controller, editor)
      this.templateToolbarKeyboardEvent(controller, editor)
      this.brushToolbarKeyboardEvent(controller, editor)
    } catch (exception) {
      var message = $"'VisuEditorIO.update' fatal error: {exception.message}"
      Logger.error(BeanVisuEditorIO, message)
      
      var controller = Beans.get(BeanVisuController)
      if (Core.isType(controller, VisuController)) {
        controller.send(new Event("spawn-popup", { message: message }))
      }
    }

    return this
  }
}