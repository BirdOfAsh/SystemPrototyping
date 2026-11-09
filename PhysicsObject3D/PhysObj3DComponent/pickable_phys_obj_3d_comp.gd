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
		print('picked ' + str(picked))

#endregion


var target_point : Marker3D:
	set(new_target_point):
		target_point = new_target_point
		if target_point == null:
			target_velocity = Vector3.INF
			last_target_position = Vector3.INF
		else:
			last_target_position = target_point.global_position


## The reference to the last stored target position, used to calculate velocity
var last_target_position : Vector3 = Vector3.INF

var target_velocity : Vector3 = Vector3.INF


func component_setup(new_phys_obj : PhysicsObject3D) -> void:
	super(new_phys_obj)


func integrate_forces(_state: PhysicsDirectBodyState3D) -> void:
	if picked and target_point != null and target_velocity != null:
		apply_force_towards_point(_state)


func _physics_process(delta: float) -> void:
	if target_point == null: return
	
	calc_target_velocity(target_point.global_position, last_target_position, delta)


func apply_force_towards_point(state : PhysicsDirectBodyState3D) -> void:
	var position_error : Vector3 = target_point.global_position - state.transform.origin
	var velocity_error : Vector3 = target_velocity - state.linear_velocity
	
	# Spring dampener constants (mass independent)
	
	# Omega is the natural angular frequency, how fast the spring would oscillate
	#(in radians per second) if there were no damping at all.
	var omega : float = TAU * 3 # <- change this for how snappy it is
	# How many newtons of pull you get per meter of error
	var spring_stiffness : float = phys_obj.mass  * omega * omega
	# How many newtons of braking you get per m/s of velocity error.
	# Consider it to be like a sort of friction that helps to prevent osillating
	var damping_coefficient : float = 2.0 * phys_obj.mass * 1.0 * omega
	
	# The proportional derivative (PD) feedback
	# The force that reacts to position and velocity error
	var pd_force : Vector3 = position_error * spring_stiffness + velocity_error * damping_coefficient 
	
	# Feed-forward
	# Disregard gravity
	pd_force -= state.total_gravity * phys_obj.mass
	
	# Apply the force and limit it by a maximum value
	state.apply_central_force(pd_force.limit_length(50.0))


func pick_up() -> void:
	if picked == false:
		picked = true


func put_down() -> void:
	if picked == true:
		picked = false


func set_target_marker(new_target_marker : Marker3D) -> void:
	target_point = new_target_marker


func calc_target_velocity(new_target_position : Vector3, old_target_position : Vector3, delta : float) -> void:
	target_velocity = (new_target_position - old_target_position)  / delta
	last_target_position = new_target_position
