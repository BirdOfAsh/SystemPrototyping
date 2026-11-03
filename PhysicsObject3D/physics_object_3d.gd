## A 3D physcial object class which extends off of [RigidBody3D]. [br]
## This class stores a dictionary of all parameters and delegates the
## physics state to them.
class_name PhysicsObject3D extends RigidBody3D


@export var component_list : Array[PhysObj3DComponent]

## Dictionary where all components are stored, accessable by thier global class
var component_dict : Dictionary[Script, PhysObj3DComponent]


func _ready() -> void:
	generate_component_dict()
	call_component_setup()
	set_collision_info()


func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	for comp : PhysObj3DComponent in component_dict.values() as Array[PhysObj3DComponent]:
		comp.integrate_forces(state)


func set_collision_info() -> void:
	self.set_collision_layer_value(PickablePhysObj3DComponent.PHYS_PICKABLE_LAYER, true)


## Calls the component_setup() function on all [PhysObj3DComponent]
func call_component_setup() -> void:
	for comp : PhysObj3DComponent in component_dict.values() as Array[PhysObj3DComponent]:
		comp.component_setup(self)


## Generates a dictionary of components from [member component_list]
## by class script and component as the key/value pair.
func generate_component_dict() -> void:
	for index in range(0, component_list.size()):
		# Get the component at the index
		var comp : PhysObj3DComponent = component_list[index]
		# Check to see if the array entry was null
		if comp == null:
			push_warning("%s has a missing component at index: %s" % [self.name, index])
		# Checks for duplicate components in the list
		elif component_dict.has(comp.get_script()):
			push_warning("%s has a duplicate component of type %s at index %s and %s" % [self.name, comp.get_script().get_global_name(), component_list.find(comp), index] )
		# Make the dictionary entry is there we no errors
		else:
			component_dict.set(comp.get_script(), comp)


## Returns if this object has a certain component on it by passing in the 
## global class [param script] as a parameter.
func has_component(script : Script) -> bool:
	return component_dict.has(script)


## Returns the [PhysObj3DComponent] object given a global class [param script]. [br]
## Returns null if there is no [PhysObj3DComponent] for the [param script].
func get_component(script : Script) -> PhysObj3DComponent:
	return component_dict[script]
