extends Spatial

var wikedsynonyms = [
  "corrupt",
  "depraved",
  "dissolute",
  "immoral",
  "incontinent",
  "incorrigible",
  "licentious",
  "profligate",
  "shameless",
  "sinful",
  "uncontrolled",
  "unprincipled",
  "unrestrained",
  "wanton",
  "wicked",
  "wild",
  "awful",
  "bad",
  "barbaric",
  "beastly",
  "desperate",
  "diabolical",
  "fiendish",
  "flagrant",
  "godawful",
  "grody",
  "gross",
  "hairy",
  "heinous",
  "lousy",
  "monstrous",
  "nefarious",
  "rotten",
  "scandalous",
  "shocking",
  "villainous",
  "wicked ",
  "base",
  "corrupt",
  "criminal",
  "delinquent",
  "evil",
  "iniquitous",
  "mean",
  "reprobate",
  "sinful",
  "vicious",
  "vile",
  "villainous",
  "wicked",
  "wrong ",
  "base",
  "corrupt",
  "criminal",
  "delinquent",
  "evil",
  "iniquitous",
  "mean",
  "reprobate",
  "sinful",
  "vicious",
  "vile",
  "villainous",
  "wicked",
  "wrong ",
  "baleful",
  "calamitous",
  "deadly",
  "deleterious",
  "destructive",
  "disastrous",
  "evil",
  "fatal",
  "harmful",
  "hurtful",
  "malefic",
  "noxious",
  "pernicious",
  "pestilent",
  "pestilential",
  "poisonous",
  "venomous",
  "wicked ",
];


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var maxmana = 100;
var maxhealth = 100;
var mana = 100;
var health = 100;
var manaregen = 20;
var healthregen = 0;
var strength = 20;
var experience = 0;
var experienceToNextLevel = 100;
var level = 1;
var statline = [2,2,0 if getNG() else 2,2,1]
var progress = 0.0
var finished = false
var dead = false;
var won = false;
var target = Vector3(0.0,0.0,0.0)
export(Array,PackedScene) var enemies
var birbtarget = Vector3(0.0,0.0,0.0)
var camtarget = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	pass # Replace with function body.

func _input(event):
	if(Input.is_key_pressed(KEY_ESCAPE)):
		get_tree().quit()
   # Mouse in viewport coordinates.
	if event is InputEventMouseButton and mana>strength:
		mana-=strength
		print("Mouse Click/Unclick at: ", event.position)
		var rb = load("res://Game/Effects/Fireball.tscn").instance()
		rb.transform.origin = $scene.transform.origin
		
		add_child(rb)
	elif event is InputEventMouseMotion:
		birbtarget.x = -event.position.x/300 +get_viewport().size.x/600
		birbtarget.y = -event.position.y/300 +get_viewport().size.y/600 + 0.6
		camtarget =  -event.position.x/600 +get_viewport().size.x/1200
	
	
func sparrowDied(lvl):
	$Control/VBoxContainer2.addItem("<You Have Defeated ["+wikedsynonyms[round(rand_range(0,wikedsynonyms.size()-1))]+" Sparrow](Sound "+str(lvl)+")!>")
	experience+=lvl
	
	$Control/VBoxContainer/Experience/exp.text = str(experience)+"/"+str(experienceToNextLevel)
	if(experience>experienceToNextLevel):
		level+=1
		experienceToNextLevel*=2
		$Control/VBoxContainer2.addItem("<You Have Reached Level "+str(level)+"!>")
		maxhealth += statline[0]
		maxmana += statline[1]
		healthregen += statline[2]
		manaregen += statline[3]
		strength += statline[4]
		
		$Control/VBoxContainer2.addItem("<Vitality +"+str(statline[0])+"!>")
		$Control/VBoxContainer2.addItem("<Intelligence +"+str(statline[1])+"!>")
		$Control/VBoxContainer2.addItem("<Endurance +"+str(statline[2])+"!>")
		$Control/VBoxContainer2.addItem("<Wisdom +"+str(statline[3])+"!>")
		$Control/VBoxContainer2.addItem("<Strength +"+str(statline[4])+"!>")
	$Control/VBoxContainer/WIS/exp.text = str(manaregen)
	$Control/VBoxContainer/END/exp.text = str(healthregen)
	$Control/VBoxContainer/STR/exp.text = str(strength)
# Print the size of the viewport.
# Called every frame. 'delta' is the elapsed time since the previous frame.
var prob = 0.1
func _process(delta):
	if(health < 0):dead = true;
	mana=min(maxmana,delta*manaregen+mana)
	health=min(maxhealth,delta*healthregen+health)
	$Control/VBoxContainer/ManaBar/TextureProgress.value=mana
	$Control/VBoxContainer/ManaBar/TextureProgress/CenterContainer/Label.text = "Fuel: "+str(round(mana))+"/"+str(maxmana)
	$Control/VBoxContainer/ManaBar/TextureProgress.max_value=maxmana
	$Control/VBoxContainer/Progress/TextureProgress.value = $scene.transform.origin.z
	$Control/VBoxContainer/Progress/TextureProgress.max_value = $scene2.transform.origin.z
	progress = $scene.transform.origin.z/$scene2.transform.origin.z
	finished = $scene.transform.origin.z > $scene2.transform.origin.z-2
	$Control/VBoxContainer/Progress/TextureProgress/CenterContainer/Label.text = str(round(100*progress))
	$Control/VBoxContainer/HealthBar/TextureProgress.value = health
	$Control/VBoxContainer/HealthBar/TextureProgress.max_value = maxhealth;
	$Control/VBoxContainer/HealthBar/TextureProgress/CenterContainer/Label.text = "Health: "+str(round(health))+"/"+str(maxhealth)
	if(finished||dead):
		$SpringArm/Spatial/Camera.set_perspective(70,0.05,100)
	if(randf() < prob+0.3*progress&&progress < 0.94&& !finished):
		var mm = load("res://Game/Effects/Scenery.tscn").instance()
		mm.transform = (mm.transform as Transform).scaled(Vector3(0.1,0.1,0.1))
		mm.transform.origin = $scene.transform.origin + Vector3(rand_range(-5,5),0.0,5)
		mm.transform.origin.y = 0
		add_child(mm)
		var nm = enemies[0].instance()
		nm.transform.origin = $scene.transform.origin + Vector3(rand_range(-5,5),0.0*rand_range(0,1),5)
		add_child(nm)
	$SpringArm.transform.origin.z = $scene.transform.origin.z
	if(!dead):
		
		$scene.transform.origin.x = lerp($scene.transform.origin.x,birbtarget.x,0.15)
		$scene.transform.origin.y = 0.5 if !finished else lerp($scene.transform.origin.y,birbtarget.y,0.15)
		$SpringArm.transform.origin.x = lerp($SpringArm.transform.origin.x, camtarget,0.05)
		$scene.rotation.y = -$scene.transform.origin.x + birbtarget.x
		$scene.rotation.x = abs(-$scene.transform.origin.x + birbtarget.x)/2.0 + $scene.transform.origin.y - birbtarget.y
	target = $scene.global_transform.origin
	if(!finished&&!dead):$scene.transform.origin.z += 1.0*delta
	if(finished||dead):$SpringArm.spring_length = lerp($SpringArm.spring_length,0.2,0.1)
	if(finished||dead):$WorldEnvironment.environment.dof_blur_near_amount = 0.0
	if(finished||dead):$SpringArm.rotation.x = lerp($SpringArm.rotation.x,deg2rad(-15.0),0.01)
	$Control/tryAgain.visible = dead
	if(dead):
		$scene.rotation *= 0.9
		$scene.transform.origin.y = lerp($scene.transform.origin.y,0.31,0.1)
		$SpringArm.transform.origin = $scene.transform.origin
		if($scene.transform.origin.y < 0.33):
			$scene/AshAnimation.visible = true
			$scene/Sketchfab_model.visible = false
	$Control/BossHealth.visible = finished
	$Control/BossHealth/TextureProgress.value = $scene2.health
	$"Control/Winner!".visible = won;
	if($scene2.health < 0):
		won = true;
		$scene2.visible = false;
func shake():
	$SpringArm/Spatial/Camera.shake()


func _on_YellTarget_body_entered(body):
	health -= 10


func _on_YellTarget_area_entered(area):
	if(area.has_method("getDamage")):
		health -= area.getDamage()


func _on_tryAgain_button_down():
	get_tree().reload_current_scene()


func _on_NG_button_down():
	save_game()
	get_tree().reload_current_scene()
func getNG():
	var isg = File.new()
	return isg.file_exists("user://savegame.save")
func save_game():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	save_game.store_line("NG+")
	save_game.close()
