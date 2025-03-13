extends RigidBody2D

var explosion = preload("res://explosion.tscn")
var blown

func _process(delta: float) -> void:
	if $Timer.time_left <= 0.3 && !blown:
		$Sprite.region_rect.position.y = 1284
		$CollisionShape2D.set_deferred("disabled",true)
		sleeping = true
		gravity_scale = 0
		var expInsta = explosion.instantiate()
		expInsta.global_position = global_position
		get_tree().current_scene.add_child(expInsta)
		blown = true
	
func _on_timer_timeout() -> void:
	queue_free()
