extends Control

@onready var start_button = $CanvasLayer/SelectButtonBOX/StartButton
@onready var tutorial_button = $CanvasLayer/SelectButtonBOX/TutorialButton
@onready var options_button = $CanvasLayer/SelectButtonBOX/OptionButton
@onready var exit_button = $CanvasLayer/SelectButtonBOX/ExitButton
@onready var cursor = $CanvasLayer/SelectCan 

var is_busy: bool = false

func _ready():
	is_busy = false
	AudioManager.play_bgm(AudioManager.title_music)
	$CanvasLayer/cat_anim/cat.animation = "default"
	update_highscore_display()
	
	cursor.move_to_target_instantly(start_button)
	start_button.grab_focus()

func _on_button_focused(button_node):
	My_Global.current_select = button_node.select_id
	cursor.move_to_target_with_tween(button_node)

# この入力を「処理済み」にして、ビジー状態中のUIのフォーカス移動などを回避。
func _input(event: InputEvent) -> void:
	if is_busy:
		if event.is_action("ui_up") or event.is_action("ui_down") or event.is_action("ui_accept"):
			get_viewport().set_input_as_handled()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		get_viewport().set_input_as_handled()
		match My_Global.current_select:
			"START":
				is_busy = true
				#canvas_layer.process_mode = Node.PROCESS_MODE_DISABLED
				$CanvasLayer/cat_anim/cat.animation = "decision"
				AudioManager.play_se(AudioManager.decision_sound)
				await get_tree().create_timer(1.0).timeout
				#queue_free()
				#canvas_layer.process_mode = Node.PROCESS_MODE_INHERIT
				get_tree().change_scene_to_file("res://Scenes/main.tscn")
			"TUTORIAL":
				is_busy = true
				$CanvasLayer/cat_anim/cat.animation = "decision"
				AudioManager.play_se(AudioManager.decision_sound)
				await get_tree().create_timer(1.0).timeout
				get_tree().change_scene_to_file("res://Scenes/tutorial.tscn")
			"OPTION":
				is_busy = true
				$CanvasLayer/cat_anim/cat.animation = "decision"
				AudioManager.play_se(AudioManager.decision_sound)
				await get_tree().create_timer(1.0).timeout
				get_tree().change_scene_to_file("res://Scenes/option.tscn")
			"EXIT":
				get_tree().quit()
			_: # 上記のいずれでもない場合
				pass 
	
	# ハイスコア表示を更新するための関数
func update_highscore_display() -> void:
	$CanvasLayer/HighScoreLabelBg/HighScoreLabel/HighScore.text = My_Global.get_formatted_highscore_string()
