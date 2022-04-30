extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector3(0.0,0.0,4.0)
var timeout = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	timeout -= delta
	if(timeout < -10): queue_free()
	if(timeout < 1.0): 
		$OmniLight.light_energy = max(0.0,timeout*1.587)
	var cola = move_and_collide(velocity*delta)
	if(cola&&cola.collider && timeout > 1):
		if cola.collider.get_parent()&&cola.collider.get_parent().has_method("get_hit"):
			cola.collider.get_parent().get_hit()
		col()


func col():
	timeout = 0.8
	$MeshInstance.visible = false
	velocity*=0.0
	var fb = load("res://Game/Effects/Explosion.tscn").instance()
	add_child(fb)
	collision_layer = 0
	get_parent().shake()
	



