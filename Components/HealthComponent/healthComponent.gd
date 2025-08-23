class_name HealthComponent
extends Node

##The max health of this component as an integer
@export var maxHealth : int = 0
@onready var currentHealth : int = maxHealth


func damage(damageStat : DamageStats) -> void:
	currentHealth = clampi(currentHealth - damageStat.getDamageAmount(), 0, maxHealth)
