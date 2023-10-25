extends RigidBody2D

var lifespan = 4
var _is_destroy = false

signal phit
signal thit

func _ready():
	$AnimatedSprite2D.play()
	var mob_types = ["default","fish", "green_onion", "human", "oct"]
	$AnimatedSprite2D.animation = mob_types.pick_random()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		lifespan-=delta
		if lifespan <= 0:
			queue_free()
		
		if !_is_destroy:
			position.y += 5
		else :
			pass

func _on_area_2d_body_entered(body):
	if !_is_destroy:
		if body.name == "Player":
			My_Global.my_score-=50
			My_Global.remain_time -= 5
			$AnimatedSprite2D.animation = "P_destroy"
			phit.emit()
	
		elif body.name == "catTail":
			My_Global.my_score+=100
			My_Global.remain_time += 5
			$AnimatedSprite2D.animation = "T_destroy"
			thit.emit()
	elif _is_destroy:
		pass
		
	_is_destroy = true
	await get_tree().create_timer(1.0).timeout
	queue_free()

