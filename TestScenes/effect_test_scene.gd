extends Node

@onready var control_tween: ControlTween = $Control/TextureRect/ControlTween as ControlTween


func _ready() -> void:
	control_tween.tween_finished.connect(tween_test)


func tween_test() -> void:
	print('yuppers')
