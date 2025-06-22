extends TextureRect

var move_tween: Tween

func calculate_target_position(target_button: Button) -> Vector2:
	var target_y = target_button.global_position.y + (target_button.size.y / 2) - (self.size.y / 2) + 16
	var target_x = target_button.global_position.x - self.size.x - 10
	return Vector2(target_x, target_y)

func move_to_target_instantly(target_button: Button) -> void:
	global_position = calculate_target_position(target_button)


func move_to_target_with_tween(target_button: Button) -> void:
	var final_position = calculate_target_position(target_button)

	if move_tween and move_tween.is_valid():
		move_tween.kill()

	move_tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	move_tween.tween_property(self, "global_position", final_position, 0.05)
