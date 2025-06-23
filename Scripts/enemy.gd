extends RigidBody2D

signal phit
signal thit

var _is_destroy = false

func _ready():
	$AnimatedSprite2D.play()
	var mob_types = ["default","fish", "green_onion", "human", "oct"]
	$AnimatedSprite2D.animation = mob_types.pick_random()
	
	linear_velocity.y = 500
	$LifespanTimer.start()


func _on_area_2d_body_entered(body):
	if _is_destroy:
		return # すでに破壊処理中なら、何もしない

	if body.is_in_group("player"):
		_is_destroy = true # 多重ヒットを防ぐ
		linear_velocity.y = 0
		My_Global.my_score -= 50
		if My_Global.remain_time <= 5:
			My_Global.remain_time = 0
		else:
			My_Global.remain_time -= 3
		$AnimatedSprite2D.animation = "P_destroy"
		phit.emit()
		
		await get_tree().create_timer(1.0).timeout
		queue_free()
		
	elif body.is_in_group("player_tail"):
		_is_destroy = true # 多重ヒットを防ぐ
		linear_velocity.y = 0
		My_Global.my_score += 100
		My_Global.remain_time += 1
		$AnimatedSprite2D.animation = "T_destroy"
		thit.emit()
		
		await get_tree().create_timer(1.0).timeout
		queue_free()


func _on_lifespan_timer_timeout():
	queue_free()
