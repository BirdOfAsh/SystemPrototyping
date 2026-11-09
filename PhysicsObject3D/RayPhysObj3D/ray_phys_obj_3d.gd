class_name RayPhysObj3D extends RayCast3D

@onready var physics_picking_system: PhysicsPickingSystem = %PhysicsPickingSystem as PhysicsPickingSystem

@export var max_ray_length : int = 2
@export var min_ray_length : int = 1



func _physics_process(_delta: float) -> void:
	if is_colliding(): update_ray_endpoint_position(get_collision_point())
	elif !is_colliding() and target_position.z != -max_ray_length: target_position.z = -max_ray_length


func update_ray_endpoint_position(collision_position : Vector3) -> void:
	var new_target_position : Vector3 = Vector3(0, 0, clampf(to_local(collision_position).z, -max_ray_length, -min_ray_length)) 
	target_position = new_target_position

	
	physics_picking_system.global_position = to_global(target_position)
