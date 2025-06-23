extends CharacterBody2D

@export var max_speed = 250.0
@export var min_speed = 50.0
@export var orbit_distance = 240.0

var rotation_speed: float

func _ready():
	rotation_speed = max_speed
	position = Vector2(orbit_distance, 0)

func _physics_process(delta):
	var rotation_angle = deg_to_rad(rotation_speed * delta)
	position = position.rotated(rotation_angle)

	if Input.is_action_just_pressed("ui_up"):
		var speed_value = abs(rotation_speed)
		rotation_speed *= -1
		
		if rotation_speed > 0:
			speed_value -= 10 # 減速処理
			speed_value = max(speed_value, min_speed)
			rotation_speed = speed_value
