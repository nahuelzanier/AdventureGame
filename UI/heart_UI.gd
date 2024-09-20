extends Control

const HEART_EMPTY = preload("res://assets/UI/heart_empty.png")
const HEART_HALF = preload("res://assets/UI/heart_half.png")
const HEART_FULL = preload("res://assets/UI/heart_full.png")

@onready var texture_rect = $TextureRect

func fill_heart():
	texture_rect.texture = HEART_FULL

func fill_half():
	texture_rect.texture = HEART_HALF

func empty_heart():
	texture_rect.texture = HEART_EMPTY
