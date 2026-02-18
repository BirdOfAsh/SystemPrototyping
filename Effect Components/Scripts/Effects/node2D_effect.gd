@icon("uid://mc5sx2ggbl4q")
class_name Node2DEffect extends TweenEffect
## [Node2DEffect] is an extension of [TweenEffect] and additionally contains
## transform and [CanvasItem] parameters.

## The node which will have the effect applied.
@export var affected_node : Node2D


#region Transform Properties
@export_category("Transform Properties")

@export_group("Position")
## The position the tween will start at. [br]
## Has INF values by default, and will ignore individual x or y if left unchanged.
@export var start_position : Vector2 = Vector2.INF

## The position the tween will end at. [br]
## Has INF values by default, and will ignore individual x or y if left unchanged.
@export var end_position : Vector2 = Vector2.INF

@export_group("Rotation")

## The rotation amount is the rotation degrees the tween will start at. [br]
## Has INF value by default, and will ignore this parameter if unchanged.
@export var start_rotation : float = INF

## The rotation amount is the rotation degrees the tween will end at. [br]
## Has INF value by default, and will ignore this parameter if unchanged.
@export var end_rotation : float = INF

@export_group("Scale")

## The scale amount is the scale the tween will start at. [br]
## Has INF values by default, and will ignore individual x or y if left unchanged.
@export var start_scale : Vector2 = Vector2.INF

## The scale amount is the scale the tween will end at. [br]
## Has INF values by default, and will ignore individual x or y if left unchanged.
@export var end_scale : Vector2 = Vector2.INF
#endregion

#region CanvasItem Properties
@export_category("CanvasItem Properties")
@export_group("Visibility")

## The modulate the node will start at, if WHITE then will set to default. [br]
## If both modulate are the same, the tween will ignore modulation
@export var start_modulate : Color = Color.WHITE

## The modulate the node will end at, if WHITE then will set to default. [br]
## If both modulate are the same, the tween will ignore modulation
@export var end_modulate : Color = Color.WHITE

#endregion


func _ready() -> void:
	# Check if there is a node
	if !affected_node:
		return
	# Start effect if autostart is enabled
	if autostart:
		do_tween()

func do_tween() -> void:
	# Return if there is no node
	if !affected_node:
		printerr(self, "No node assigned to Node2D Effect")
		return
	
	# Create a new tween with given parameters
	reset_tween()
	
	# Set to infinitely loop 
	if loop:
		tween.set_loops()
	# Tween the positions if not default
	tween.tween_property(
		affected_node,
		"position:x",
		end_position.x if end_position.x != INF else affected_node.position.x,
		tween_duration
		).from(
			start_position.x if start_position.x != INF else affected_node.position.x
			)
	tween.tween_property(
		affected_node,
		"position:y",
		end_position.y if end_position.y != INF else affected_node.position.y,
		tween_duration
		).from(
			start_position.y if start_position.y != INF else affected_node.position.y
			)
	
	# Tween the rotation if not default
	tween.tween_property(
		affected_node,
		"rotation_degrees",
		end_rotation if end_rotation != INF else affected_node.rotation_degrees,
		tween_duration
		).from(
			start_rotation if start_rotation != INF else affected_node.rotation_degrees
			)
	
	# Tween the scale if not default
	tween.tween_property(
		affected_node,
		"scale:x",
		end_scale.x if end_scale.x != INF else affected_node.scale.x,
		tween_duration
		).from(
			start_scale.x if start_scale.x != INF else affected_node.scale.x
			)
	tween.tween_property(
		affected_node,
		"scale:y",
		end_scale.y if end_scale.y != INF else affected_node.scale.y,
		tween_duration
		).from(
			start_scale.y if start_scale.y != INF else affected_node.scale.y
			)
	
	# Tween modulate if start_modulate and end_modulate are not the smae
	if start_modulate != end_modulate:
		tween.tween_property(
			affected_node,
			"modulate",
			end_modulate,
			tween_duration
		).from(
			start_modulate
		)
	
	if loop:
		#tween.chain()
		
		do_tween_backward()
	
	await tween.finished

## Execute the do_tween function with start and end values reversed, meant to be used
## for looping. [br]
## Not meant to be used alone.
func do_tween_backward(reset : bool = false) -> void:
	# Reset if run only if the do_backwards is run alone
	if reset:
		reset_tween()

	# Tween the positions if not default
	tween.chain().tween_property(
		affected_node,
		"position:x",
		start_position.x if start_position.x != INF else affected_node.position.x,
		tween_duration
		).from(
			end_position.x if end_position.x != INF else affected_node.position.x
			)
	tween.tween_property(
		affected_node,
		"position:y",
		start_position.y if start_position.y != INF else affected_node.position.y,
		tween_duration
		).from(
			end_position.y if end_position.y != INF else affected_node.position.y
			)
	
	# Tween the rotation if not default
	tween.tween_property(
		affected_node,
		"rotation_degrees",
		start_rotation if start_rotation != INF else affected_node.rotation_degrees,
		tween_duration
		).from(
			end_rotation if end_rotation != INF else affected_node.rotation_degrees
			)
	
	# Tween the scale if not default
	tween.tween_property(
		affected_node,
		"scale:x",
		start_scale.x if start_scale.x != INF else affected_node.scale.x,
		tween_duration
		).from(
			end_scale.x if end_scale.x != INF else affected_node.scale.x
			)
	tween.tween_property(
		affected_node,
		"scale:y",
		start_scale.y if start_scale.y != INF else affected_node.scale.y,
		tween_duration
		).from(
			end_scale.y if end_scale.y != INF else affected_node.scale.y
			)
	
	# Tween modulate if start_modulate and end_modulate are not the smae
	if start_modulate != end_modulate:
		tween.tween_property(
			affected_node,
			"modulate",
			start_modulate,
			tween_duration
		).from(
			end_modulate
		)
