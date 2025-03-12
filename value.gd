extends Label

func _ready() -> void:
	ScoreManager.connect("score_updated", Callable(self, "on_score_updated"))
	
func on_score_updated(new_score: int) -> void:
	text=str(new_score)
