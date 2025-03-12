extends Area2D

func _on_body_entered(body: Node2D) -> void:
	#Her ville det nok gitt mer mening å sjekke Group, dette er bare for å vise hvordan vi kan bruke Layers
	if body.collision_layer == 1:
		ScoreManager.add_score(1)
		queue_free()
