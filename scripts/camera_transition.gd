extends Node2D

@onready var camera = $Camera2D
var transistioning = false

func transition_camera2D(from: Camera2D,to:Camera2D,duration:float = 1.0)->void:
	if transistioning: return
	
	camera.zoom = from.zoom
	camera.offset = from.offset
	camera.light_mask = from.light_mask

	 
	to.drag_horizontal_offset = 0
	to.drag_vertical_offset = 0
	
	camera.global_transform = from.global_transform
	camera.drag_vertical_offset = from.drag_vertical_offset
	camera.drag_horizontal_offset = from.drag_horizontal_offset	
	camera.make_current()
	
	transistioning = true
		
	var tween = create_tween()
	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(camera, "global_transform", to.global_transform, duration).from(camera.global_transform)
	tween.tween_property(camera, "zoom", to.zoom, duration).from(camera.zoom)
	tween.tween_property(camera, "offset", to.offset, duration).from(camera.offset)
	tween.tween_property(camera, "light_mask", to.light_mask, duration).from(camera.light_mask)
	tween.tween_property(camera, "rotation", to.rotation, duration).from(camera.rotation)
	tween.tween_property(camera, "drag_vertical_offset", to.drag_vertical_offset, duration).from(camera.drag_vertical_offset)
	tween.tween_property(camera, "drag_horizontal_offset", to.drag_horizontal_offset, duration).from(camera.drag_horizontal_offset)
	
	# Wait for the tween to complete
	await tween.finished
	transistioning = false
	
	to.make_current()
	
