extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea

@export var item: InvItem


func _ready():
	$AnimatedSprite2D.set_frame(randi_range(0,5))
	interaction_area.interact = Callable(self, "_collect")

func _collect():
		playerCollect()
		await get_tree().create_timer(0.1).timeout
		self.queue_free()

func playerCollect():
	Globals.get("player").collect(item)
