tool extends Path


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	curve.clear_points()
	for i in range(0,101):
		var m = (i/100.0)*3.1415*4 + 3.1415
		curve.add_point(Vector3(cos(m/2),0.0,sin(m)))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
