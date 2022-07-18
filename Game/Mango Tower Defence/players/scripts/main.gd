extends Spatial


# Declare member variables here. Examples:
# var a = 2
var targetmov = Vector3(0.0,0.0,0.0)
# var b = "text"
func getMouseIntersect(ev):
	var camera = get_viewport().get_camera()
	var camera_from = camera.project_ray_origin(ev.position)
	var camera_to = camera.project_ray_normal(ev.position)

	var n = Vector3(0, 1, 0) # plane normal
	var p = camera_from # ray origin
	var v = camera_to # ray direction
	var d = 0 # distance of the plane from origin
	var t = - (n.dot(p) + d) / n.dot(v) # solving for plain/ray intersection

	var block_position = p + t * v
	return block_position
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _process(delta):
	var dir = (transform.origin.direction_to(targetmov) as Vector3)
	
	if(transform.origin.distance_to(targetmov)>0.2):
		transform.origin += dir.normalized() * 0.1
		setAction("running")
	else:
		setAction("notRunning")
		
	rotation.y = lerp_angle(rotation.y,atan2(dir.x,dir.z),0.1)
	if(Input.is_action_just_pressed("ui_accept")):
		setAction("spike")
func _input(event):
	if(event is InputEventMouseButton):
		var intersect = getMouseIntersect(event)
		targetmov = intersect
	
func setAction(action):
	$AnimationTree["parameters/conditions/running"] = false
	$AnimationTree["parameters/conditions/notRunning"] = false
	$AnimationTree["parameters/conditions/spike"] = false
	$AnimationTree["parameters/conditions/aoe"] = false
	
	$AnimationTree["parameters/conditions/"+action] = true
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
