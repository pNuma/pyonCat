extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/cat_anim/cat.animation = "default"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	$CanvasLayer/cat_anim/cat.animation = "decision"
	await get_tree().create_timer(1.0).timeout
	queue_free()
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
