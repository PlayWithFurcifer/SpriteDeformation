extends Node2D

onready var sprite = $Furcifer
onready var tween = $Tween
var duration = 0.2
var max_click_distance = 1000.0

func _unhandled_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		var direction = sprite.global_position - get_global_mouse_position()
		deform(direction)

func deform(direction):
	var deformationStrength = clamp(max_click_distance - direction.length(), 0, max_click_distance) / max_click_distance
	var deformationDirection = direction.normalized()
	var deformationScale = 0.5 * deformationDirection * deformationStrength
	
	tween.stop_all()
	tween.interpolate_property(sprite.material, "shader_param/deformation",
		null, deformationScale, duration, Tween.TRANS_CUBIC)
	tween.interpolate_property(sprite.material, "shader_param/deformation",
		deformationScale, Vector2.ZERO, 1.0, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, duration)
	tween.start()
