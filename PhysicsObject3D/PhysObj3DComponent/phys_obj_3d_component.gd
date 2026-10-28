## This class is a generalized component class for adding to [PhysicsObject3D]. [br]
## This is intended to be an abstract that handles some universal logic but not used alone.
@abstract class_name PhysObj3DComponent extends Node

## Reference to the physical object
var phys_obj : PhysicsObject3D


## Pass in the [PhysicsObject3D] for this component to augment
func component_setup(new_phys_obj : PhysicsObject3D) -> void:
	phys_obj = new_phys_obj


## Allows the [member phys_obj] to pass in a physics state to a component
## so that they can interface with physics related attributes. 
func integrate_forces(_state: PhysicsDirectBodyState3D) -> void: pass
