@icon("uid://mms7tsllqfcb")
class_name ControlTween extends TweenComponent
## [ControlNodeEffect] is an extension of [TweenEffect] and additionally contains
## transform and [CanvasItem] parameters.

## The node which will have the effect applied.
@export var affected_node : Control
## The transform tween resource
@export var transform_tween : TransformTween
## The offset transform tween resource
@export var offset_transform_tween : OffsetTransformTween


func _ready() -> void:
	if has_errors(): return
	
	if autostart: do_tween()
	
	# Sets the pivot offset to be the center of the control node
	affected_node.pivot_offset_ratio = Vector2(0.5, 0.5)
	# Sets the affected control node to be able to use offset transform
	affected_node.offset_transform_enabled = true


func do_tween(forward : bool = true) -> void:
	if has_errors(): return
	
	# Create a new tween with given parameters
	_reset_tween()
	# Set all the current values for the relevant tween values
	set_current_values()
	
	# Set up the loop
	if loop:
		tween.set_loops()
	
	# Tween that shit
	transform_tween.tween_transform_properties(tween, tween_duration, affected_node, forward)
	offset_transform_tween.tween_offset_properties(tween, tween_duration, affected_node, forward)
	
	# Set up chaining
	if loop:
		tween.chain()
		transform_tween.tween_transform_properties(tween, tween_duration, affected_node, forward)
		offset_transform_tween.tween_offset_properties(tween, tween_duration, affected_node, forward)
	
	# Await for tween to finish so that it can loop
	await tween.finished


## Sets the current transform values to the [member affected_node]
func set_current_values() -> void:
	transform_tween.set_current_values(affected_node)
	offset_transform_tween.set_current_values(affected_node)


## Returns a boolean if any errors were found, and gives an error pointing to the issue.
func has_errors() -> bool:
	# If there is no node, that shit will NOT work
	if !affected_node:
		printerr("%s: No node assigned to %s, and attempted to run." % [self, self.name])
		return true
	
	return false
