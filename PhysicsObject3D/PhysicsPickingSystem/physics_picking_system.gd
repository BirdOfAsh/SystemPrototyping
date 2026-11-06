class_name PhysicsPickingSystem extends Node3D

@onready var phys_detection_area_3d: PhysDetectionArea3D = %PhysDetectionArea3D as PhysDetectionArea3D
@onready var pull_position: Marker3D = %PullPosition as Marker3D

var last_collision : PhysicsObject3D = null


func _ready() -> void:
	if !phys_detection_area_3d:
		push_warning("No detection area in picking system")
		return
	if !pull_position:
		push_warning("No pull point in picking system")
		return
	
	phys_detection_area_3d._on_colliding_phys_obj_value_changed.connect(phys_obj_update)


func phys_obj_update(collision : PhysicsObject3D) -> void:
	# If collision changed to null, clear previous collision data
	if collision == null: clear_last_collision()
	# Connect the PickablePhysObj3DComponent so it can request to have it's target position set
	else:
		var pick_comp : PickablePhysObj3DComponent = collision.get_component(PickablePhysObj3DComponent) as PickablePhysObj3DComponent
		pick_comp.request_target_position.connect(pass_on_target_position.bind(collision))
	# Store the last know collision so we can disconnect it if needed
	last_collision = collision


func clear_last_collision() -> void:
	var last_collision_comp : PickablePhysObj3DComponent = last_collision.get_component(PickablePhysObj3DComponent) as PickablePhysObj3DComponent
	Utils.disconnect_signal(last_collision_comp.request_target_position, pass_on_target_position)


## Set the target position of a [PickablePhysObj3DComponent] node on a given [param collision].
func pass_on_target_position(collision : PhysicsObject3D) -> void:
	var collision_comp : PickablePhysObj3DComponent = collision.get_component(PickablePhysObj3DComponent) as PickablePhysObj3DComponent
	collision_comp.set_target_position(pull_position.global_position)
