class_name TransformTween extends TweenResource


#region Transform Properties
@export_group("Position")
## The position the tween will start at. [br]
## Has INF values by default, and will ignore individual x or y if left unchanged.
@export var start_position : Vector2 = Vector2.INF

## The position the tween will end at. [br]
## Has INF values by default, and will ignore individual x or y if left unchanged.
@export var end_position : Vector2 = Vector2.INF

## The current position of the node, stored in a variable
var current_position : Vector2

@export_group("Rotation")

## The rotation amount is the rotation degrees the tween will start at. [br]
## Has INF value by default, and will ignore this parameter if unchanged.
@export var start_rotation : float = INF

## The rotation amount is the rotation degrees the tween will end at. [br]
## Has INF value by default, and will ignore this parameter if unchanged.
@export var end_rotation : float = INF

## The current rotate of the node in rotation_degrees, stored in a variable
var current_rotation : float

@export_group("Scale")

## The scale amount is the scale the tween will start at. [br]
## Has INF values by default, and will ignore individual x or y if left unchanged.
@export var start_scale : Vector2 = Vector2.INF

## The scale amount is the scale the tween will end at. [br]
## Has INF values by default, and will ignore individual x or y if left unchanged.
@export var end_scale : Vector2 = Vector2.INF

## The current rotate of the node in rotation_degrees, stored in a variable
var current_scale : Vector2

#endregion

#region CanvasItem Properties
@export_group("Visibility")

## The modulate the node will start at, if WHITE then will set to default. [br]
## If both modulate are the same, the tween will ignore modulation
@export var start_modulate : Color = Color.WHITE

## The modulate the node will end at, if WHITE then will set to default. [br]
## If both modulate are the same, the tween will ignore modulation
@export var end_modulate : Color = Color.WHITE


#endregion


## Execute transform tweens for the [param affected_node].
func tween_transform_properties(tween : Tween, tween_duration : float, _affected_node : Node, forward : bool = true) -> void:
	_tween_position(tween, tween_duration, _affected_node, forward)
	_tween_rotation(tween, tween_duration, _affected_node, forward)
	_tween_scale(tween, tween_duration, _affected_node, forward)
	_tween_modulate(tween, tween_duration, _affected_node, forward)


func _tween_position(tween : Tween, tween_duration : float, _affected_node : Node, forward : bool = true) -> void:
	# Tween the positions if not default
	if start_position.x != end_position.x:
		tween.tween_property(
			_affected_node,
			"position:x",
			(end_position.x if end_position.x != INF else current_position.x) if forward else (start_position.x if start_position.x != INF else current_position.x),
			tween_duration
			).from(
				(start_position.x if start_position.x != INF else current_position.x) if forward else (end_position.x if end_position.x != INF else current_position.x)
				)
	if start_position.y != end_position.y:
		tween.tween_property(
			_affected_node,
			"position:y",
			(end_position.y if end_position.y != INF else current_position.y) if forward else (start_position.y if start_position.y != INF else current_position.y),
			tween_duration
			).from(
				(start_position.y if start_position.y != INF else current_position.y) if forward else (end_position.y if end_position.y != INF else current_position.y)
				)


func _tween_rotation(tween : Tween, tween_duration : float, _affected_node : Node, forward : bool = true) -> void:
	# Tween the rotation if not default
	if start_rotation != end_rotation:
		tween.tween_property(
			_affected_node,
			"rotation_degrees",
			(end_rotation if end_rotation != INF else current_rotation) if forward else (start_rotation if start_rotation != INF else current_rotation),
			tween_duration
			).from(
				(start_rotation if start_rotation != INF else current_rotation) if forward else (end_rotation if end_rotation != INF else current_rotation)
				)


func _tween_scale(tween : Tween, tween_duration : float, _affected_node : Node, forward : bool = true) -> void:
	# Tween the scale if not default
	if start_scale.x != end_scale.x:
		tween.tween_property(
			_affected_node,
			"scale:x",
			(end_scale.x if end_scale.x != INF else current_scale.x) if forward else (start_scale.x if start_scale.x != INF else current_scale.x),
			tween_duration
			).from(
				(start_scale.x if start_scale.x != INF else current_scale.x) if forward else (end_scale.x if end_scale.x != INF else current_scale.x)
				)
	if start_scale.y != end_scale.y:
		tween.tween_property(
			_affected_node,
			"scale:y",
			(end_scale.y if end_scale.y != INF else current_scale.y) if forward else (start_scale.y if start_scale.y != INF else current_scale.y),
			tween_duration
			).from(
				(start_scale.y if start_scale.y != INF else current_scale.y) if forward else (end_scale.y if end_scale.y != INF else current_scale.y)
				)


func _tween_modulate(tween : Tween, tween_duration : float, _affected_node : Node, forward : bool = true) -> void:
	# Tween modulate if start_modulate and end_modulate are not the same
	if start_modulate != end_modulate:
		tween.tween_property(
			_affected_node,
			"modulate",
			end_modulate if forward else start_modulate,
			tween_duration
		).from(
			start_modulate if forward else end_modulate
		)


func set_current_values(_affected_node : Node) -> void:
	current_position = _affected_node.position
	current_rotation = _affected_node.rotation
	current_scale = _affected_node.scale
