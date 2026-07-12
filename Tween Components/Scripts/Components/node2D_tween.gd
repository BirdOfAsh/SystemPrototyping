@icon("uid://mc5sx2ggbl4q")
class_name Node2DTween extends TweenComponent
## [Node2DEffect] is an extension of [TweenEffect] and additionally contains
## transform and [CanvasItem] parameters.

## The node which will have the effect applied.
@export var affected_node : Node2D
## The transform tween resource
@export var transform_tween : TransformTween


func _ready() -> void:
	if has_errors(): return
	
	if autostart: do_tween()


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
	
	# Set up chaining
	if loop:
		tween.chain()
		transform_tween.tween_transform_properties(tween, tween_duration, affected_node, forward)
	
	# Await for tween to finish so that it can loop
	await tween.finished


## Sets the current transform values to the [member affected_node]
func set_current_values() -> void:
	transform_tween.set_current_values(affected_node)


func has_errors() -> bool:
	# If there is no node, that shit will NOT work
	if !affected_node:
		printerr("%s: No node assigned to %s, and attempted to run." % [self, self.name])
		return true
	
	
	return false
