extends Area2D

@export var text: String
@export var time: float
@export var hasDownThreshold: bool = false
@export var downThreshold: int


var player_in_range: CharacterBody2D = null

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_in_range = body
		if hasDownThreshold and player_in_range.max_down > downThreshold:
			return
		player_in_range.haveThoughtBubble(text.replace("|", "\n"), time)
		queue_free()
