extends Area2D

signal goal
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	$AnimatedSprite2D.stop()
	if !My_Global._is_gameclear:
		My_Global.my_score += 5000
		goal.emit()
	else:
		pass
