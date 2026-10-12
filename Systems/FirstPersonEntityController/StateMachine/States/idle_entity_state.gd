class_name IdleEntityState extends EntityState


func _custom_physics_process(delta : float) -> void:
	entity.velocity.x = lerp(entity.velocity.x, 0.0, 1.0 - exp(-entity.acceleration * delta))
	entity.velocity.z = lerp(entity.velocity.z, 0.0, 1.0 - exp(-entity.acceleration * delta))
	
	entity.move_and_slide()
	
	check_for_transition_criteria()


func check_for_transition_criteria() -> void:
	if !entity.is_on_floor():
		state_machine.transition_to(FallingEntityState)
		return
	
	var input_dir: Vector2 = Input.get_vector("left", "right", "forward", "back")
	
	if !input_dir:
		return
	
	state_machine.transition_to(WalkingEntityState)
