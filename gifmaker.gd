extends Viewport


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var frame = -400
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("save",frame)
	frame+=1
	if(frame>=0&&frame <= 15):
		var img:Image = get_texture().get_data()
		img.save_png("user://"+str(frame)+".png")
	
