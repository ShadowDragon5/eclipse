extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
var max_branches = 6
var branches_dropped = 0


func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	if branches_dropped<max_branches:
		$branch_fall_timer.start()

func _process(delta):
	pass

func _on_branch_fall_timer_timeout():
	pass								#spawn dropable branch

func _on_interact():
	self.visible = false
