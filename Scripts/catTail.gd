extends CharacterBody2D

# 回転速度を定義します（単位は度/秒）
var max_tail_speed = 250
var min_tail_speed = 50

var rotation_speed = max_tail_speed

func _physics_process(delta):
	# 親ノードの周りを回転
	var rotation_angle = deg_to_rad(rotation_speed * delta)
	var parent_position = get_parent().global_position
	var my_position = global_position
	var _is_flip = false

	# 親ノードに対する相対位置と回転角度を計算
	var relative_position = my_position - parent_position
	relative_position = relative_position.rotated(rotation_angle)

	# 新しいグローバル位置を設定
	
	global_position = parent_position + relative_position
	
	#しっぽの進行方向と速さ
	if Input.is_action_just_pressed("ui_up")&&abs(rotation_speed) > min_tail_speed:
		print(rotation_speed)
		rotation_speed*=-1
		if rotation_speed > 0:
			rotation_speed -= 10
