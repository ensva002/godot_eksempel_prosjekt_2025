extends CharacterBody2D

var SPEED = 100
var dir = -1
signal player_hurt
var coins = 0
var indestructable
var damaged
var dropCoin = preload("res://coin_physics.tscn")

func _physics_process(delta: float) -> void:
	
	velocity.x = SPEED * dir
	
	move_and_slide()
	
	if velocity.x == 0:
		dir = dir * -1
		$Sprite2D.flip_h = !$Sprite2D.flip_h
		
	if damaged && !indestructable:
		var n = 0
		for i in range(coins):
			var instance = dropCoin.instantiate()
			instance.global_position = Vector2(global_position.x+n, global_position.y+abs(n))
			get_tree().current_scene.add_child(instance)
			n += 1
			n *= -1
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		emit_signal("player_hurt")
	
		
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("coins"):
		area.queue_free()
		coins += 1
		
	if area.is_in_group("damage"):
		damaged = true

func _on_area_2d_body_exited(body: Node2D) -> void:
		if body.is_in_group("damage"):
			damaged = false

func _on_inwall_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		$Sprite2D.modulate = Color(1,1,1,0.33)
		indestructable = true


func _on_inwall_body_exited(body: Node2D) -> void:
	if body is TileMapLayer:
		$Sprite2D.modulate = Color(1,1,1,0.8)
		indestructable = false
