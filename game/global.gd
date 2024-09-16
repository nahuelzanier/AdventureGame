extends Node

const PLAYER = preload("res://player/player.tscn")

var can_transition = true
var current_map = null
var player = PLAYER.instantiate()

func transition(coord_pos):
	if can_transition:
		can_transition = false
		current_map.remove_child(player)
		current_map.transition(current_map.local_to_map(coord_pos))
