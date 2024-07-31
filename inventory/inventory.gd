extends Resource

class_name  Inv

signal update

@export var slots: Array[InvSlot]

var branch = preload("res://scenes/objects/branch_collectable.tscn")
var pebble = preload("res://scenes/objects/pebble_collectable.tscn")
var head = preload("res://scenes/head_collectable.tscn")
var arms = preload("res://scenes/arms_collectable.tscn")
var torso = preload("res://scenes/body_collectable.tscn")
var legs = preload("res://scenes/legs_collectable.tscn")


func insert(item:InvItem):
	var itemslots = slots.filter(func(slot):return slot.item == item)
	if !itemslots.is_empty():
		itemslots[0].amount += 1
	else:
		var emptyslots = slots.filter(func(slot): return slot.item == null)
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].amount = 1
	update.emit()

func has_item(item: InvItem):
	var itemslots = slots.filter(func(slot):return slot.item == item)
	return !itemslots.is_empty()

func remove_item(item: InvItem):
	var itemslots = slots.filter(func(slot):return slot.item == item)
	if !itemslots.is_empty():
		itemslots[0].amount -= 1
		if itemslots[0].amount == 0:
			itemslots[0].item = null
	update.emit()

func drop_all(body: CharacterBody2D, x, y, radius):
	var nonemptyslots = slots.filter(func(slot): return slot.item != null)
	for slot: InvSlot in nonemptyslots:
		for i in slot.amount:
			var ang = randi_range(0, 2 * PI)
			var dist = randi_range(0,radius)
			drop_item(body,slot.item.name,x+dist*cos(ang),y+dist*sin(ang))
		slot.amount = 0
		slot.item = null

func drop_item(body,item:String, x, y):
	var resource_instance
	match item:
		"wood":
			resource_instance = branch.instantiate()
		"rock":
			resource_instance = pebble.instantiate()
		"head":
			resource_instance = head.instantiate()
		"arms":
			resource_instance = arms.instantiate()
		"body":
			resource_instance = torso.instantiate()
		"legs":
			resource_instance = legs.instantiate()

	if resource_instance == null:
		return
	resource_instance.global_position.x = x
	resource_instance.global_position.y = y
	body.get_parent().add_child(resource_instance)
