## A 3D physcial object class which extends off of [RigidBody3D]. [br]
## The purpose of this class is to act as a base for all physical objects and use
## components to further describe additional properties.
class_name PhysicsObject3D extends RigidBody3D

@warning_ignore("unused_signal")
signal ray_entered(ray : RayCast3D)
@warning_ignore("unused_signal")
signal ray_exited(ray : RayCast3D)

@export var component_list : Array[PhysObj3DComponent]
@export var pickable : bool = false


func _ready() -> void:
	call_component_setup()


func call_component_setup() -> void:
	for comp : PhysObj3DComponent in component_list:
		comp.component_setup(self)


func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	for comp : PhysObj3DComponent in component_list:
		comp.integrate_forces(state)
