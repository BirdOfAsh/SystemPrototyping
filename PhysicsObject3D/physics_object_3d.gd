## A 3D physcial object class which extends off of [RigidBody3D]. [br]
## The purpose of this class is to act as a base for all physical objects and use
## components to further describe additional properties.
class_name PhysicsObject3D extends RigidBody3D

@warning_ignore("unused_signal")
signal ray_entered(ray : RayCast3D)
@warning_ignore("unused_signal")
signal ray_exited(ray : RayCast3D)


@export var pickable : bool = false


func _ready() -> void:
	make_components()


func make_components() -> void:
	if pickable:
		PickablePhysObj3DComponent.new(self)
