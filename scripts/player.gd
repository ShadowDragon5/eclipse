extends CharacterBody2D

@onready var head = %Head
@onready var arms = %Arms
@onready var torso = %Torso
@onready var legs = %Legs
@onready var durability = $Durability
@onready var shadow = $Shadow
@onready var comment = preload("res://scenes/text_comment.tscn")


@export var max_speed = 150
@export var accel = 350
@export var friction = 250
@export var inventory_size:int = 6

@export var inv: Inv

static var bodies: Array = []
static var current_body: CharacterBody2D = null
static  var swapping: bool = false

var max_burn_health = 25
var max_shadow_health = 40
var burn_rate = 2

var is_area_light = 0
var burn_health = 15
var shadow_health = 25

var input = Vector2.ZERO

var pick = false
var axe = false

func _ready():
	inv = Inv.new()
	
	inv.slots = []
	for i in inventory_size:
		inv.slots.append(InvSlot.new())
	
	var invnode = preload("res://inventory/inv_ui.tscn").instantiate()
	invnode.position.x = -34
	invnode.position.y = -82
	
	add_child(invnode)
	
	bodies.append(self)
	if current_body == null:
		current_body = self
		Globals.set("player",self)
		set_collision_layer(3)
		$Camera2D.make_current()
		durability.visible = true
		shadow.visible = true
	burn_health = max_burn_health
	shadow_health = max_shadow_health
	durability.max_value = max_burn_health
	durability.value = burn_health
	shadow.max_value = max_shadow_health
	shadow.value = max_shadow_health-shadow_health

func _physics_process(delta):
	if is_area_light > 0:
		burn_shadow(delta)
	else:
		shadow_darken(delta)
	if current_body == self:
		if Input.is_action_just_pressed("swap_body") && !swapping:
			swapping = true
			if !swap_body():
				Globals.get("player").add_comment("need more bodies to swap")
			return
		if Input.is_action_just_released("swap_body"):
			swapping = false
		if Input.is_action_just_pressed("open_inventory"):
			$Inv_ui.open_input()
		player_movement(delta)
		shadow_vision()

	#print("health " + str(burn_health) + " shadow " + str(shadow_health))

func swap_body(): # TODO polish camera swap
	if bodies.size() < 2:
		return false
	if current_body == self:
		#set next body as body
		var curr_id = bodies.find(self)
		current_body = bodies[(curr_id+1) % bodies.size()]
		
		#move interactions
		current_body.set_collision_layer(3)
		set_collision_layer(1)
		
		#close inventory
		$Inv_ui.close()
		durability.visible = false
		shadow.visible = false
		current_body.durability.visible = true
		current_body.shadow.visible = true
		
		
		#update global pointer to new body
		Globals.set("player",current_body)
		
		#make shadow vision invisable
		$PointLight2D.color.a = 0
		#stop body movement
		velocity = Vector2.ZERO
		#transition camera
		CameraTransition.transition_camera2D($Camera2D,current_body.get_node("Camera2D"))
	return true

func shadow_vision():
	$PointLight2D.color.a = min((1 - (shadow_health/max_shadow_health)),1)

func burn_shadow(delta):
	if shadow_health < max_shadow_health:
		burn_health -= delta / burn_rate
		durability.value = burn_health
		shadow_health += delta
		shadow.value = max_shadow_health-shadow_health
	if burn_health <= 0:
		lose_body()

func shadow_darken(delta):
	shadow_health -= delta
	shadow.value = max_shadow_health-shadow_health
	if shadow_health <= 0:
		lose_body()

func lose_body():
	inv.drop_all(self,global_position.x,global_position.y,24)
	if swap_body():
		bodies.erase(self)
		self.queue_free()
		return
	game_over()

func game_over():
	get_tree().quit()
	pass

func get_input():
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return input.normalized()

func play_animation(animation : String):
	head.play(animation)
	arms.play(animation)
	torso.play(animation)
	legs.play(animation)

func player_movement(delta):
	input = get_input()
	
	if input == Vector2.ZERO:
		play_animation("idle")
		if velocity.length()> (friction*delta):
			velocity -= velocity.normalized()*(friction*delta)	#stopping or decelerating
		else:
			velocity = Vector2.ZERO		#full stop
	else:
		velocity+=(input*accel*delta)	#speed up
		velocity = velocity.limit_length(max_speed)	#limit speed
		
		if velocity.x > velocity.y:
			if velocity.x > -velocity.y:
				play_animation("right")
			else:
				play_animation("up")
		else:
			if velocity.x > -velocity.y:
				play_animation("down")
			else:
				play_animation("left")
	
	move_and_slide()

func collect(item):
	inv.insert(item)

func has_item(item):
	return inv.has_item(item)

func remove_item(item):
	inv.remove_item(item)

func entered_light_area():
	is_area_light += 1

func exit_light_area():
	is_area_light -= 1

func add_pick():
	pick = true

func has_pick():
	return pick

func add_axe():
	axe = true

func has_axe():
	return axe

func player():
	pass

func add_comment(text:String):
	var new_comment:Label = comment.instantiate()
	new_comment.text = text
	new_comment.set_anchors_preset(7)
	new_comment.position.x = -(new_comment.size.x/2)
	new_comment.position.y = -36 - new_comment.size.y
	add_child(new_comment)
