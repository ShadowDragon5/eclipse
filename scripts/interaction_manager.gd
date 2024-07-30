extends Node2D


@onready var label = $Label


const base_text = "[E] to "

var active_areas = []
var can_interact = true

func register_area(area: InteractionArea):
	if area.action_name == "chop" && !Globals.get("player").axe:
		return
	if area.action_name == "break" && !Globals.get("player").pick:
		return
	active_areas.push_back(area)

func unregister_area(area: InteractionArea):
	active_areas.erase(area)

func _process(delta):
	if active_areas.size() > 0 && can_interact:
		active_areas.sort_custom(_sort_by_distance_to_player)
		label.text = base_text + active_areas[0].action_name
		label.global_position = active_areas[0].global_position
		label.global_position.y -= 36
		label.global_position.x -= label.size.x/2
		label.show()
	else:
		label.hide()

func _sort_by_distance_to_player(area1, area2):
	var area1_to_palyer = Globals.get("player").global_position.distance_to(area1.global_position)
	var area2_to_palyer = Globals.get("player").global_position.distance_to(area2.global_position)
	return area1_to_palyer < area2_to_palyer

func _input(event):
	if event.is_action_pressed("interact") && can_interact:
		if active_areas.size() > 0:
			can_interact = false
			label.hide()
			
			await active_areas[0].interact.call()
			can_interact = true
