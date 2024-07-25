extends TileMap

@onready var player = get_tree().get_first_node_in_group("player")


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(-100,100):
		for j in range (-100,100):
			set_cell(0,Vector2i(i,j),0,Vector2i(randi_range(0,15),0),0)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
