@tool
extends Area2D
## amount of coins needed to open door
@export var target: int = 0
## level index or name, leave empty to load next level
@export var destination: String

func _ready() -> void:
	$Front/Target.text = str(target)
	ScoreManager.connect("score_updated", Callable(self, "on_score_updated"))
	$CollisionShape2D.disabled = true
	
	 
func on_score_updated(new_score: int) -> void:
	$Front/Target.text = str(target - new_score)
	if new_score >= target:
		$CollisionShape2D.set_deferred("disabled", false)
		$Front.visible = false
		$Clopen.region_rect.position.y = 1078

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		$Front/Target.text = str(target)
	if Input.is_action_just_pressed("ui_up"):
		if destination.is_empty():
			LevelManager.load_next_level()
		else:
			if destination.is_valid_int():
				LevelManager.load_level(int(destination))
			else:
				LevelManager.load_level(destination)
			


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$Label.visible = true
		

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		$Label.visible = false
	
