extends CharacterBody2D

@export var max_speed = 250.0
@export var min_speed = 50.0
@export var orbit_distance = 240.0

var rotation_speed: float
var can_play_fail_sound: bool = true #連打で音ならし対策

func _ready():
	rotation_speed = max_speed
	position = Vector2(orbit_distance, 0)

func _physics_process(delta):
	var rotation_angle = deg_to_rad(rotation_speed * delta)
	position = position.rotated(rotation_angle)

	if Input.is_action_just_pressed("ui_up"):
		if abs(rotation_speed) > min_speed:
			var new_speed = abs(rotation_speed) - 10 # 減速処理
			new_speed = max(new_speed, min_speed)
			rotation_speed = -sign(rotation_speed) * new_speed #反転
			
		else:
			if can_play_fail_sound:
				can_play_fail_sound = false
				$ReverseFailCooldownTimer.start()
				AudioManager.play_se(AudioManager.cannot_reverse_sound)

# 再生許可フラグ
func _on_reverse_fail_cooldown_time_timeout() -> void:
	can_play_fail_sound = true
