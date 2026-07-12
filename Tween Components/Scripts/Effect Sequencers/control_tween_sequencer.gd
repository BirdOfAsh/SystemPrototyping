class_name ControlTweenSequencer extends Node
## The purpose of [ControlTweenSequencer] is to hold and call a series of [ControlTween]
## in sequence, to allow for the more complex tween animation.

## The node which was have a sequence of effects applied
@export var affected_node : Control

## Determines if the array of effects will loop once completed
@export var loop : bool = false

## Starts the array of effects upon all nodes becoming ready
@export var autostart : bool = false

## Array of held [ControlNodeEffect]
@export var tween_array : Array[ControlTween]


func _ready() -> void:
	# Check if there is a node
	if !affected_node:
		return
	# Start sequence if autostart is enabled
	if autostart:
		do_effect_sequence()
	


## Calls the do_effect of every [ControlTween] in sequence
func do_effect_sequence() -> void:
	# Check if there is a node to affect
	if !affected_node:
		printerr(self, "There was no node to apply effects to!")
		return
	
	for control_tween : ControlTween in tween_array:
		control_tween.affected_node = affected_node
		
		# Disable loop for all effects
		if control_tween.loop:
			control_tween.loop = false
			printerr(control_tween, "Set loop to false, does not apply when played in sequence.")
		
		# Disable autostart for all effects
		if control_tween.autostart:
			control_tween.autostart = false
			printerr(control_tween, "Set autostart to false, does not apply when played in sequence.")
		
		control_tween.do_tween()
		await control_tween.tween.finished
	
	# We loopin
	if loop:
		do_effect_sequence()


## Stops the sequence by killing every tween in the array of [member effect_array]
func stop_sequence() -> void:
	for control_tween : ControlTween in tween_array:
		control_tween.stop_tween()
