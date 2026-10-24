class_name RayPhysObj3D extends RayCast3D


@warning_ignore("unused_signal")
signal request_pick_up

# The currently stored [PhysicsObject3D]
var colliding_phys_obj : PhysicsObject3D = null


func _physics_process(_delta: float) -> void:
	check_for_phys_obj()


func check_for_phys_obj() -> void:
	# Get reference to current collision (or null)
	var new_phys_collision : PhysicsObject3D = get_collider() as PhysicsObject3D
	
	# If the new collision and the stored object are the same, no need to update
	if new_phys_collision == colliding_phys_obj: return
	
	# If no longer colliding with object, emit ray_exited on it
	if new_phys_collision == null: colliding_phys_obj.ray_exited.emit(self)
	
	# Set the new phys object, either clearing it or store a new one
	colliding_phys_obj = new_phys_collision
	
	# If colliding with new object, emit ray_entered on it
	if colliding_phys_obj != null: colliding_phys_obj.ray_entered.emit(self)
	
	print(colliding_phys_obj)
