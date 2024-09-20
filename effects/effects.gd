extends Node

const DEATH_BUBBLES = preload("res://effects/death_bubbles.tscn")

func create_effect_at(effect_preload, pos):
	var effect = effect_preload.instantiate()
	effect.position = pos
	Global.current_map.add_child(effect)
	effect.emitting = true
