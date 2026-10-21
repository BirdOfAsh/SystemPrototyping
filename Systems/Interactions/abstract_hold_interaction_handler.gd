@abstract class_name AbstractHoldInteractionHandler extends AbstractInteractionHandler

var hold_threshold_ms : float = 1500
var is_holding : bool = false
var hold_start_timestamp : float = INF


@abstract func is_correct_input_just_pressed() -> bool

@abstract func is_correct_input_held() -> bool


## For hold inputs, do not override this function. Instead override:
## [is_correct_input_just_pressed] and
## [is_correct_input_held]
func is_correct_input_given() -> bool:
	if is_correct_input_just_pressed():
		hold_start_timestamp = Time.get_ticks_msec()
		return false
	
	if is_correct_input_held():
		if Time.get_ticks_msec() - hold_start_timestamp > hold_threshold_ms:
			hold_start_timestamp = INF
			return true
	
	return false
