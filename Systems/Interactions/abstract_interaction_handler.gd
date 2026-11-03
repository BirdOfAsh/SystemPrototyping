@abstract class_name AbstractInteractionArea extends Area3D

const HOVER_FADE_THESHOLD_MS : float = 200

var _raycast_last_handled_timestamp : float

#region listenable properties
signal is_enabled_value_changed(value : bool)
signal is_interacting_value_changed(value : bool)
signal is_hovering_value_changed(value : bool)

var is_enabled : bool = true:
	set(value):
		is_enabled = value
		is_enabled_value_changed.emit(is_enabled)
var is_interacting : bool = false:
	set(value):
		is_interacting = value
		is_interacting_value_changed.emit(is_interacting)
var is_hovering : bool = false:
	set(value):
		is_hovering = value
		is_hovering_value_changed.emit(is_hovering)
#endregion

@abstract func is_correct_input_given() -> bool

@abstract func fade_in_hover_effect() -> void

@abstract func fade_out_hover_effect() -> void

@abstract func do_interaction(raycast : InteractionRaycast) -> void


func _init() -> void:
	# always have interaction areas exist on interaction layer corresponding to interaction raycast!
	self.set_collision_layer_value(InteractionRaycast.INTERACTION_LAYER, true)


func _physics_process(_delta: float) -> void:
	check_for_hover()


func check_for_hover() -> void:
	if !is_hovering:
		return
	
	# if hovering, check how long it was since we last handled a raycast collision
	# if > threshold, entity isnt hovering anymore
	# (hovering is enabled upon handling incoming raycast collisions from InteractionRaycast)
	if Time.get_ticks_msec() - _raycast_last_handled_timestamp > HOVER_FADE_THESHOLD_MS:
		is_hovering = false
		fade_out_hover_effect()


## Called by the entity's InteractionRaycast raycast
func handle_raycast_collision(raycast : InteractionRaycast) -> void:
	if !is_enabled:
		return
	
	# store time that we handled the raycast, later checked against later to check if the entity is still hovering
	_raycast_last_handled_timestamp = Time.get_ticks_msec()
	# lock out interaction calls if entity is currently interacting
	if is_interacting:
		return
	
	# start hover effect if it hasn't been already
	if !is_hovering:
		fade_in_hover_effect()
		is_hovering = true
	
	# screen for correct input
	if !is_correct_input_given():
		return
	
	# case: entity is interacting!
	do_interaction(raycast)
