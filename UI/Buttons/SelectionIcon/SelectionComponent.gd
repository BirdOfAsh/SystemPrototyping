@tool class_name SelectionComponent extends Node2D

@export var selection_icon_left: Sprite2D
@export var selection_icon_right: Sprite2D

@export_range(5, 50, 5) var xOffset : int:
	set(newXOffset):
		xOffset = newXOffset
		updateOffset()

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func updateOffset():
	if selection_icon_left and selection_icon_right:
		selection_icon_left.offset.x = -xOffset
		selection_icon_right.offset.x = xOffset


func playAnim():
	animation_player.play("Hover")
	show()


func stopAnim():
	animation_player.stop()
	hide()
