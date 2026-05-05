extends Control


var main_menu = preload("res://scenes/main_menu.tscn")


func trigger():
	$Survived.text = "Time Spent Surviving the Rapture: " \
		+ str(int($/root/Node2D.time_survived))
	self.visible = true
	$AnimationPlayer.play("GameOver")


func _ready():
	self.visible = false


func end():
	var menu = main_menu.instantiate()
	var tree = get_tree()
	tree.root.add_child(menu)
	var old_scene = tree.current_scene
	tree.current_scene = menu
	old_scene.free()


func _on_back_to_menu_pressed():
	end()
