extends Node2D

@onready var floor_layer = $Floor
@onready var entities_layer = $Entities

var transitions = {}

func _ready():
	Global.current_map = self
	call_deferred("add_child", Global.player)
	Global.can_transition = true

func transition(coords):
	Global.player.position = map_to_local(transitions[coords][1])
	get_tree().change_scene_to_file(transitions[coords][0])

func local_to_map(vector2):
	return floor_layer.local_to_map(vector2)

func map_to_local(vector2i):
	return floor_layer.map_to_local(vector2i)
