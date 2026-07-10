@icon("uid://mms7tsllqfcb")
class_name ControlNodeEffect extends TransformEffect
## [ControlNodeEffect] is an extension of [TweenEffect] and additionally contains
## transform and [CanvasItem] parameters.

## The node which will have the effect applied.
@export var affected_node : Control

@export var offset_transform_effect : OffsetTransformEffect


#region Offset Transform Properties
@export_category("Offset Transform Properties")

@export_group("Offset Position")
## The position the tween will start at. [br]
## Has INF values by default, and will ignore individual x or y if left unchanged.
@export var start_offset_position : Vector2 = Vector2.INF

## The position the tween will end at. [br]
## Has INF values by default, and will ignore individual x or y if left unchanged.
@export var end_offset_position : Vector2 = Vector2.INF

## Original position of the node 
var original_offset_position : Vector2

## The current position of the node, stored in a variable
var current_offset_position : Vector2

@export_group("Offset Rotation")

## The rotation amount is the rotation degrees the tween will start at. [br]
## Has INF value by default, and will ignore this parameter if unchanged.
@export var start_offset_rotation : float = INF

## The rotation amount is the rotation degrees the tween will end at. [br]
## Has INF value by default, and will ignore this parameter if unchanged.
@export var end_offset_rotation : float = INF

## Original rotation of the node in degrees
var original_offset_rotation : float

## The current rotate of the node in rotation_degrees, stored in a variable
var current_offset_rotation : float

@export_group("Offset Scale")

## The scale amount is the scale the tween will start at. [br]
## Has INF values by default, and will ignore individual x or y if left unchanged.
@export var start_offset_scale : Vector2 = Vector2.INF

## The scale amount is the scale the tween will end at. [br]
## Has INF values by default, and will ignore individual x or y if left unchanged.
@export var end_offset_scale : Vector2 = Vector2.INF

## Original scale of the node in degrees
var original_offset_scale : Vector2

## The current rotate of the node in rotation_degrees, stored in a variable
var current_offset_scale : Vector2

#endregion

func _ready() -> void:
	if !affected_node:
		return
	
	if autostart:
		do_tween()
	# Sets the pivot offset to be the center of the control node
	affected_node.pivot_offset_ratio = Vector2(0.5, 0.5)
	# Sets the affected control node to be able to use offset transform
	affected_node.offset_transform_enabled = true
	set_original_values()


func do_tween() -> void:
	# Create a new tween with given parameters
	_reset_tween()
	_do_transform_tween(affected_node)
	offset_transform_effect.tween_offset_properties(tween, tween_duration, affected_node)


func do_tween_backward(reset : bool = false) -> void:
	# Create a new tween with given parameters
	_reset_tween()
	_do_transform_tween_backward(affected_node, reset)
	offset_transform_effect.tween_offset_properties(tween, tween_duration, affected_node, false)


## Sets the original transform values to the [member affected_node]
func set_original_values() -> void:
	await get_tree().physics_frame
	original_position = affected_node.position
	original_rotation = affected_node.rotation
	original_scale = affected_node.scale


## Sets the current transform values to the [member affected_node]
func set_current_values() -> void:
	current_position = affected_node.position
	current_rotation = affected_node.rotation
	current_scale = affected_node.scale
