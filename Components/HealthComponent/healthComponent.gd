class_name HealthComponent
extends Node

##The max health of this component as an integer
@export var maxHealth : int = 0
@onready var currentHealth : int = maxHealth


func damage(damageStat : int) -> void:
	currentHealth = clampi(currentHealth - damageStat, 0, maxHealth)
	if currentHealth == 0:
		get_parent().queue_free()
