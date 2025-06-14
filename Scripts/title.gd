extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	#AudioManager.play_bgm(AudioManager.title_music)
	$CanvasLayer/cat_anim/cat.animation = "default"
	update_highscore_display()


func _on_start_button_pressed():
	$CanvasLayer/cat_anim/cat.animation = "decision"
	AudioManager.play_se(AudioManager.decision_sound)
	await get_tree().create_timer(1.0).timeout
	#queue_free()
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	
	# ハイスコア表示を更新するための関数
func update_highscore_display() -> void:
	# My_Globalから現在のハイスコアを取得
	$CanvasLayer/HighScoreLabelBg/HighScoreLabel/HighScore.text = str(My_Global.high_score)
