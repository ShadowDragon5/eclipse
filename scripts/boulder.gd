extends StaticBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("player")

@export var item: InvItem

var pebble = preload("res://scenes/objects/pebble_collectable.tscn")

var durability: int

# Called when the node enters the scene tree for the first time.
func _ready():
	durability = randi_range(3,7)
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	if player.has_pick():
		if durability > 0:
			drop_pebble()
			durability -= 1
		else:
			for i in range(0,randi_range(3,6)):
				drop_pebble()
			self.queue_free()
	else:
		print("pickaxe needed")

func drop_pebble():
	var ang = randi_range(0, 2 * PI)
	var dist = randi_range(24,48)
	var pebble_instance = pebble.instantiate()
	pebble_instance.global_position.x = self.global_position.x + dist * cos(ang)
	pebble_instance.global_position.y = self.global_position.y + dist * sin(ang)
	get_parent().add_child(pebble_instance)
