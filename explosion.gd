extends Area2D

func _ready() -> void:
	$CollisionShape2D.disabled = true

func _process(delta: float) -> void:
	if $AnimatedSprite2D.frame >= 1:
		$CollisionShape2D.set_deferred("disabled",false)
	if $AnimatedSprite2D.frame >= 5:
		queue_free()
