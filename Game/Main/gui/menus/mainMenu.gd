extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
export(PackedScene) var tavern
export(PackedScene) var birb


func _on_Button_button_down():
	get_tree().change_scene_to(birb)


func _on_Button2_button_down():
	get_tree().change_scene_to(tavern)
