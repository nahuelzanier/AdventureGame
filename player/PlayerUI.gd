extends CanvasLayer

@onready var heart_containers = [
	$GridContainer/HeartUI1,
	$GridContainer/HeartUI2,
	$GridContainer/HeartUI3,
	$GridContainer/HeartUI4,
	$GridContainer/HeartUI5,
	$GridContainer/HeartUI6
]

func update_ui_hearts(player_life):
	var count = 0
	for heart in heart_containers:
		count += 2
		if count <= player_life:
			heart.fill_heart()
		elif count == player_life + 1:
			heart.fill_half()
		elif count > player_life:
			heart.empty_heart()
