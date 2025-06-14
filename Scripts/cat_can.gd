extends Area2D

signal goal
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play()

func _on_body_entered(_body):
	$AnimatedSprite2D.stop()
	if !My_Global.is_gameclear:
		AudioManager.play_se(AudioManager.canGet_sound)
		My_Global.my_score += 5000
		goal.emit()
	else:
		pass
