extends Node2D


@export var release_timer_range: Vector2
@export var release_particles: GPUParticles2D
@export var bull: Node2D
@export var anchored: Array[bool] = [true, true, true, true]

@onready var joint_l_arm: Marker2D = bull.get_node("Bull/LimbJoint_LeftArm")
@onready var joint_r_arm: Marker2D = bull.get_node("Bull/LimbJoint_RightArm")
@onready var joint_l_leg: Marker2D = bull.get_node("Bull/LimbJoint_LeftLeg")
@onready var joint_r_leg: Marker2D = bull.get_node("Bull/LimbJoint_RightLeg")


var is_grabbed_anywhere: bool = false
var is_timer_active: bool = false
var children_ready: int = 0
var is_init: bool = false
var has_game_over: bool = false


func ready():
	$ArmL2.anchor = joint_l_arm
	$ArmR2.anchor = joint_r_arm
	$LegL2.anchor = joint_l_leg
	$LegR2.anchor = joint_r_leg
	
	$ArmL2.anchored = anchored[0]
	$ArmR2.anchored = anchored[1]
	$LegL2.anchored = anchored[2]
	$LegR2.anchored = anchored[3]
	is_init = true


func _process(delta: float):
	if children_ready == 4 and not is_init: ready()
	if not is_timer_active and not has_game_over: timer()


func release():
	if has_game_over: return
	
	var limbs = [
		$ArmL2,
		$ArmR2,
		$LegL2,
		$LegR2
	]
	
	var attempts: int = 0
	
	while true:
		attempts += 1
		
		if has_game_over or attempts > 50: return
		
		var i = limbs[randi_range(0, len(limbs) - 1)]
		if not i.anchored: continue
		i.anchored = false
		break
	
	var amount_unanchored = 0
	for i in limbs: if not i.anchored: amount_unanchored += 1
	
	if amount_unanchored < 4:
		release_particles.emitting = true
	else:
		$/root/Node2D/CanvasLayer/GameOver.trigger()


func timer():
	is_timer_active = true
	
	await get_tree().create_timer(randf_range(
		release_timer_range.x,
		release_timer_range.y
	)).timeout
	
	is_timer_active = false
	
	release_timer_range.x = max(0, release_timer_range.x - 0.1)
	release_timer_range.y = max(1, release_timer_range.y - 0.1)
	
	release()
