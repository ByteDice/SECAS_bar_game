extends CharacterBody2D


@export var speed: float = 1.0
@export var increment: float = 0.01


func _process(delta: float):
	if $AnimationPlayer.is_playing(): return
	
	$AnimationPlayer.play("sway")
	speed += increment
	$AnimationPlayer.speed_scale = speed
