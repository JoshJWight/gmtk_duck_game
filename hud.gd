extends CanvasLayer

@onready var down_icons := $DownMeter.get_children()

func setCurrentDown(val: int) -> void:
	$DownLabel.text = "Down: " + str(val)
	for i in down_icons.size():
		down_icons[i].visible = i < val
