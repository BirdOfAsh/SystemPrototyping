@abstract class_name StateMachine extends Node

@export var states : Array[State]

var curr_state : State


## Returns first state in [member states] that matches the input type
## [param type] is Script here to allow us to pass in types in this format:
##
## [codeblock]
## get_first_state_of_type(IdleEntityState)
## [/codeblock]
##
## WARNING: Any type passed in MUST be a CUSTOM, NAMED class
func transition_to(next_state_type : Script) -> void:
	var next_state : State = get_first_state_of_type(next_state_type)
	if next_state == null:
		printerr("%s: Next state: %s was not a valid state in this StateMachine" % [self, next_state_type])
		return
	
	@warning_ignore("redundant_await")
	await curr_state.transition_out()
	curr_state = next_state
	@warning_ignore("redundant_await")
	await curr_state.transition_in()
	


## Returns first state in [member states] that matches the input type
## [param type] is Script here to allow us to pass in types in this format:
##
## [codeblock]
## get_first_state_of_type(IdleEntityState)
## [/codeblock]
##
## WARNING: Any type passed in MUST be a CUSTOM, NAMED class
func get_first_state_of_type(type : Script) -> State:
	for state in states:
		if is_instance_of(state, type):
			return state
	return null



func _process(delta: float) -> void:
	if curr_state == null:
		return
	curr_state._custom_process(delta)


func _physics_process(delta: float) -> void:
	if curr_state == null:
		return
	curr_state._custom_physics_process(delta)
