extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector3(0.0,0.0,0.0)
var timeout = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	timeout -= delta
	if(timeout < -10): queue_free()
	var cola = move_and_collide(velocity*delta*4.0)
	



	



