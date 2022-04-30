extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(Array,PackedScene) var options= []

# Called when the node enters the scene tree for the first time.
func _ready():
	var mm = round(rand_range(0,options.size()-1))
	var xz = options[mm].instance()
	add_child(xz)


# Called every frame. 'delta' is the elapsed time since the previous frame.
var chs = 5.0;
func _process(delta):
	chs -= delta
	if(chs < 0 ):
		chs = 5.0
		var z = get_parent().target.z-4
		if(global_transform.origin.z < z):
			queue_free()
