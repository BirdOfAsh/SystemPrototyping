## This is a PhysObj3DComponent class for handling picking up PhysicalObject3D
class_name PickablePhysObj3DComponent extends PhysObj3DComponent


## If the object is being pickup up
var picked : bool = false
## If the object is being hovered by a [RayPhysObj3D]
var hovered : bool = false

func _init(new_phys_obj : PhysicsObject3D) -> void:
	super(new_phys_obj)
	
	phys_obj.ray_entered.connect(phys_obj_ray_entered)


func phys_obj_ray_entered(ray : RayPhysObj3D) -> void:
	ray.request_pick_up.connect(pick_up)
	hovered = true


func phys_obj_ray_exited(ray : RayPhysObj3D) -> void:
	ray.request_pick_up.disconnect(pick_up)
	hovered = false


func pick_up() -> void:
	if hovered and not picked:
		pass
