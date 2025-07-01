extends Control

@onready var bgm_slider: HSlider = $MarginContainer/VBoxContainer/SoundGroup/VBoxContainer/HBoxContainer/BGMSlider
@onready var se_slider: HSlider = $MarginContainer/VBoxContainer/SoundGroup/VBoxContainer/HBoxContainer2/SESlider
@onready var mute_checkbox: CheckBox = $MarginContainer/VBoxContainer/SoundGroup/VBoxContainer/HBoxContainer3/MuteCheckBox
@onready var fullscreen_checkbox: CheckBox = $MarginContainer/VBoxContainer/ScreenGroup/HBoxContainer4/FullscreenCheckBox
@onready var confirm_dialog = $ConfirmResetDialog

func _ready() -> void:
	var bgm_bus_idx = AudioServer.get_bus_index("BGM")
	var se_bus_idx = AudioServer.get_bus_index("SE")
	
	bgm_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bgm_bus_idx))
	se_slider.value = db_to_linear(AudioServer.get_bus_volume_db(se_bus_idx))
	mute_checkbox.button_pressed = My_Global.is_muted
	fullscreen_checkbox.button_pressed = My_Global.is_fullscreen
	
	bgm_slider.grab_focus()

# BGMスライダー
func _on_bgm_slider_value_changed(value: float) -> void:
	var bgm_bus_idx = AudioServer.get_bus_index("BGM")
	AudioServer.set_bus_volume_db(bgm_bus_idx, linear_to_db(value))

# SEスライダー
func _on_se_slider_value_changed(value: float) -> void:
	var se_bus_idx = AudioServer.get_bus_index("SE")
	AudioServer.set_bus_volume_db(se_bus_idx, linear_to_db(value))
	
# Masterバスのミュート状態を切り替え
func _on_mute_check_box_toggled(button_pressed: bool) -> void:
	AudioServer.set_bus_mute(0, button_pressed)

#フルスクリーン切り替え
func _on_fullscreen_check_box_toggled(button_pressed: bool) -> void:
	if button_pressed: 
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else: 
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

# 戻るボタン
func _on_back_button_pressed() -> void:
	My_Global.volume_bgm = bgm_slider.value
	My_Global.volume_se = se_slider.value
	My_Global.is_muted = mute_checkbox.button_pressed
	My_Global.is_fullscreen = fullscreen_checkbox.button_pressed
	
	My_Global.save_data()
	
	get_tree().change_scene_to_file("res://Scenes/title.tscn")


# ハイスコアをリセットボタン
func _on_reset_button_pressed() -> void:
	# 確認ダイアログを画面の中央に表示する
	confirm_dialog.popup_centered()

# 確認ダイアログ
func _on_confirm_reset_dialog_confirmed() -> void:
	My_Global.reset_highscore()
