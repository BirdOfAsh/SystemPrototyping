class_name DamageStats
extends Resource

#### EDITOR VARIABLES ####
##The amount of damage that will be taken, as an integer
@export var damageAmount : int = 0
##The cooldown between when damage can be taken, in seconds
@export var cooldown : float = 0.0
##########################


#### GETTER FUNCTIONS ####
func getDamageAmount() -> int:
	return damageAmount


func getCooldown() -> float:
	return cooldown
##########################
