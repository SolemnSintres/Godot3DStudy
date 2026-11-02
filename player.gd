extends CharacterBody3D

const gravity = 9.8
const SPEED = 4.0
const MOUSE_SENSITIVITY = 0.002

@onready var head = $CollisionShape3D/Head
@onready var flash = $CollisionShape3D/Head/Flashlight 
@onready var footstep = $AudioStreamPlayer3D
@onready var sight = $CollisionShape3D/Head/RayCast3D


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	flash.visible = false

func _physics_process(delta):
	
	if !(is_on_floor()):
		velocity.y -= gravity * delta
	var moveit = Input.get_vector("move_left","move_right","move_forward","move_back")
	var direction = transform.basis * Vector3(moveit.x,0,moveit.y)
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	
	move_and_slide()
	
	var speed = Vector2(velocity.x,velocity.y).length()
	
	if is_on_floor() and speed > 0.1 and speed < 5:
		if not footstep.playing:
			footstep.volume_db = randf_range(-6.0,0.0)
			footstep.play()

func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(MOUSE_SENSITIVITY * -event.relative.x * 0.5)
		head.rotate_x(MOUSE_SENSITIVITY * -event.relative.y * 0.5)
		head.rotation.x = clamp(head.rotation.x,deg_to_rad(-85),deg_to_rad(85))
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event.is_action_pressed("flashlight"):
		flash.visible = not flash.visible
	
	if event.is_action_pressed("interact"):
		var inter = sight.get_collider()
		if sight.is_colliding():
			var insight = inter.get_parent()
			if insight.has_method("toggle"):
				insight.toggle()
