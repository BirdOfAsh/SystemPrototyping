@tool class_name GeneralButton extends TextureButton

signal buttonPressed()

@export var selectComponent : SelectionComponent

@export_tool_button("Update Pivot Offset", "Callable") var pOffsetAction : Callable = updatePivotOffset


func updatePivotOffset():
	pivot_offset = (size / 2)


func _on_pressed() -> void:
	buttonPressed.emit()


func _on_mouse_entered() -> void:
	if selectComponent:
		selectComponent.playAnim()


func _on_mouse_exited() -> void:
	if selectComponent:
		selectComponent.stopAnim()
