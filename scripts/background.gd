extends TileMap

@onready var player = get_tree().get_first_node_in_group("player")

func _ready():
	for i in range(-100,100):
		for j in range (-100,100):
			if get_cell_source_id(0,Vector2i(i,j),false):
				set_cell(0,Vector2i(i,j),0,Vector2i((((i % 4)+4)%4) + ((((j % 4)+4)%4) * 4),0),0)
				#set_cell(0,Vector2i(i,j),0,Vector2i(randi_range(0,15),0),0)


func _process(delta):
	pass
