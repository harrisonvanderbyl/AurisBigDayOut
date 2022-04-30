extends StaticBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
var oldpos = Vector3(0.0,0.0,0.0)
func _physics_process(delta):
	constant_linear_velocity = transform.origin-oldpos
	oldpos = transform.origin
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
