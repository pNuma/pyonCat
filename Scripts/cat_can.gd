extends Area2D

signal goal

func _ready():
	$AnimatedSprite2D.play()

func _on_body_entered(_body):
	if _body.is_in_group("player"):
		$CollisionShape2D.disabled = true
		$AnimatedSprite2D.stop()
		
		goal.emit()
