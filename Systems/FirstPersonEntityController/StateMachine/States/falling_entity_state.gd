class_name FallingEntityState extends EntityState


func _custom_physics_process(delta : float) -> void:
	entity.velocity += entity.get_gravity() * delta
	entity.move_and_slide()
	check_for_transition_criteria()


func check_for_transition_criteria() -> void:
	if !entity.is_on_floor():
		return
	
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	
	if input_dir:
		state_machine.transition_to(WalkingEntityState)
	else:
		state_machine.transition_to(IdleEntityState)
