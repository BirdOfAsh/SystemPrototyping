class_name Utils extends Node

static func remap_with_clamp(val : float, start_min : float, start_max : float, target_min : float, target_max : float) -> float:
	return clampf(remap(val, start_min, start_max, target_min, target_max), target_min, target_max)


static func nearly_equal(a: float, b: float, epsilon: float = 1e-9) -> bool:
	return absf(a - b) < epsilon


static func disconnect_signal(signal_ref : Signal, callable : Callable) -> void:
	if signal_ref.is_connected(callable):
		signal_ref.disconnect(callable)
	else:
		push_warning("Signal %s tried to disconnect from %s but there was no connection" % [signal_ref, callable])
		push_warning(Engine.capture_script_backtraces(true)) 


static func trace_error(error : String) -> void:
	printerr(error)
	printerr(Engine.capture_script_backtraces(true))
