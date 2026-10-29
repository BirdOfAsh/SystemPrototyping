## This is a PhysObj3DComponent class for handling picking up PhysicalObject3D
class_name PickablePhysObj3DComponent extends PhysObj3DComponent


## If the object is being pickup up
var picked : bool = false
## If the object is being hovered
var hovered : bool = false


func component_setup(new_phys_obj : PhysicsObject3D) -> void:
	super(new_phys_obj)


func pick_up() -> void:
	if hovered and not picked:
		pass
