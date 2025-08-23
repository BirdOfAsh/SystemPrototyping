class_name HitboxComponent
extends Area2D

##Gives a reference to a health component for calling damage functions
@export var healthComponent : HealthComponent


func callDamage(damageStat : DamageStats):
	if healthComponent:
		healthComponent.damage(damageStat)
