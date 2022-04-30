extends Camera


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var shaketimer = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func shake():
	shaketimer = 10.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	shaketimer = max(0.0,shaketimer-delta*8.0)
	rotation.x=sin(shaketimer*3.1415)*shaketimer*0.0001
