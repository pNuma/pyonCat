extends CharacterBody2D

const MOVE_SPEED = 50
const DECAY_MOVE_SPEED = 0.85
const GRAVITY = 50
const JUMP_POWER = 1000

var _is_jumping = false # ジャンプ中かどうか
var _is_directon_left = false # 左向きかどうか.

@onready var tail = $catTail
@export var rotation_speed = 1.5

func  _ready():
	$AnimatedSprite2D.play()

func _physics_process(delta: float) -> void:
	# 重力を加算
	velocity.y += GRAVITY
	
	# 移動量を減衰.
	velocity.x *= DECAY_MOVE_SPEED
	
	# 左右移動.
	if Input.is_action_pressed("ui_left"):
		velocity.x -= MOVE_SPEED # 左方向に移動
	elif Input.is_action_pressed("ui_right"):
		velocity.x += MOVE_SPEED # 右方向に移動.
	
	# ジャンプ.
	if _is_jumping == false:
		# ジャンプ中でなければジャンプできる.
		if Input.is_action_just_pressed("ui_accept"):
			# SPACEキーでジャンプする.
			velocity.y = -JUMP_POWER
	
	# 移動処理.
	move_and_slide()
	
	if is_on_floor():
		_is_jumping = false # 床に着地している
	else:
		_is_jumping = true # ジャンプ中.

func _process(delta: float) -> void:
	# アニメーションの切り替え.
	if velocity.x < 0:
		_is_directon_left = true # 左向き
		tail.scale.x = -1
	elif velocity.x > 0:
		_is_directon_left = false # 右向き
		tail.scale.x = 1

	$AnimatedSprite2D.flip_h = _is_directon_left
	#$AnimatedSprite2D.cat_tail.flip_h = _is_directon_left
	
	#アニメーション制御(もっときれいに書きたい...)
	if abs(velocity.x) < 50 && !_is_jumping:
		$AnimatedSprite2D.animation = "default"
		$AnimatedSprite2D.stop()
	else :
		$AnimatedSprite2D.play()
		if abs(velocity.x) > 50 && !_is_jumping:
			$AnimatedSprite2D.animation = "walk"
		elif _is_jumping:
			$AnimatedSprite2D.animation = "jump"
			

