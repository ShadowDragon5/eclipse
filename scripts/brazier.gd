extends StaticBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var burn_time: Timer = $Timer

@export var accaptable_fuel: InvItem

var fuel_time = 30

func _ready():
	interaction_area.interact = Callable(self,"_add_fuel")
	burn_time.start()

func _process(delta):
	var left_time_ratio = sqrt(burn_time.get_time_left())
	var aspect_ratio = 0.5

	$PointLight2D.scale.x = left_time_ratio / 2
	$PointLight2D.scale.y = $PointLight2D.scale.x * aspect_ratio

	$LightArea.scale = $PointLight2D.scale * 2


func _add_fuel():
	if Globals.get("player").has_item(accaptable_fuel):
		burn_time.start(burn_time.get_time_left() + fuel_time)
		Globals.get("player").remove_item(accaptable_fuel)
	else:
		Globals.get("player").add_comment("no fuel in inventory")
	print(burn_time.get_time_left())

func _on_timer_timeout():
	print("Game Over")

func _on_light_area_body_entered(body):
	if body.has_method("player"):
		body.entered_light_area()

func _on_light_area_body_exited(body):
	if body.has_method("player"):
		body.exit_light_area()
