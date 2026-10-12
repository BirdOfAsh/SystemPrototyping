@abstract class_name AbstractInteractionHandler extends Node

const INTERACTABLE_GROUP_NAME : String = "Interactable"

var is_enabled : bool = true
var is_interacting : bool = false
var is_hovering : bool = false
var raycast_last_handled_timestamp : float

const HOVER_FADE_THESHOLD_MS : float = 200

## Returns the const value defining the group name for this class
##
## Intention is to grab group name from interaction handler so its ALWAYS checking against the right val
static func get_group_name() -> String:
	return INTERACTABLE_GROUP_NAME

@abstract func is_correct_input_given() -> bool

@abstract func fade_in_hover_effect() -> void

@abstract func fade_out_hover_effect() -> void

@abstract func do_interaction(entity : FirstPersonEntityController) -> void


## Add interactable node to proper group to ensure that its interactable
func _init(interactable_node : Node) -> void:
	interactable_node.add_to_group(AbstractInteractionHandler.get_group_name())
	interactable_node.add_child(self, true)


func _physics_process(_delta: float) -> void:
	if !is_hovering:
		return
	
	# if hovering, check how long it was since we last handled a raycast collision
	# if > threshold, player isnt hovering anymore
	if Time.get_ticks_msec() - raycast_last_handled_timestamp > HOVER_FADE_THESHOLD_MS:
		is_hovering = false
		fade_out_hover_effect()


## Called by the players InteractionRaycast raycast
func handle_raycast_collision(player : FirstPersonEntityController) -> void:
	if !is_enabled:
		return
	# store time that we handled the raycast, later checked against later to check if the player is still hovering
	raycast_last_handled_timestamp = Time.get_ticks_msec()
	# lock out interaction calls if player is currently interacting
	if is_interacting:
		return
	
	# screen for correct input
	if !is_correct_input_given():
		# case: player is looking at interactable but not interacting
		if is_hovering:
			return
		fade_in_hover_effect()
		is_hovering = true
		return
	
	# case: player is interacting!
	do_interaction(player)


func enable() -> void:
	is_enabled = true


func disable() -> void:
	is_enabled = false
