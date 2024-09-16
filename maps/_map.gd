extends TileMap

var transitions = {}

func _ready():
	Global.current_map = self
	call_deferred("add_child", Global.player)
	Global.can_transition = true

func transition(coords):
	Global.player.position = map_to_local(transitions[coords][1])
	get_tree().change_scene_to_file(transitions[coords][0])
