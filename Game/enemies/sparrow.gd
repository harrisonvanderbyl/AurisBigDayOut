tool extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
#	rotation.y = rand_range(0.0,3.1415)
func yell():
	var mm = $Path/PathFollow/yelarea.get_overlapping_areas()
	if(mm.size()>0):
		var a = mm[0]
		var dir = a.global_transform.origin - global_transform.origin
		var z = load("res://Game/Effects/Sonic.tscn").instance()
		z.transform.origin = global_transform.origin
		z.velocity = (dir as Vector3).normalized()
		get_parent().add_child(z)

# Called every frame. 'delta' is the elapsed time since the previous frame.
var chs = 5.0;
func _process(delta):
	if(rand_range(0,200)>199):
		yell()
	$Path/PathFollow.offset+=delta
	chs -= delta
	if(chs < 0 ):
		chs = 5.0
		var z = get_parent().target.z-4
		if(global_transform.origin.z < z):
			queue_free()





	


func _on_StaticBody_body_entered(body):
	body.col()
	get_parent().sparrowDied(round(rand_range(1,44)))
	queue_free()
