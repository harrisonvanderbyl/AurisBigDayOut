tool extends MeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var mycollider:Shape

# Called when the node enters the scene tree for the first time.
# Called when the node enters the scene tree for the first time.
func _ready():
	create_trimesh_collision()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
