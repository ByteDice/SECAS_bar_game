extends Control


func _ready():
	get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_VIEWPORT


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")
