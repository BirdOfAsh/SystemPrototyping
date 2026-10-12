## This camera class is an augmented version of the base [Camera] class set up with
## export attributes to work with dynamic depth of field.
class_name DyamicDepthOfFieldCamera extends Camera3D

## The ray that collides with objects to gauge distance.
@export var distance_ray: RayCast3D
## The max distance the ray can go -> this sets the endpoint of the ray.
@export var max_ray_distance : float = 100.0
## The speed at which blur refocuses.
@export var focus_speed : float = 6.0
## The amount of blur applied to the camera on a 0 -> 1 range.
@export var blur_amount : float = 0.1
## The multiplier of distance it takes to go from no blur to full blur once it reaches
## the distance threshold. (0 -> 1)
@export var blur_transition_ratio : float = 0.5

@export var blur_transition_curve : Curve

## This is the camera's attributes which will for DDOF with be [CameraAttributesPractical].
var cam_attributes : CameraAttributesPractical
## The distance that the object is in focus, decided by the point of collision
var focus_distance : float


func _ready() -> void:
	set_camera_attribute()
	set_initial_ray_parameters()


func _process(_delta: float) -> void:
	var distance_to_collision : float
	distance_ray.force_raycast_update()
	
	# If the ray collides, get the distance from the ray to the collision point
	if distance_ray.is_colliding():
		distance_to_collision = distance_ray.global_position.distance_to(distance_ray.get_collision_point())
	else:
		# Set the default distance to max, and only override it if it collides
		distance_to_collision = max_ray_distance
		
	focus_distance = distance_to_collision
	cam_attributes.dof_blur_far_distance = focus_distance
	cam_attributes.dof_blur_far_transition = focus_distance * blur_transition_ratio
	cam_attributes.dof_blur_near_distance = focus_distance / blur_transition_ratio
	cam_attributes.dof_blur_near_distance = 0.4


## Set up the camera attribute if it's not already assigned
func set_camera_attribute() -> void:
	if self.attributes == null:
		self.attributes = CameraAttributesPractical.new()
	
	cam_attributes = self.attributes as CameraAttributesPractical
	cam_attributes.dof_blur_amount = blur_amount
	cam_attributes.dof_blur_far_enabled = true
	cam_attributes.dof_blur_near_enabled = true




func set_initial_ray_parameters() -> void:
	distance_ray.target_position = Vector3(0, 0, -max_ray_distance)
