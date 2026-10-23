extends SpotLight3D


@onready var light = $CollisionShape3D/Head/Flashlight

func _ready():
	light.visible = false
