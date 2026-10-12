class_name EntityStateMachine extends StateMachine

@export var entity : FirstPersonEntityController


func _ready() -> void:
	if entity == null:
		printerr("%s: No player object is set in export" % self.name)
		return
	
	setup_states()


func setup_states() -> void:
	for state in states:
		(state as EntityState).entity = self.entity
		state.state_machine = self
	
	curr_state = get_first_state_of_type(IdleEntityState)


func _process(delta: float) -> void:
	if !entity.physics_enabled:
		return
	super(delta)


func _physics_process(delta: float) -> void:
	if !entity.physics_enabled:
		return
	super(delta)
