class_name FirstPersonEntityController extends CharacterBody3D

@export_category("Tweakable values")
@export var speed : float = 5.0
@export var mouse_sensitivity : float = 0.003
## Value used in delta-adjusted calculations
@export var acceleration: float = 10.0

@export_category("Disable toggles")
@export var look_enabled : bool = true
@export var movement_enabled : bool = true
@export var interaction_enabled : bool = true

## Rotation helper to make head rotation not break :)
@onready var head: Node3D = %Head
var physics_enabled : bool = true


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


## Head rotation for first-person controls
func _input(event: InputEvent) -> void:
	if !look_enabled:
		return
	
	# rotate head
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		head.rotate_x(-event.relative.y * mouse_sensitivity)
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))
