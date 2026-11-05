class_name PhysicsPickingSystem extends Node3D

@onready var phys_detection_area_3d: PhysDetectionArea3D = %PhysDetectionArea3D as PhysDetectionArea3D
@onready var pull_position: Marker3D = %PullPosition as Marker3D


func _ready() -> void:
	if !phys_detection_area_3d:
		push_warning("No detection area in picking system")
		return
	if !pull_position:
		push_warning("No pull point in picking system")
		return
	
	phys_detection_area_3d._on_colliding_phys_obj_value_changed.connect(pass_on_target_position)

#TODO: deal with disconnecting this fuckery somehow
#TODO: OOPS FORGOT THE VALUE COULD BE NULL FIGURE THAT OUT
## Get the collision
func set_up_target_request(collision : PhysicsObject3D) -> void:
	var collision_comp : PickablePhysObj3DComponent = collision.get_component(PickablePhysObj3DComponent) as PickablePhysObj3DComponent
	collision_comp.request_target_position.connect(pass_on_target_position.bind(collision))


func pass_on_target_position(collision : PhysicsObject3D) -> void:
	var collision_comp : PickablePhysObj3DComponent = collision.get_component(PickablePhysObj3DComponent) as PickablePhysObj3DComponent
	collision_comp.set_target_position(pull_position.global_position)
