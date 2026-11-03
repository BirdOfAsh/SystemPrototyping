class_name PhysObjPicker extends Marker3D

@export var pull_strength : float = 0.0

signal try_pick_up

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		try_pick_up.emit()
