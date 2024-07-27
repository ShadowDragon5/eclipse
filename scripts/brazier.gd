extends StaticBody2D


@onready var interaction_area: InteractionArea = $InteractionArea
@onready var burn_time: Timer = $Timer

var fuel_time = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self,"_add_fuel")
	burn_time.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#print(delta)

func _add_fuel():
	burn_time.start(burn_time.get_time_left() + fuel_time)

func _on_timer_timeout():
	print ("Game Over")
