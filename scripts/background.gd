extends TileMap

@onready var player = get_tree().get_first_node_in_group("player")

@export var noise_height_map : NoiseTexture2D

# Called when the node enters the scene tree for the first time.
func _ready():
	#noise_height_map.noise().set_seed.(randi_range(0,100))
	for i in range(-100,100):
		for j in range (-100,100):
			if get_cell_source_id(0,Vector2i(i,j),false):
				set_cell(0,Vector2i(i,j),0,Vector2i((((i % 4)+4)%4) + ((((j % 4)+4)%4) * 4),0),0)
				#set_cell(0,Vector2i(i,j),0,Vector2i(randi_range(0,15),0),0)





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
