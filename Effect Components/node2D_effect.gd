class_name Node2DEffect extends TweenEffect
## [Node2DEffect] is an extension of [TweenEffect] and additionally contains
## position, rotation, and scale parameters.

## The node which will have the effect applied.
@export var affected_node : Node2D

## The position the tween will start at. [br]
## Has INF values by default, and will ignore individual x or y if left unchanged
@export var starting_position : Vector2 = Vector2.INF

## The position the tween will end at. [br]
## Has INF values by default, and will ignore individual x or y if left unchanged
@export var ending_position : Vector2 = Vector2.INF

## The rotation amount is the rotation degrees the tween will start at. [br]
## Has INF value by default, and will ignore this parameter if unchanged.
@export var starting_rotation : float = INF

## The rotation amount is the rotation degrees the tween will end at. [br]
## Has INF value by default, and will ignore this parameter if unchanged.
@export var ending_rotation : float = INF

## The scale amount is the scale the tween will start at. [br]
## Has INF values by default, and will ignore individual x or y if left unchanged
@export var starting_scale : Vector2 = Vector2.INF

## The scale amount is the scale the tween will end at. [br]
## Has INF values by default, and will ignore individual x or y if left unchanged
@export var ending_scale : Vector2 = Vector2.INF


@export var loop : bool = false


func do_tween() -> void:
	# Return if there is no node
	if !affected_node:
		printerr(self, "No node assigned to Node2D Effect")
		return
	
	# Create a new tween with given parameters
	reset_tween()
	
	# Tween the positions if not default
	tween.tween_property(
		affected_node,
		"position:x",
		ending_position.x if ending_position.x != INF else affected_node.position.x,
		tween_duration
		).from(
			starting_position.x if starting_position.x != INF else affected_node.position.x
			)
	tween.tween_property(
		affected_node,
		"position:y",
		ending_position.y if ending_position.y != INF else affected_node.position.y,
		tween_duration
		).from(
			starting_position.y if starting_position.y != INF else affected_node.position.y
			)
	
	# Tween the rotation if not default
	tween.tween_property(
		affected_node,
		"rotation_degrees",
		ending_rotation if ending_rotation != INF else affected_node.rotation_degrees,
		tween_duration
		).from(
			starting_rotation if starting_rotation != INF else affected_node.rotation_degrees
			)
	
	#Tween the scale if not default
	tween.tween_property(
		affected_node,
		"scale:x",
		starting_scale.x if starting_scale.x != INF else affected_node.scale.x,
		tween_duration
		).from(
			ending_scale.x if ending_scale.x != INF else affected_node.scale.x
			)
	tween.tween_property(
		affected_node,
		"scale:y",
		starting_scale.y if starting_scale.y != INF else affected_node.scale.y,
		tween_duration
		).from(
			ending_scale.y if ending_scale.y != INF else affected_node.scale.y
			)
	
