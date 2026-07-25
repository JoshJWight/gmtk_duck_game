extends CanvasLayer

@export var downImg: Texture2D
@export var drainedDownImg: Texture2D

@onready var down_icons := $DownMeter.get_children()

func setCurrentDown(val: int) -> void:
	for i in down_icons.size():
		if i < val:
			down_icons[i].texture = downImg
		else:
			down_icons[i].texture = drainedDownImg

func setMaxDown(val: int) -> void:
	$DownLabel.text = "Down: " + str(val)
	for i in down_icons.size():
		down_icons[i].visible = i < val
