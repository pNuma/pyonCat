extends Control

func _ready():
	#AudioManager.play_bgm(AudioManager.title_music)
	$CanvasLayer/cat_anim/cat.animation = "default"
	update_highscore_display()

# どのUI要素にも処理されなかった入力が、最後にこの関数に届きます
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		get_viewport().set_input_as_handled()
		match My_Global.current_select:
			"START":
				$CanvasLayer/cat_anim/cat.animation = "decision"
				AudioManager.play_se(AudioManager.decision_sound)
				await get_tree().create_timer(1.0).timeout
				#queue_free()
				get_tree().change_scene_to_file("res://Scenes/main.tscn")
			"TUTORIAL":
				print("TUTORIAL")
				# ここにオプション画面を開く処理を書く
			"OPTION":
				print("OPTION")
				# ここにオプション画面を開く処理を書く
			"EXIT":
				get_tree().quit()
			_: # 上記のいずれでもない場合
				pass 
	
	# ハイスコア表示を更新するための関数
func update_highscore_display() -> void:
	# My_Globalから現在のハイスコアを取得
	$CanvasLayer/HighScoreLabelBg/HighScoreLabel/HighScore.text = str(My_Global.high_score)
