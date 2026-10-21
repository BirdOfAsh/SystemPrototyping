extends CharacterBody3D

@export_category("Tweakable values")
@export var speed : float = 5.0
@export var mouse_sensitivity : float = 0.003
## Value used in delta-adjusted calculations
@export var acceleration: float = 10.0


@onready var dynamic_depth_of_field_camera: DyamicDepthOfFieldCamera = %DynamicDepthOfFieldCamera as DyamicDepthOfFieldCamera
@onready var head: Node3D = %Head as Node3D

const JUMP_VELOCITY = 4.5


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()


## Head rotation for first-person controls
func _input(event: InputEvent) -> void:
	# Rotate head
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		head.rotate_x(-event.relative.y * mouse_sensitivity)
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))
