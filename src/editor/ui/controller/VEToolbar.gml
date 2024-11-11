///@package io.alkapivo.visu.editor.ui.controller

///@todo Finish & replace brush toolbar, accordion, event inspector and template toolbar 
///      with this generic type
function VEToolbar() constructor {

  ///@param {?UILayout} [parent]
  ///@param {HAlign} [hAlign]
  factoryLayout = function(parent = null, hAlign = HAlign.LEFT) {
    return new UILayout(
      {
        name: "ve-toolbar",
        store: {
          render: false,
          hAlign: hAlign,
          options: {
            width: 24.0,
            height: 96.0,
            size: 1.0,
          },
        },
        nodes: {
          content: {
            name: "ve-toolbar.content",
            x: function() { return this.context.store.hAlign == HAlign.LEFT
              ? this.x()
              : this.x() + this.context.nodes.resize.width() },
            y: function() { return this.y() },
            width: function() { return this.width() - this.context.nodes.resize.width() },
            height: function() { return this.height() },
          },
          options: {
            name: "ve-toolbar.options",
            x: function() { return this.context.store.hAlign == HAlign.LEFT 
              ? this.context.x() - this.context.store.options.width
              : this.context.x() + this.context.width() },
            y: function() { return this.context.y() },
            width: function() { return this.context.store.options.width },
            height: function() { return this.context.store.options.size 
              * this.context.store.options.height },
          },
          resize: {
            name: "ve-toolbar.resize",
            x: function() { return this.context.x()
              + this.context.width()
              - this.width() },
            y: function() { return 0 },
            width: function() { return 8 },
            height: function() { return this.context.height() },
          },
        }
      },
      parent
    )
  }
}