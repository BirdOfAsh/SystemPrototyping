## This is a PhysObj3DComponent class for handling picking up PhysicalObject3D
class_name PickablePhysObj3DComponent extends PhysObj3DComponent

## The pickable layer for all [PhysicsObject3D]
const PHYS_PICKABLE_LAYER : int = 5


#region Listenable Properties
signal _on_picked_value_changed(value : bool)

## If the object is being pickup up
var picked : bool = false:
	set(new_picked):
		picked = new_picked
		_on_picked_value_changed.emit(picked)
		print('picked' + str(picked))

#endregion


func component_setup(new_phys_obj : PhysicsObject3D) -> void:
	super(new_phys_obj)


func integrate_forces(_state: PhysicsDirectBodyState3D) -> void:
	if picked:
		#TODO: Make a function to move the object to a point and how to get point
		pass


func pick_up() -> void:
	if picked == false:
		picked = true


func put_down() -> void:
	if picked == true:
		picked = false
