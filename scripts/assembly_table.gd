extends StaticBody2D

@onready var player_obj = preload("res://scenes/objects/player.tscn")

@export var head_item: InvItem
@export var arms_item: InvItem
@export var body_item: InvItem
@export var legs_item: InvItem

# Called when the node enters the scene tree for the first time.
func _ready():
	$InteractionArea.interact = Callable(self, "_on_interact")


func _on_interact():
	var player = Globals.get("player")
	if player.has_item(head_item) && player.has_item(arms_item) && player.has_item(body_item) && player.has_item(legs_item):
		player.remove_item(head_item)
		player.remove_item(arms_item)
		player.remove_item(body_item)
		player.remove_item(legs_item)
		var new_body = player_obj.instantiate()
		new_body.position = position
		get_parent().add_child(new_body)
	else:
		print("missing materials")
