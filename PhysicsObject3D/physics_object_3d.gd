## A 3D physcial object class which extends off of [RigidBody3D]. [br]
## The purpose of this class is to act as a base for all physical objects and use
## components to further describe additional properties.
class_name PhysicsObject3D extends RigidBody3D


@export var component_list : Array[PhysObj3DComponent]
@export var pickable : bool = false

var component_dict : Dictionary[Script, PhysObj3DComponent]


func _ready() -> void:
	call_component_setup()


func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	for comp : PhysObj3DComponent in component_list:
		comp.integrate_forces(state)


## Calls the component_setup() function on all [PhysObj3DComponent]
func call_component_setup() -> void:
	for comp : PhysObj3DComponent in component_list:
		comp.component_setup(self)


## Generates a dictionary of components from [member component_list]
## by class script and component as the key/value pair.
func generate_component_dict() -> void:
	for index in range(0, component_list.size()):
		# Get the component at the index
		var comp : PhysObj3DComponent = component_list[index]
		# Check to see if the array entry was null
		if comp == null:
			push_warning("Missing component at index: " + str(index))
		# Check to see if there is a component already set in the dict
		elif component_dict.has(comp.get_script()):
			push_warning("")
		else:
			# Make the dictionary entry
			component_dict.set(comp.get_script(), comp)


#TODO: Update this with dictionary
func has_component(script : Script) -> bool:
	for comp in component_list:
		if is_instance_of(comp, script):
			return true
	return false
