class_name PhysicsPickingSystem extends Node3D

@onready var phys_detection_area_3d: PhysDetectionArea3D = %PhysDetectionArea3D as PhysDetectionArea3D
@onready var pull_position: Marker3D = %PullPosition as Marker3D

var last_collision : PhysicsObject3D = null:
	set(new_last_collision):
		last_collision = new_last_collision
		# If the collision is cleared, make sure to allow a new one to be picked
		#if last_collision == null: can_update_collision = true

var can_update_collision : bool = true

func _ready() -> void:
	if !phys_detection_area_3d:
		push_warning("No detection area in picking system")
		return
	if !pull_position:
		push_warning("No pull point in picking system")
		return
	
	phys_detection_area_3d._on_colliding_phys_obj_value_changed.connect(phys_obj_update)


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("click") and last_collision != null:
		(last_collision.get_component(PickablePhysObj3DComponent) as PickablePhysObj3DComponent).pick_up()
	if Input.is_action_just_released("click") and last_collision != null:
		(last_collision.get_component(PickablePhysObj3DComponent) as PickablePhysObj3DComponent).put_down()


func phys_obj_update(collision : PhysicsObject3D) -> void:
	if can_update_collision == false: return
	# If collision changed to null, clear previous collision data
	if collision == null :
		clear_last_collision()
	# Connect the PickablePhysObj3DComponent so it can request to have it's target position set
	else:
		connect_last_collision(collision)


func connect_last_collision(collision : PhysicsObject3D) -> void:
	if can_update_collision == false: return
	var pick_comp : PickablePhysObj3DComponent = collision.get_component(PickablePhysObj3DComponent) as PickablePhysObj3DComponent
	pick_comp.set_target_marker(pull_position)
	pick_comp._on_picked_value_changed.connect(set_can_update_collision)
	# Store the last know collision so we can disconnect it if needed
	last_collision = collision
	last_collision.can_sleep = false


func clear_last_collision() -> void:
	var last_collision_comp : PickablePhysObj3DComponent = last_collision.get_component(PickablePhysObj3DComponent) as PickablePhysObj3DComponent
	# Clear the collisions target position
	last_collision_comp.set_target_marker(null)
	
	Utils.disconnect_signal(last_collision_comp._on_picked_value_changed, set_can_update_collision)
	
	last_collision.can_sleep = true
	last_collision = null


func set_can_update_collision(is_picked : bool) -> void:
	can_update_collision = !is_picked
