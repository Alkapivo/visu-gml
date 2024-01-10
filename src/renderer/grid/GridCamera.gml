///@package com.alkapivo.visu.component.grid.renderer.GridCamera

///@param {Struct} [config]
function GridCamera(config = {}) constructor {
    
	///@type {Number}
	x = Struct.getDefault(config, "x", 4096)

  ///@type {Number}
	y = Struct.getDefault(config, "y", 5356)

  ///@type {Number}
	z = Struct.getDefault(config, "z", 0)

  ///@type {Number}
	zoom = Struct.getDefault(config, "zoom", 5000)

  ///@type {Number}
	angle = Struct.getDefault(config, "angle", 270)

    ///@type {Number}
	pitch = Struct.getDefault(config, "pitch", -70)

  ///@type {?Matrix}
  viewMatrix = null

	///@type {?Matrix}
	projectionMatrix = null

	///@type {Boolean}
	enableMouseLook = Struct.getDefault(config, "enableMouseLook", false)

	///@type {Number}
	moveSpeed = Struct.getDefault(config, "moveSpeed", 16)

	///@type {GMCamera}
	gmCamera = camera_create()

	executor = new TaskExecutor(this)

	///@return {Camera}
	update = function() {
		this.executor.update()
		this.enableMouseLook = keyboard_check_pressed(vk_f1)
			? !this.enableMouseLook 
			: this.enableMouseLook
			
		if (!this.enableMouseLook) {
			return this
		}

		this.angle -= (window_mouse_get_x() - GuiWidth() / 2) / 10
		this.pitch -= (window_mouse_get_y() - GuiHeight() / 2) / 10
		this.pitch = clamp(this.pitch, -85, 85)
		window_mouse_set(GuiWidth() / 2, GuiHeight() / 2)

		var dx = 0
		var dy = 0
		var dz = 0
		if (keyboard_check(ord("A"))) {
				dx += dsin(this.angle) * moveSpeed
				dy += dcos(this.angle) * moveSpeed
		}

		if (keyboard_check(ord("D"))) {
				dx -= dsin(this.angle) * moveSpeed
				dy -= dcos(this.angle) * moveSpeed
		}

		if (keyboard_check(ord("W"))) {
				dx -= dcos(this.angle) * moveSpeed
				dy += dsin(this.angle) * moveSpeed
		}

		if (keyboard_check(ord("S"))) {
				dx += dcos(this.angle) * moveSpeed
				dy -= dsin(this.angle) * moveSpeed
		}

		if (mouse_wheel_up()) {
				dz += moveSpeed * 10
		}

		if (mouse_wheel_down()) {
				dz -= moveSpeed * 10
		}
		this.x += dx
		this.y += dy
		this.z += dz

		return this
	}
}
