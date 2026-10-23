class_name RayPhysObj3D extends RayCast3D


signal request_pick_up


func _physics_process(_delta: float) -> void:
	check_for_phys_obj()


func check_for_phys_obj() -> void:
	# Return if not colliding with a PhysicsObject3D
	if !(self.is_colliding() and get_collider() is PhysicsObject3D):
		return
	
	
	# Store reference to the phys object
	var colliding_phys_obj : PhysicsObject3D = get_collider() as PhysicsObject3D
	
	
	print(colliding_phys_obj)
