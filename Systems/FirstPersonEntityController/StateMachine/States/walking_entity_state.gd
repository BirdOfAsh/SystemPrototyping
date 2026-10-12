class_name WalkingEntityState extends EntityState


func move_player(delta : float) -> void:
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction: Vector3 = (entity.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var target_velocity : Vector3 = direction * entity.speed
	
	entity.velocity.x = lerp(entity.velocity.x, target_velocity.x, 1.0 - exp(-entity.acceleration * delta))
	entity.velocity.z = lerp(entity.velocity.z, target_velocity.z , 1.0 - exp(-entity.acceleration * delta))


func _custom_physics_process(delta : float) -> void:
	if entity.movement_enabled:
		move_player(delta)
	
	entity.move_and_slide()
	check_for_transition_criteria()


func check_for_transition_criteria() -> void:
	if !entity.is_on_floor():
		state_machine.transition_to(FallingEntityState)
		return
	
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	
	# switch to idle when recieving no input or movement is disabled
	if !input_dir || !entity.movement_enabled:
		state_machine.transition_to(IdleEntityState)
