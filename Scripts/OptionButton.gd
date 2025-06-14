extends Button

#OptionButtonがフォーカスされているとき
func _on_option_button_focus_entered():
	AudioManager.play_se(AudioManager.select_sound)
	My_Global.can_pos = self.global_position
	self_modulate = Color.LIGHT_CORAL
	My_Global.current_select="OPTION"


func _on_option_button_focus_exited():
	self_modulate = Color(1,1,1,1)
