extends Area2D

@export var levelIdx: int

const levels = [
	"res://Levels/Level1.tscn",
	"res://Levels/Level2.tscn",
	"res://Levels/Level3.tscn",
	"res://Levels/Level4.tscn",
	"res://end_screen.tscn",
]

@onready var duckling_sprites := $Ducklings.get_children()

var player_in_range: CharacterBody2D = null

var nDucklings = 0

func collectDuckling() -> void:
	nDucklings += 1
	for i in duckling_sprites.size():
		duckling_sprites[i].visible = i < nDucklings
		
	if nDucklings == 5:
		$StatusLabel.text = "Ready to go!"
	else:
		$StatusLabel.text = "Missing ducklings: " + str(5 - nDucklings)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_in_range = body

func _on_body_exited(body: Node2D) -> void:
	if body == player_in_range:
		player_in_range = null

func _process(_delta: float) -> void:
	if player_in_range != null and nDucklings == 5:
		get_tree().change_scene_to_file(levels[levelIdx + 1])
