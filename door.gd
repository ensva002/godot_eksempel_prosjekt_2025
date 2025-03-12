@tool
extends Area2D
@export var target: int = 0

func _ready() -> void:
	$Front/Target.text = str(target)
	ScoreManager.connect("score_updated", Callable(self, "on_score_updated"))
	$CollisionShape2D.disabled = true
	
	 
func on_score_updated(new_score: int) -> void:
	if new_score >= target:
		$CollisionShape2D.set_deferred("disabled", false)
		$Front.visible = false
		$Clopen.region_rect.position.y = 1078

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		$Front/Target.text = str(target)


func _on_body_entered(body: Node2D) -> void:
	$Label.visible = true


func _on_body_exited(body: Node2D) -> void:
	$Label.visible = false
