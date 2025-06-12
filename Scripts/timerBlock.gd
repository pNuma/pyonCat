extends StaticBody2D

# インスペクタから設定できる消滅までの秒数
@export var count_time = 0
@onready var _spr = $Sprite2D

var wait_time

func _ready():
	wait_time = count_time	


func _process(_delta: float) -> void:
	#アニメーション処理(汚すぎ)
	if wait_time <= -6:
		setTimerBlock()
	elif wait_time == 3:
		_spr.frame = 3
	elif wait_time == 2:
		_spr.frame = 2
	elif wait_time == 1:
		_spr.frame = 1
	elif wait_time <= 0:
		$CollisionShape2D.disabled = true
		hide()

func setTimerBlock():
	$CountTimer.stop()
	wait_time = count_time
	$CollisionShape2D.disabled = false
	show()

# 他の物体と衝突したときにタイマーを開始
func _on_floor_col_body_entered(_body):
	$CountTimer.start()
	
func _on_CountTimer_timeout():
	wait_time -= 1
