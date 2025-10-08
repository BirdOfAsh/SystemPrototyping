@tool class_name GeneralButton extends TextureButton

signal buttonPressed()
##If included, will display the selection component and play it's animation when hovering over the button
@export var selectComponent : SelectionComponent
##This button updates the pivot offset to be the center of the button
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
