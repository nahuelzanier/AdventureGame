extends "res://maps/_map.gd"

func _ready():
	super()
	transitions[Vector2i(17, -4)] = ["res://maps/map01.tscn", Vector2i(21, 14)]
	transitions[Vector2i(18, -4)] = ["res://maps/map01.tscn", Vector2i(22, 14)]
