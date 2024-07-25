extends StaticBody2D


@onready var interaction_area: InteractionArea = $InteractionArea
@onready var burn_time: Timer = $Timer

@export var fuel_left = 3


# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self,"_add_fuel")
	burn_time.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#print(delta)

func _add_fuel():
	burn_time.set_wait_time(burn_time.get_wait_time()+30)


func _on_timer_timeout():
	print ("Game Over")
