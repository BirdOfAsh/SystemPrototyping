class_name PhysDetectionArea3D extends Area3D


#region Listenable Properties
signal _on_colliding_phys_obj_value_changed(value : PhysicsObject3D)

## If the object is being pickup up
var colliding_phys_obj : PhysicsObject3D:
	set(new_collision):
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
	
	# Should never throw an error since this function only runs when a [PhysicsObject3D enters
	colliding_phys_obj = get_closest_phys_obj()


## Check if the body that jusst exited is the currently stored [member colliding_phys_obj],
## and if so then clear it.
func _phys_obj_exited(body : Node3D) -> void:
	if body == colliding_phys_obj:
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


#func call_pick_up() -> void:
	#var pickable_comp : PickablePhysObj3DComponent = (colliding_phys_obj.get_component(PickablePhysObj3DComponent) as PickablePhysObj3DComponent)
	#pickable_comp.pick_up()
#
#
#func obj_picker_setup() -> void:
	#if phys_obj_picker:
		#phys_obj_picker.try_pick_up.connect(call_pick_up)
	#else:
		#push_warning("No object picker on %s" % [self.name])
