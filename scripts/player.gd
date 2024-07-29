extends CharacterBody2D

@export var max_speed = 400
@export var accel = 1500
@export var friction = 600

@export var inv: Inv

var max_burn_health = 15
var max_shadow_health = 25
var burn_rate = 2

var is_area_light = 0
var burn_health = 15
var shadow_health = 25

var input = Vector2.ZERO

func _ready():
	burn_health = max_burn_health
	shadow_health = max_shadow_health

func _physics_process(delta):
	player_movement(delta)
	if is_area_light > 0:
		burn_shadow(delta)
	else:
		shadow_darken(delta)
	shadow_vision()
	#print("health " + str(burn_health) + " shadow " + str(shadow_health))

func shadow_vision():
	$PointLight2D.color.a = 1 - (shadow_health/max_shadow_health)

func burn_shadow(delta):
	if shadow_health < max_shadow_health:
		burn_health -= delta / burn_rate
		shadow_health += delta

func shadow_darken(delta):
	shadow_health -= delta
	if shadow_health <= 0:
		lose_body()

func lose_body():
	print("body gone")
	pass

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

func player():
	pass

func entered_light_area():
	is_area_light += 1

func exit_light_area():
	is_area_light -= 1
