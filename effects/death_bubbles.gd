extends GPUParticles2D

func _on_erase_timer_timeout():
	queue_free()
