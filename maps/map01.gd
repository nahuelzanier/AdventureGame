extends "res://maps/_map.gd"

func _ready():
	super()
	transitions[Vector2i(21, 15)] = ["res://maps/map02.tscn", Vector2i(17, -3)]
	transitions[Vector2i(22, 15)] = ["res://maps/map02.tscn", Vector2i(18, -3)]
