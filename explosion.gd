extends Area2D

func _ready() -> void:
	$CollisionShape2D.disabled = true

func _process(delta: float) -> void:
	if $AnimatedSprite2D.frame >= 1:
		$CollisionShape2D.set_deferred("disabled",false)
	if $AnimatedSprite2D.frame >= 4:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("destructable"):
		body.queue_free()
