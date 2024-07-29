extends Node2D

@export var spawn_radius_start = 0
@export var spawn_radius_end = 10
@export var spawn_angle_start = 0
@export var spawn_angle_end = 2*PI
@export var branch_from = 0
@export var branch_to = 1
@export var tree_from = 0
@export var tree_to = 1
@export var forest_from = 0
@export var forest_to = 0
@export var pebble_from = 0
@export var pebble_to = 1
@export var boulder_from = 0
@export var boulder_to = 1

var branch_radius = 8
var tree_radius = 16
var forest_radius = 64
var pebble_radius = 8
var boulder_radius = 16

var branch = preload("res://scenes/objects/branch_collectable.tscn")
var tree = preload("res://scenes/objects/dead_tree.tscn")
var pebble = preload("res://scenes/objects/pebble_collectable.tscn")
var boulder = preload("res://scenes/objects/boulder.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	_spawn_resource(branch, branch_radius, branch_from, branch_to)
	_spawn_resource(tree, tree_radius, tree_from, tree_to)
	_spawn_resource(branch, forest_radius, forest_from, forest_to)
	_spawn_resource(pebble, pebble_radius, pebble_from, pebble_to)
	_spawn_resource(boulder, boulder_radius, boulder_from, boulder_to)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _spawn_resource(resource, resource_radius, from_percent, to_percent):
	var full_resource = PI*((spawn_radius_end ** 2 - spawn_radius_start ** 2) / resource_radius ** 2)
	var resource_count = randi_range(from_percent, to_percent) * full_resource
	for i in range(0,resource_count):
		var angle = randi_range(spawn_angle_start, spawn_angle_end)
		var dist = randi_range(spawn_radius_start, spawn_radius_end)
		var resource_instance = resource.instantiate()
		resource_instance.global_position.x = dist * cos(angle)
		resource_instance.global_position.y = dist * sin(angle)
		add_child(resource_instance)
