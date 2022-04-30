tool extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func addItem(text):
	var l = Label.new()
	l.text = text
	add_child(l)
	move_child(l,0)
	for ch in get_children().size():
		get_child(ch).self_modulate = Color(1,1,1, 1-ch/5.0)
		if(ch > 10):
			get_child(ch).queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.

