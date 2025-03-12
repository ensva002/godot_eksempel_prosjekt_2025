extends Node

signal score_updated(new_score)
var score: int = 0

func add_score(amount: int) -> void:
	score += amount
	emit_signal("score_updated",score)
