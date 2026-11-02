class_name PhysDectionArea3D extends Area3D


var colliding_phys_obj : PhysicsObject3D


func _ready() -> void:
	body_entered.connect(_phys_obj_entered)
	body_exited.connect(_phys_obj_exited)


## Chcek for if the area entered a [PhysicsObject3D] and update [member colliding_phys_obj] if so.
func _phys_obj_entered(body : Node3D) -> void:
	var phys_obj : PhysicsObject3D = body as PhysicsObject3D
	# Check if the body is a PhysicsObject3D
	if phys_obj== null: return
	
	# Should never throw an error since this function only runs when a [PhysicsObject3D enters
	colliding_phys_obj = get_closest_phys_obj()
	
	#TODO: Figure out what to do here
	if phys_obj.has_component(PickablePhysObj3DComponent):
		var pickable_comp : PickablePhysObj3DComponent = (phys_obj.get_component(PickablePhysObj3DComponent) as PickablePhysObj3DComponent)
		pickable_comp.pick_up()


## Check if the body that jusst exited is the currently stored [member colliding_phys_obj],
## and if so then clear it.
func _phys_obj_exited(body : Node3D) -> void:
	if body == colliding_phys_obj:
		var pickable_comp : PickablePhysObj3DComponent = (colliding_phys_obj.get_component(PickablePhysObj3DComponent) as PickablePhysObj3DComponent)
		pickable_comp.put_down()
		colliding_phys_obj = null


## Returns the closest [PhysicsObject3D] currently colliding. [br]
## Only returns null when it runs with no colliding bodies.
func get_closest_phys_obj() -> PhysicsObject3D:
	var closest_body : PhysicsObject3D = null
	var closest_distance_sq : float = INF
	var overlapping_bodies : Array[Node3D] = get_overlapping_bodies()
	
	if overlapping_bodies.is_empty():
		push_warning("%s is checking for the closest object but has none" % [self.name])
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
