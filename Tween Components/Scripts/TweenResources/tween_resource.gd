@abstract class_name TweenResource extends Resource

@abstract func tween_properties(tween : Tween, tween_duration : float, _affected_node : Node, forward : bool = true) -> void

@abstract func custom_tween_properties(tween : Tween, tween_duration : float, _affected_node : Node, curve : Curve, forward : bool = true) -> void

@abstract func set_current_values(_affected_node) -> void

@abstract func _set_reset_values(_affected_node) -> void

@abstract func _reset_values(_affected_node) -> void
