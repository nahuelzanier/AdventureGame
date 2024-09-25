extends CanvasLayer

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://game/main.tscn")
