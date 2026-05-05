extends Node2D


var time_survived: float = 0.0


func _ready():
	get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_VIEWPORT


func _process(delta: float):
	time_survived += delta
