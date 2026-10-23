## This class is a generalized component class for adding to [PhysicsObject3D]. [br]
## This is intended to be an abstract that handles some universal logic but not used alone.
@abstract class_name PhysObj3DComponent

## Reference to the physical object
var phys_obj : PhysicsObject3D


## Pass in the [PhysicsObject3D] for this component to augment
func _init(new_phys_obj : PhysicsObject3D) -> void:
	phys_obj = new_phys_obj
