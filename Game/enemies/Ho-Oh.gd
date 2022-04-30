extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var state = "null"
var health = 1000
var attacklength = 2
var attacktimer = attacklength
onready var fb = load("res://Game/Effects/Ho-Oh-FB.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_hit():
	health-=get_parent().strength
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(get_parent().finished):
		attacktimer -= delta
		if(attacktimer<0):
			attacktimer = attacklength
			match(round(rand_range(0,7))):
				1.0:flameAttack(-15)
				2.0:flameAttack(-10)
				3.0:flameAttack(-35)
				4.0:shooting()
				5.0:shooting()
				6.0:shooting()
				_:idle()
				
			
		$FlameThrower.emitting = state=="flameThrower"
		match(state):
			"flameThrower":
				$FlameThrower.rotation.y = sin(attacktimer*3.1415)*3.1415/2.0
			"shooting":
				shootAmount((get_parent().target-$FlameThrower.global_transform.origin).normalized(),rand_range(0,7),attacktimer)
func flameAttack(angle):
	state = "flameThrower"
	$FlameThrower.rotation.z = deg2rad(angle)
	
func idle():
	state = "idle"
	
func shooting():
	state = "shooting"

func shootFireBall(pos,dir):
	var rb = fb.instance()
	rb.velocity = dir
	get_parent().add_child(rb)
	rb.global_transform.origin = $FlameThrower.global_transform.origin+pos

func shootAmount(dir,amount,spread):
	for z in range(0,amount):
		shootFireBall(Vector3(spread*sin(2.0*3.2425*z/amount),spread*cos(2.0*3.1415*z/amount),0),dir)

func _on_flamehurt_body_entered(body):
	pass # Replace with function body.
