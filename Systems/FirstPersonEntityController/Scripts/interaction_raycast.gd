class_name InteractionRaycast extends RayCast3D

const INTERACTION_LAYER : int = 4

signal colliding_with_interactable

#region listenable properties
signal is_interaction_enabled_value_changed(value : bool)

var is_interaction_enabled : bool = true:
	set(value):
		is_interaction_enabled = value
		is_interaction_enabled_value_changed.emit(is_interaction_enabled)
#endregion


func _init() -> void:
	# clear all default collision masks
	self.collision_mask = 0
	# enable ONLY the value defined as the designated INTERACTION_LAYER
	self.set_collision_mask_value(INTERACTION_LAYER, true)
	# make sure we can collide with areas!
	self.collide_with_areas = true


func _physics_process(_delta: float) -> void:
	self.force_raycast_update()
	
	if !is_interaction_enabled:
		return
	if !is_colliding():
		return
	
	var interaction_area : AbstractInteractionArea = get_collider() as AbstractInteractionArea
	
	if interaction_area == null:
		Utils.trace_error("%s: Entity's interaction raycast is colliding with %s which is not derived from AbstractInteractionArea" % [self.name, get_collider()])
		return
	
	colliding_with_interactable.emit()
	interaction_area.handle_raycast_collision(self)
