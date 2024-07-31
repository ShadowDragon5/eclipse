extends Node2D

@export var head_item: InvItem
@export var arms_item: InvItem
@export var body_item: InvItem
@export var legs_item: InvItem
@export var wood_item: InvItem
@export var rock_item: InvItem

var wood_count = 0
var rock_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$InteractionAreaHead.interact = Callable(self, "_on_interact1")
	$InteractionAreaArms.interact = Callable(self, "_on_interact2")
	$InteractionAreaBody.interact = Callable(self, "_on_interact3")
	$InteractionAreaLegs.interact = Callable(self, "_on_interact4")
	$InteractionAreaAxe.interact = Callable(self, "_on_interact5")
	$InteractionAreaPick.interact = Callable(self, "_on_interact6")
	$InteractionAreaWood.interact = Callable(self, "_on_interact7")
	$InteractionAreaRock.interact = Callable(self, "_on_interact8")


func _on_interact1():
	if Globals.get("player").has_item(head_item):
		print("You can only carry one extra head")
		return
	
	if wood_count >= 0 && rock_count >= 3:
		Globals.get("player").collect(head_item)
		wood_count -= 0
		rock_count -= 3
	else:
		print("missing materials")

func _on_interact2():
	if Globals.get("player").has_item(arms_item):
		print("You can only carry one extra set of arms")
		return
	
	if wood_count >= 0 && rock_count >= 2:
		Globals.get("player").collect(arms_item)
		wood_count -= 0
		rock_count -= 2
	else:
		print("missing materials")

func _on_interact3():
	if Globals.get("player").has_item(body_item):
		print("You can only carry one extra torso")
		return
	
	if wood_count >= 0 && rock_count >= 4:
		Globals.get("player").collect(body_item)
		wood_count -= 0
		rock_count -= 4
	else:
		print("missing materials")

func _on_interact4():
	if Globals.get("player").has_item(legs_item):
		print("You can only carry one extra set of legs")
		return
	
	if wood_count >= 0 && rock_count >= 2:
		Globals.get("player").collect(legs_item)
		wood_count -= 0
		rock_count -= 2
	else:
		print("missing materials")

func _on_interact5():
	if Globals.get("player").has_axe():
		print("You can only have one axe")
		return
	
	if wood_count >= 1 && rock_count >= 2:
		Globals.get("player").add_axe()
		wood_count -= 1
		rock_count -= 2
	else:
		print("missing materials")

func _on_interact6():
	if Globals.get("player").has_pick():
		print("You can only have one pick")
		return
	
	if wood_count >= 1 && rock_count >= 2:
		Globals.get("player").add_pick()
		wood_count -= 1
		rock_count -= 2
	else:
		print("missing materials")

func _on_interact7():
	if Globals.get("player").has_item(wood_item):
		Globals.get("player").remove_item(wood_item)
		wood_count += 1
	else:
		print("no wood added")

func _on_interact8():
	if Globals.get("player").has_item(rock_item):
		Globals.get("player").remove_item(rock_item)
		rock_count += 1
	else:
		print("no rock added")
