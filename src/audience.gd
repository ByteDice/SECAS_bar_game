extends Node2D


func _ready():
	var v: bool = randi_range(0, 1) == 0
	if $Anchor/Audience1 == null or $Anchor/Audience2 == null:
		return
	
	$Anchor/Audience1.visible = v
	$Anchor/Audience2.visible = not v

	$AnimationPlayer.speed_scale = randf_range(0.75, 1.25)
	await get_tree().create_timer(randf_range(0, 2)).timeout
	$AnimationPlayer.play("bounce")
