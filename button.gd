extends Area2D

var pressed
signal button_pressed

func _on_body_entered(body: Node2D) -> void:
	if !pressed:
		$Sprite2D.region_rect = Rect2(128,896,128,128)
		emit_signal("button_pressed")
		pressed = true
