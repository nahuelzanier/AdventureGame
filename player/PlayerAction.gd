extends Node2D

var current_item

var action_available = true

signal using_item_start
signal using_item_end

func _ready():
	current_item = $Club
	current_item.player_action_node = self

func use_item(direction):
	if action_available:
		current_item.activate(direction)

func action_start():
	action_available = false
	emit_signal("using_item_start")

func action_end():
	action_available = true
	emit_signal("using_item_end")
