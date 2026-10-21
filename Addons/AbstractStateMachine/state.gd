@abstract class_name State extends Node

## State machine which this [State] is connected to
var state_machine : StateMachine


## Defines what a [State] does when transitioning in
func transition_in() -> void:
	pass


## Defines what a [State] does when transitioning out
func transition_out() -> void:
	pass


## Defines what a [State] does on the process frame
@warning_ignore("unused_parameter")
func _custom_process(delta : float) -> void:
	pass


## Defines what a [State] does on the physics process frame
@warning_ignore("unused_parameter")
func _custom_physics_process(delta : float) -> void:
	pass


func check_for_transition_criteria() -> void:
	pass
