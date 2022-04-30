tool extends OmniLight


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var tim = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	light_energy = 2.0+0.1*cos(tim*10)
	tim += 4.0* delta*rand_range(0.2,0.6)
	transform.origin.x = 0.03*sin(tim*5)
	transform.origin.y = 5+0.02*cos(tim*20)
