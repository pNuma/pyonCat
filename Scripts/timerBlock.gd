extends StaticBody2D


# ブロックの初期耐久値（プレイヤーが乗ってから消えるまでの秒数）
@export var count_time: int = 3
# プレイヤーがエリアから出てから、実際に復活するまでの遅延時間
@export var respawn_delay_after_exit: float = 1.0


# 現在の耐久値
var current_health: int
# 復活待機中（プレイヤーが上にいるため）かどうかを管理するフラグ
var is_waiting_for_clearance: bool = false

## 子ノードへの参照
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var top_check_area: Area2D = $FloorCol 
@onready var top_check_collision: CollisionShape2D = $FloorCol/CollisionShape2D
@onready var detection_area: Area2D = $RespawnBlockerArea 
@onready var animation_timer: Timer = $AnimationTimer 
@onready var respawn_timer: Timer = $RespawnTimer    


# このノードが準備できた時に一度だけ呼ばれる
func _ready() -> void:
	# ブロックを初期状態にリセット
	reset_block()
	

# プレイヤーがブロック上部のエリアに触れた時の処理
func _on_floor_col_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player") or not animation_timer.is_stopped():
		return
	
	animation_timer.start()


# 1秒ごとに呼ばれ、見た目を変える処理
func _on_animation_timer_timeout() -> void:
	current_health -= 1
	
	if current_health <= 0:
		disappear()
	else:
		sprite.frame = current_health


# ブロックが完全に消える処理
func disappear() -> void:
	animation_timer.stop()
	hide()
	collision.disabled = true
	top_check_collision.disabled = true
	respawn_timer.start() # 復活タイマーを開始


# 復活タイマーが終わった時の処理
func _on_respawn_timer_timeout() -> void:
	for body in detection_area.get_overlapping_bodies():
		if body.is_in_group("player"):
			respawn_timer.start()
			return
		
	reset_block()

func _on_respawn_blocker_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and collision.disabled:
		respawn_timer.start()


# ブロックを初期状態に戻す（リセットする）関数
func reset_block() -> void:
	is_waiting_for_clearance = false
	show()
	collision.disabled = false
	top_check_collision.disabled = false
	current_health = count_time
	sprite.frame = current_health
