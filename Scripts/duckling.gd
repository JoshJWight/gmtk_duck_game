extends Area2D

var player_in_range: CharacterBody2D = null

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_in_range = body

func _on_body_exited(body: Node2D) -> void:
	if body == player_in_range:
		player_in_range = null

func _process(_delta: float) -> void:
	if player_in_range != null \
			and Input.is_action_just_pressed("interact"):
		collect(player_in_range)

func collect(player: CharacterBody2D) -> void:
	player.collectDuckling()
	$CollisionShape2D.set_deferred("disabled", true)
	$PeepSound.play()
	await $PeepSound.finished
	queue_free()
