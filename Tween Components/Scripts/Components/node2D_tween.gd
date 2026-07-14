@icon("uid://mc5sx2ggbl4q")
class_name Node2DTween extends TweenComponent
## [Node2DEffect] is an extension of [TweenEffect] and additionally contains
## transform and [CanvasItem] parameters.

## The node which will have the effect applied.
@export var affected_node : Node2D
## The transform tween resource
@export var transform_tween : TransformTween
## The canvas item tween resource
@export var canvas_item_tween : CanvasItemTween


func _ready() -> void:
	super()
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
	_tween_values(forward)
	
	# Set up chaining
	if loop:
		tween.chain()
		_tween_values(forward)
	
	# Await for tween to finish so that it can loop
	await tween.finished


## Wrapper to call the tween functions from all the tween resources
func _tween_values(forward : bool = true) -> void:
	if !use_custom_curve:
		transform_tween.tween_properties(tween, tween_duration, affected_node, forward)
		canvas_item_tween.tween_properties(tween, tween_duration, affected_node, forward)
	else:
		transform_tween.custom_tween_properties(tween, tween_duration, affected_node, transition_curve, forward)
		canvas_item_tween.custom_tween_properties(tween, tween_duration, affected_node, transition_curve, forward)


## Sets the current transform values to the [member affected_node]
func set_current_values() -> void:
	transform_tween.set_current_values(affected_node)
	canvas_item_tween.set_current_values(affected_node)


## Returns a boolean if any errors were found, and gives an error pointing to the issue.
func has_errors() -> bool:
	# If there is no node, that shit will NOT work
	if !affected_node:
		printerr("%s: No node assigned to %s, and attempted to run." % [self, self.name])
		return true
	
	return false
