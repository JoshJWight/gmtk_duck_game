extends CanvasLayer

@export var downImg: Texture2D
@export var drainedDownImg: Texture2D

@onready var down_icons := $DownMeter.get_children()

@onready var music: AudioStreamPlayer = $Music

func _ready() -> void:
	var length := music.stream.get_length()
	var start_position := randf_range(0.0, length * 0.8)
	music.play(start_position)

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
