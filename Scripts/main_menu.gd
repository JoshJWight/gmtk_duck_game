extends Control

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/Level1.tscn")

func _on_level_select() -> void:
	$Level1.visible = true
	$Level2.visible = true
	$Level3.visible = true
	$Level4.visible = true
	$Level5.visible = true

func _goto_level_1() -> void:
	get_tree().change_scene_to_file("res://Levels/Level1.tscn")
	
func _goto_level_2() -> void:
	get_tree().change_scene_to_file("res://Levels/Level2.tscn")
	
func _goto_level_3() -> void:
	get_tree().change_scene_to_file("res://Levels/Level3.tscn")
	
func _goto_level_4() -> void:
	get_tree().change_scene_to_file("res://Levels/Level4.tscn")
	
func _goto_level_5() -> void:
	get_tree().change_scene_to_file("res://Levels/Level5.tscn")
