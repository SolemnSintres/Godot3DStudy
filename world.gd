extends Node3D

const TREE = preload("res://tree.tscn")
var found = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	while(found < 30):
		var x = randf_range(-40,40)
		var y = randf_range(-40,40)
		if abs(x) < 8.0 and abs(y) < 6.0:
			continue
		var tree = TREE.instantiate()
		tree.position = Vector3(x,0,y)
		add_child(tree)
		found += 1
