class_name PhysDetectionArea3D extends Area3D


#region Listenable Properties
signal _on_colliding_phys_obj_value_changed(value : PhysicsObject3D)

## The closest colliding [PhysicsObject3D] which contains a [PickablePhysObj3DComponent]
var colliding_phys_obj : PhysicsObject3D:
	set(new_collision):
		if colliding_phys_obj == new_collision: return
		colliding_phys_obj = new_collision
		_on_colliding_phys_obj_value_changed.emit(colliding_phys_obj)

#endregion


func _ready() -> void:
	body_entered.connect(_phys_obj_entered)
	body_exited.connect(_phys_obj_exited)
	
	
	set_collision_info()


func set_collision_info() -> void:
	self.collision_layer = 0
	self.collision_mask = 0
	
	self.set_collision_mask_value(PickablePhysObj3DComponent.PHYS_PICKABLE_LAYER, true)


## Chcek for if the area entered a [PhysicsObject3D] and update [member colliding_phys_obj] if so.
func _phys_obj_entered(body : Node3D) -> void:
	var phys_obj : PhysicsObject3D = body as PhysicsObject3D
	# Only continue if there is a PhysicsObject3D and it has a PickablePhysObj3DComponent
	if phys_obj == null or phys_obj.has_component(PickablePhysObj3DComponent) == false: return
	# Only update colliding_phys_obj if the value differs, so it won't run the signal unnesesarily
	var closest_phys_body : PhysicsObject3D = get_closest_phys_obj()
	if colliding_phys_obj != get_closest_phys_obj():
		colliding_phys_obj = closest_phys_body
	


## Checks if the area exited is the stored [member colliding_phys_obj] updates the 
## value with the next closest or clears it.
func _phys_obj_exited(body : Node3D) -> void:
	# Ignore if not the current colliding_phys_obj
	if body != colliding_phys_obj: return
	
	# Check for any other phys obj and pick the closest
	# If there are none, then clear it
	var next_closest_obj : PhysicsObject3D = get_closest_phys_obj()
	if next_closest_obj != null:
		colliding_phys_obj = next_closest_obj
	else:
		colliding_phys_obj = null


## Returns the closest [PhysicsObject3D] currently colliding. [br]
## Only returns null when it runs with no colliding bodies.
func get_closest_phys_obj() -> PhysicsObject3D:
	var closest_body : PhysicsObject3D = null
	var closest_distance_sq : float = INF
	var overlapping_bodies : Array[Node3D] = get_overlapping_bodies()
	
	if overlapping_bodies.is_empty():
		return null
	
	for body in overlapping_bodies:
		# Skip non PhysicsObject3D
		if body is not PhysicsObject3D: continue
		# Get the distance squared of the body
		var distance_sq : float = global_position.distance_squared_to(body.global_position)
		# If it's closer, update the closest body
		if distance_sq < closest_distance_sq:
			closest_body = body as PhysicsObject3D
	
	return closest_body
