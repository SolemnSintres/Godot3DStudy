extends Node3D

var isopen = false


func toggle():
	var tween = create_tween()
	if not isopen:
		tween.tween_property(self, "rotation_degrees:y", 90, 0.5)
	elif isopen:
		tween.tween_property(self, "rotation_degrees:y", 0, 0.5)
	isopen = not isopen
