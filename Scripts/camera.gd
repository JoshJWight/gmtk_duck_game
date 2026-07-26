extends Camera2D

const NORMAL_ZOOM := Vector2(1.0, 1.0)
const MAP_ZOOM := Vector2(0.33, 0.33)

func _process(delta: float) -> void:
	var target_zoom := MAP_ZOOM if Input.is_action_pressed("zoom_out") else NORMAL_ZOOM

	zoom = zoom.lerp(
		target_zoom,
		1.0 - exp(-8.0 * delta)
	)
