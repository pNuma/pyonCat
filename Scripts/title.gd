extends Control

@onready var start_button = $CanvasLayer/SelectButtonBOX/StartButton
@onready var tutorial_button = $CanvasLayer/SelectButtonBOX/TutorialButton
@onready var options_button = $CanvasLayer/SelectButtonBOX/OptionButton
@onready var exit_button = $CanvasLayer/SelectButtonBOX/ExitButton
@onready var cursor = $CanvasLayer/SelectCan 

func _ready():
	AudioManager.play_bgm(AudioManager.title_music)
	start_button.focused.connect(_on_button_focused)
	tutorial_button.focused.connect(_on_button_focused)
	options_button.focused.connect(_on_button_focused)
	exit_button.focused.connect(_on_button_focused)
	$CanvasLayer/cat_anim/cat.animation = "default"
	update_highscore_display()
	
	cursor.move_to_target_instantly(start_button)
	start_button.grab_focus()

func _on_button_focused(button_node):
	My_Global.current_select = button_node.select_id
	cursor.move_to_target_with_tween(button_node)

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
