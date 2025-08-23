class_name HurtboxComponent
extends Area2D

##Gives a reference to a damage stat resource which stats are used to determine the effects of damage functions
@export var damageStat : DamageStats


func _on_area_entered(area: Area2D) -> void:
	if area is not HitboxComponent or !damageStat:
		return
	
	(area as HitboxComponent).callDamage(damageStat)
