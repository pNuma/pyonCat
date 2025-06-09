extends Button

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#ExitButtonがフォーカスされているとき
func _on_exit_button_focus_entered():
	My_Global.can_pos = self.global_position
	self_modulate = Color.LIGHT_CORAL
	My_Global.current_select="EXIT"


func _on_exit_button_focus_exited():
	self_modulate = Color(1,1,1,1)
