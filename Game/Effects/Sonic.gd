extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector3(0.0,0.0,0.0)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
var lt = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	lt+= delta
	if(lt < 0):queue_free()
	transform.origin += velocity*delta
