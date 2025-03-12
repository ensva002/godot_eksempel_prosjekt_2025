extends RigidBody2D


func _on_coin_coin_picked_up() -> void:
	queue_free()
