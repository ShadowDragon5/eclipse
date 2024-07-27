extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea

@export var item: InvItem
@export var max_branches = 6
var branches_dropped = 0

var branch = preload("res://scenes/objects/branch_collectable.tscn")


func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	if branches_dropped < max_branches:
		$branch_fall_timer.start()

func _process(delta):
	pass

func _on_branch_fall_timer_timeout():
	drop_branch()

func _on_interact():
	self.visible = false

func drop_branch():
	branches_dropped += 1
	var branch_instance = branch.instantiate()
	branch_instance.global_position = $Marker2D.global_position
	get_parent().add_child(branch_instance)
	
	await  get_tree().create_timer(3).timeout
	
	if branches_dropped < max_branches:
		$branch_fall_timer.start()
	
