extends CharacterBody2D

@export var max_speed = 400
@export var accel = 1500
@export var friction = 600

@export var inv: Inv

var input = Vector2.ZERO

func _physics_process(delta):
	player_movement(delta)

func get_input():
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return input.normalized()

func player_movement(delta):
	input = get_input()
	
	if input == Vector2.ZERO:
		if velocity.length()> (friction*delta):
			velocity -= velocity.normalized()*(friction*delta)	#stopping or decelerating
		else:
			velocity = Vector2.ZERO		#full stop
	else:
		velocity+=(input*accel*delta)	#speed up
		velocity = velocity.limit_length(max_speed)	#limit speed
	
	move_and_slide()

func collect(item):
	inv.insert(item)

func has_item(item):
	return inv.has_item(item)

func remove_item(item):
	inv.remove_item(item)
