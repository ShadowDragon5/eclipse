extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("player")

@export var item: InvItem


func _ready():
	$AnimatedSprite2D.animation = "pebble" + str(randi_range(0,5))
	interaction_area.interact = Callable(self, "_collect")

func _collect():
		playerCollect()
		await get_tree().create_timer(0.1).timeout
		self.queue_free()

func playerCollect():
	player.collect(item)
