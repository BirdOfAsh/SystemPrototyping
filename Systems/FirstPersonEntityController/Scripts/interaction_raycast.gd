class_name InteractionRaycast extends RayCast3D

@export var first_person_entity_controller : FirstPersonEntityController

signal colliding_with_interactable

func _physics_process(_delta: float) -> void:
	self.force_raycast_update()
	
	if !is_colliding() || !first_person_entity_controller.interaction_enabled:
		return
	
	var collider : Object = get_collider()
	
	if collider is not Node:
		return
	
	# grab group name from interaction handler so its ALWAYS checking against the right val
	if !(collider as Node).is_in_group(AbstractInteractionHandler.get_group_name()):
		printerr("%s: Player's interaction raycast is colliding with %s which is not in the 'Interactable' group" % [self.name, collider])
		return
	
	if "interaction_handler" not in collider:
		printerr("%s: Player's interaction raycast is colliding with %s which does not have a interaction_handler" % [self.name, collider])
		return
	
	if (collider.interaction_handler as AbstractInteractionHandler).is_enabled == false:
		return
	
	colliding_with_interactable.emit()
	(collider.interaction_handler as AbstractInteractionHandler).handle_raycast_collision(first_person_entity_controller)
