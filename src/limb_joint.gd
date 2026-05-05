extends Marker2D


#var v_tween = get_tree().create_tween()
var limb: RigidBody2D


func _ready():
	setVisible(false)


func setVisible(v: bool):
	$Sprite2D.visible = v


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body != limb: return
	if limb.held:
		limb.anchored = true
		
