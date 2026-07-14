class_name OffsetTransformTween extends TweenResource


#region Offset Transform Properties
@export_category("Offset Transform Properties")

@export_group("Offset Position")
## The position the tween will start at. [br]
## Has INF values by default, and will ignore individual x or y if left unchanged.
@export var start_offset_position : Vector2 = Vector2.INF

## The position the tween will end at. [br]
## Has INF values by default, and will ignore individual x or y if left unchanged.
@export var end_offset_position : Vector2 = Vector2.INF

## The current position of the node, stored in a variable
var current_offset_position : Vector2

@export_group("Offset Rotation")

## The rotation amount is the rotation degrees the tween will start at. [br]
## Has INF value by default, and will ignore this parameter if unchanged.
@export var start_offset_rotation : float = INF

## The rotation amount is the rotation degrees the tween will end at. [br]
## Has INF value by default, and will ignore this parameter if unchanged.
@export var end_offset_rotation : float = INF

## The current rotate of the node in rotation_degrees, stored in a variable
var current_offset_rotation : float

@export_group("Offset Scale")

## The scale amount is the scale the tween will start at. [br]
## Has INF values by default, and will ignore individual x or y if left unchanged.
@export var start_offset_scale : Vector2 = Vector2.INF

## The scale amount is the scale the tween will end at. [br]
## Has INF values by default, and will ignore individual x or y if left unchanged.
@export var end_offset_scale : Vector2 = Vector2.INF

## The current rotate of the node in rotation_degrees, stored in a variable
var current_offset_scale : Vector2

#endregion


## Call to tween each of the individual offset transform properties (position, rotation, scale)
func tween_properties(tween : Tween, tween_duration : float, _affected_node : Node, forward : bool = true) -> void:
	_tween_offset_position(tween, tween_duration, _affected_node, forward)
	_tween_offset_rotation(tween, tween_duration, _affected_node, forward)
	_tween_offset_scale(tween, tween_duration, _affected_node, forward)


## Call to tween each of the individual offset transform properties (position, rotation, scale) with a custom transition curve
func custom_tween_properties(tween : Tween, tween_duration : float, _affected_node : Node, curve : Curve, forward : bool = true) -> void:
	_custom_tween_offset_position(tween, tween_duration, _affected_node, curve, forward)
	_custom_tween_offset_rotation(tween, tween_duration, _affected_node, curve, forward)
	_custom_tween_offset_scale(tween, tween_duration, _affected_node, curve, forward)


#region Offset Transform Functions
func _tween_offset_position(tween : Tween, tween_duration : float, _affected_node : Node, forward : bool = true) -> void:
	# Tween position.x
	tween.tween_property(
		_affected_node,
		"offset_transform_position:x",
		(end_offset_position.x if end_offset_position.x != INF else current_offset_position.x) if forward else (start_offset_position.x if start_offset_position.x != INF else current_offset_position.x),
		tween_duration
		).from(
			(start_offset_position.x if start_offset_position.x != INF else current_offset_position.x) if forward else (end_offset_position.x if end_offset_position.x != INF else current_offset_position.x)
			)
	
	# Tween position.y
	tween.tween_property(
		_affected_node,
		"offset_transform_position:y",
		(end_offset_position.y if end_offset_position.y != INF else current_offset_position.y) if forward else (start_offset_position.y if start_offset_position.y != INF else current_offset_position.y),
		tween_duration
		).from(
			(start_offset_position.y if start_offset_position.y != INF else current_offset_position.y) if forward else (end_offset_position.y if end_offset_position.y != INF else current_offset_position.y)
			)


func _tween_offset_rotation(tween : Tween, tween_duration : float, _affected_node : Node, forward : bool = true) -> void:
	# Tween rotation
	tween.tween_property(
		_affected_node,
		"rotation_degrees",
		(end_offset_rotation if end_offset_rotation != INF else current_offset_rotation) if forward else (start_offset_rotation if start_offset_rotation != INF else current_offset_rotation),
		tween_duration
		).from(
			(start_offset_rotation if start_offset_rotation != INF else current_offset_rotation) if forward else (end_offset_rotation if end_offset_rotation != INF else current_offset_rotation)
			)


func _tween_offset_scale(tween : Tween, tween_duration : float, _affected_node : Node, forward : bool = true) -> void:
	# Tween scale.x
	tween.tween_property(
		_affected_node,
		"scale:x",
		(end_offset_scale.x if end_offset_scale.x != INF else current_offset_scale.x) if forward else (start_offset_scale.x if start_offset_scale.x != INF else current_offset_scale.x),
		tween_duration
		).from(
			(start_offset_scale.x if start_offset_scale.x != INF else current_offset_scale.x) if forward else (end_offset_scale.x if end_offset_scale.x != INF else current_offset_scale.x)
			)
	
	# Tween scale.y
	tween.tween_property(
		_affected_node,
		"scale:y",
		(end_offset_scale.y if end_offset_scale.y != INF else current_offset_scale.y) if forward else (start_offset_scale.y if start_offset_scale.y != INF else current_offset_scale.y),
		tween_duration
		).from(
			(start_offset_scale.y if start_offset_scale.y != INF else current_offset_scale.y) if forward else (end_offset_scale.y if end_offset_scale.y != INF else current_offset_scale.y)
			)
#endregion


#region Custom Offset Transform Functions
func _custom_tween_offset_position(tween : Tween, tween_duration : float, _affected_node : Node, curve : Curve, forward : bool = true) -> void:
	# Set the starting from -> this exists because MethodTweener does not have the .from() function
	var starting_pos_x : float = (start_offset_position.x if start_offset_position.x != INF else current_offset_position.x) if forward else (end_offset_position.x if end_offset_position.x != INF else current_offset_position.x)
	var starting_pos_y : float = (start_offset_position.y if start_offset_position.y != INF else current_offset_position.y) if forward else (end_offset_position.y if end_offset_position.y != INF else current_offset_position.y)
	(_affected_node as Control).offset_transform_position = Vector2(starting_pos_x, starting_pos_y)
	
	# Tween along the curve and lerp towards the sampled point
	tween.tween_method(
		func (progress : float): # DON'T WORRY ABOUT IT JUST PASSES IN PROGRESS -> PROGRESS IS A NUMBER FROM THE MIN TO MAX VALUES
			var curve_progress : float = curve.sample_baked(progress)
			var target_pos_x : float = (end_offset_position.x if end_offset_position.x != INF else current_offset_position.x) if forward else (start_offset_position.x if start_offset_position.x != INF else current_offset_position.x)
			var target_pos_y : float = (end_offset_position.y if end_offset_position.y != INF else current_offset_position.y) if forward else (start_offset_position.y if start_offset_position.y != INF else current_offset_position.y)
			(_affected_node as Control).offset_transform_position = (Vector2(starting_pos_x, starting_pos_y)).lerp(Vector2(target_pos_x, target_pos_y), curve_progress)
			,
		curve.min_domain,
		curve.max_domain,
		tween_duration
	)


func _custom_tween_offset_rotation(tween : Tween, tween_duration : float, _affected_node : Node, curve : Curve, forward : bool = true) -> void:
	# Set the starting from -> this exists because MethodTweener does not have the .from() function
	var starting_rot : float = (start_offset_rotation if start_offset_rotation != INF else current_offset_rotation) if forward else (end_offset_rotation if end_offset_rotation != INF else current_offset_rotation)
	(_affected_node as Control).offset_transform_rotation = starting_rot
	
	# Tween along the curve and lerp towards the sampled point
	tween.tween_method(
		func (progress : float): # DON'T WORRY ABOUT IT JUST PASSES IN PROGRESS -> PROGRESS IS A NUMBER FROM THE MIN TO MAX VALUES
			var curve_progress : float = curve.sample_baked(progress)
			var target_rot : float = (end_offset_rotation if end_offset_rotation != INF else current_offset_rotation) if forward else (start_offset_rotation if start_offset_rotation != INF else current_offset_rotation)
			(_affected_node as Control).offset_transform_rotation = lerpf(starting_rot, target_rot, curve_progress)
			,
		curve.min_domain,
		curve.max_domain,
		tween_duration
	)


func _custom_tween_offset_scale(tween : Tween, tween_duration : float, _affected_node : Node, curve : Curve, forward : bool = true) -> void:
	# Set the starting from -> this exists because MethodTweener does not have the .from() function
	var starting_scale_x : float = (start_offset_scale.x if start_offset_scale.x != INF else current_offset_scale.x) if forward else (end_offset_scale.x if end_offset_scale.x != INF else current_offset_scale.x)
	var starting_scale_y : float = (start_offset_scale.y if start_offset_scale.y != INF else current_offset_scale.y) if forward else (end_offset_scale.y if end_offset_scale.y != INF else current_offset_scale.y)
	(_affected_node as Control).offset_transform_scale = Vector2(starting_scale_x, starting_scale_y)
	
	# Tween along the curve and lerp towards the sampled point
	tween.tween_method(
		func (progress : float): # DON'T WORRY ABOUT IT JUST PASSES IN PROGRESS -> PROGRESS IS A NUMBER FROM THE MIN TO MAX VALUES
			var curve_progress : float = curve.sample_baked(progress)
			var target_scale_x : float = (end_offset_scale.x if end_offset_scale.x != INF else current_offset_scale.x) if forward else (start_offset_scale.x if start_offset_scale.x != INF else current_offset_scale.x)
			var target_scale_y : float = (end_offset_scale.y if end_offset_scale.y != INF else current_offset_scale.y) if forward else (start_offset_scale.y if start_offset_scale.y != INF else current_offset_scale.y)
			(_affected_node as Control).offset_transform_position = (Vector2(starting_scale_x, starting_scale_y)).lerp(Vector2(target_scale_x, target_scale_y), curve_progress)
			,
		curve.min_domain,
		curve.max_domain,
		tween_duration
	)
#endregion


## Set the current offset transform values when the tween is run
func set_current_values(_affected_node : Control) -> void:
	current_offset_position = _affected_node.offset_transform_position
	current_offset_rotation = _affected_node.offset_transform_rotation
	current_offset_scale = _affected_node.offset_transform_scale
