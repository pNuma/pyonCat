extends CharacterBody2D

## パラメータ（インスペクターから調整可能）
@export var max_speed: float = 400.0         # 最高速度
@export var move_force: float = 3000.0       # 左右に動かす力
@export var friction_factor: float = 8.0     # 摩擦係数
@export var jump_velocity: float = -960.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var tail = $catTail


func _physics_process(delta: float) -> void:
	if My_Global.is_gameover:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	# 重力
	if not is_on_floor():
		velocity.y += gravity * delta

	# ジャンプ
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
		AudioManager.play_se(AudioManager.jump_sound)
	
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x += direction * move_force * delta
	
	# 摩擦をかける
	# lerp(現在の値, 目標値, 割合) を使って、速度を0に近づける
	velocity.x = lerp(velocity.x, 0.0, friction_factor * delta)

	# 最高速度を制限
	velocity.x = clamp(velocity.x, -max_speed, max_speed)

	move_and_slide()

	update_animation()
	update_direction()

#向きを更新
func update_direction() -> void:
	# 左に動いている場合
	if velocity.x < 0:
		animated_sprite.flip_h = true
		tail.scale.x = -1
	# 右に動いている場合
	elif velocity.x > 0:
		animated_sprite.flip_h = false
		tail.scale.x = 1


# アニメーションを更新
func update_animation() -> void:
	if not is_on_floor():
		animated_sprite.animation = "jump"
	else:
		if abs(velocity.x) > 50:
			animated_sprite.animation = "walk"
		else:
			animated_sprite.animation = "default"
	
	animated_sprite.play()
