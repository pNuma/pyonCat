extends Control

@onready var bgm_slider: HSlider = $MarginContainer/VBoxContainer/BGMSlider
@onready var se_slider: HSlider = $MarginContainer/VBoxContainer/SESlider

func _ready() -> void:
	var bgm_bus_idx = AudioServer.get_bus_index("BGM")
	var se_bus_idx = AudioServer.get_bus_index("SE")
	
	bgm_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bgm_bus_idx))
	se_slider.value = db_to_linear(AudioServer.get_bus_volume_db(se_bus_idx))

# BGMスライダー
func _on_bgm_slider_value_changed(value: float) -> void:
	var bgm_bus_idx = AudioServer.get_bus_index("BGM")
	AudioServer.set_bus_volume_db(bgm_bus_idx, linear_to_db(value))

# SEスライダー
func _on_se_slider_value_changed(value: float) -> void:
	var se_bus_idx = AudioServer.get_bus_index("SE")
	AudioServer.set_bus_volume_db(se_bus_idx, linear_to_db(value))

# 戻るボタン
func _on_back_button_pressed() -> void:
	My_Global.volume_bgm = bgm_slider.value
	My_Global.volume_se = se_slider.value
	
	print(My_Global.volume_se)

	My_Global.save_data()
	get_tree().change_scene_to_file("res://Scenes/title.tscn")
