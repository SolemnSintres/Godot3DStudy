extends Node3D

const TREE = preload("res://tree.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(10):
		var tree = TREE.instantiate()
		add_child(tree)
		tree.position = Vector3(i * 10,0,90)
