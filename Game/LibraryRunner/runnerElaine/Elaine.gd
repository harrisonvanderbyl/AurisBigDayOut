extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var run = false
var segment = preload("res://Game/LibraryRunner/segment/SegmentManager.tscn")
var d = 0;
var segs = []
var tp = 0;
var dis = 52

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)
		var rb = load("res://Game/Effects/Fireball.tscn").instance()
		rb.transform.origin = transform.origin
func _physics_process(delta):
	if(run):
		tp+=1
		if(tp>24):
			transform.origin.z += 1
			
			if(transform.origin.z>d+dis):
				d = transform.origin.z
				var l = segment.instance()
				get_parent().add_child(l)
				l.transform.origin.z = transform.origin.z+dis*6
				segs.append(l)
				if(segs.size() > 7):
					segs.pop_front().queue_free()
				
	if(Input.is_mouse_button_pressed(1)):
		run=true
		$AnimationTree["parameters/conditions/run"]=true
