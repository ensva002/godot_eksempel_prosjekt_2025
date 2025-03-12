extends RigidBody2D

func _process(delta: float) -> void:
	if $Timer.time_left <= 0.3:
		$Sprite.region_rect.position.y = 1284
	
func _on_timer_timeout() -> void:
	queue_free()
