extends Node

func _input(event):
	if event.is_action_pressed("action"):
		Global.player.position = Vector2(200, 200)
		get_tree().change_scene_to_file("res://maps/map01.tscn")
