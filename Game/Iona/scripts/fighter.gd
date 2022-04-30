extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var idealWalkingSpeed = 6
var runThreshold = 16
export(NodePath) var otherPlayer;
export(String) var player = "0"
export(bool) var isLeft setget setDirection
export(float) var xvel setget setXVelocity
var gotHit=""
# Called when the node enters the scene tree for the first time.
func _process(delta):
	isLeft = isLeft
	attack("punch","punch",false,false)
	attack("legSweep","sweep",true,false)
	attack("chestKick","chestKick",true,false)
	attack("elbow","elbow",false,false)
	attack("headKick","headKick",true,false)
	setDirection(transform.origin.x < get_node(otherPlayer).transform.origin.x)
	setXVelocity(Input.get_vector("ml"+player, "mr"+player, "mu"+player, "md"+player).x*30)
	rotation.y = lerp_angle(rotation.y,3.1415+((3.0*3.1415/2.0) if isLeft else 3.1415/2.0),0.15)
	transform.origin.x = clamp(transform.origin.x+xvel*delta,-30,30)
	damageCheck()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func setDirection(isLeftin):
	if(is_inside_tree()):
		$AnimationTree["parameters/conditions/isLeft"] =isLeftin
		$AnimationTree["parameters/conditions/isRight"] =!isLeftin
	isLeft = isLeftin

func getDamage(target): #Face,Body
	$AnimationTree["parameters/right/conditions/hitTo"+target] = gotHit == target
	$AnimationTree["parameters/left/conditions/hitTo"+target] = gotHit == target
	
func damageCheck():
	getDamage("Face")
	getDamage("Body")
	gotHit = ""

func attack(move,isPressed,modKick,modSpecial):
	var activate = Input.is_action_just_pressed(isPressed+player)&&(modKick==Input.is_action_pressed("modKick"+player))&&(modSpecial==Input.is_action_pressed("modSpecial"+player))
	$AnimationTree["parameters/right/conditions/"+move] = activate
	$AnimationTree["parameters/left/conditions/"+move] = activate
func setXVelocity(vel):
	#Input.is_action_just_pressed("ui_cancel")
	
	xvel = vel
	if(is_inside_tree()):
		
		
		$AnimationTree["parameters/right/Movement/conditions/moving"] =vel!=0.0
		$AnimationTree["parameters/right/Movement/conditions/notMoving"] =vel == 0.0
		$AnimationTree["parameters/right/Movement/BlendTree/StateMachine/conditions/running"] =vel<-runThreshold
		$AnimationTree["parameters/right/Movement/BlendTree/StateMachine/conditions/notRunning"] =vel>=-runThreshold
		$AnimationTree["parameters/right/Movement/BlendTree/StateMachine/conditions/walkingBackwards"] =vel>0.0
		$AnimationTree["parameters/right/Movement/BlendTree/StateMachine/conditions/notWalkingBackwards"] =vel<=0.0
		
		$AnimationTree["parameters/right/Movement/BlendTree/TimeScale/scale"] = abs(vel/idealWalkingSpeed)
		$AnimationTree["parameters/left/Movement/BlendTree/TimeScale/scale"] = abs(vel/idealWalkingSpeed)
		
		$AnimationTree["parameters/left/Movement/conditions/moving"] =vel!=0.0
		$AnimationTree["parameters/left/Movement/conditions/notMoving"] =vel == 0.0
		$AnimationTree["parameters/left/Movement/BlendTree/StateMachine/conditions/running"] =vel>runThreshold
		$AnimationTree["parameters/left/Movement/BlendTree/StateMachine/conditions/notRunning"] =vel<=runThreshold
		$AnimationTree["parameters/left/Movement/BlendTree/StateMachine/conditions/walkingBackwards"] =vel<0.0
		$AnimationTree["parameters/left/Movement/BlendTree/StateMachine/conditions/notWalkingBackwards"] =vel>=0.0
	
	
	
	#$AnimationTree["parameters/right/Movement/TimeScale/TimeScale"] = vel/idealWalkingSpeed
	#$AnimationTree["parameters/left/Movement/TimeScale/TimeScale"] = vel/idealWalkingSpeed


func _on_HitToBody_body_entered(body):
	gotHit = "Body"


func _on_HitToFace_body_entered(body):
	gotHit = "Face"
