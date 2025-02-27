# Adds a simple shadow below an object.
# Place this ShadowMath25D node as a child of a Shadow25D, which
# is below the target object in the scene tree (not as a child).
@tool
@icon("res://addons/node25d/icons/shadow_math_25d_icon.png")
extends CharacterBody3D
class_name ShadowMath25D


# The maximum distance below objects that shadows will appear (in 3D units).
var shadow_length = 1000.0
var _shadow_root: Node25D
var _target_math: Node3D


func _ready():
	_shadow_root = get_parent()
	var index = _shadow_root.get_index()
	if (index > 0): # Else, Shadow is not in a valid place.
		_target_math = _shadow_root.get_parent().get_child(index - 1).get_child(0)


func _physics_process(_delta):
	if _target_math == null:
		if _shadow_root != null:
			_shadow_root.visible = false
		return # Shadow is not in a valid place or you're viewing the Shadow25D scene.

	position = _target_math.position
	var k = move_and_collide(Vector3.DOWN * shadow_length)
	if k == null:
		_shadow_root.visible = false
	else:
		_shadow_root.visible = true
		global_transform = transform
