## This is a PhysObj3DComponent class for handling picking up PhysicalObject3D
class_name PickablePhysObj3DComponent extends PhysObj3DComponent


## If the object is being pickup up
var picked : bool = false


func component_setup(new_phys_obj : PhysicsObject3D) -> void:
	super(new_phys_obj)


func integrate_forces(_state: PhysicsDirectBodyState3D) -> void:
	if picked:
		pass


func pick_up() -> void:
	if picked == false:
		picked = true


func put_down() -> void:
	if picked == true:
		picked = false
