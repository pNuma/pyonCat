extends Node

@export var enemy_scene: PackedScene
@export var player: Node2D # プレイヤーの位置を知るために参照

# 子ノードのタイマーへの参照
@onready var enemy_timer: Timer = $EnemyTimer

# スポーン位置
var spawn_positions = [-133, -69, -5, 59, 123, 187, 251 ,315, 379, 443]#-197, 

func _on_enemy_timer_timeout() -> void:
	# 毎回新しいインスタンスを作成
	var enemy = enemy_scene.instantiate()

	# 敵の位置を設定
	var spawn_x = spawn_positions.pick_random()
	var spawn_y = player.position.y - 800
	enemy.position = Vector2(spawn_x, spawn_y)
	
	enemy.thit.connect(get_parent().tail_hit)
	enemy.phit.connect(get_parent().player_hit)

	get_parent().add_child(enemy)

func start() -> void:
	enemy_timer.start()

func stop() -> void:
	enemy_timer.stop()
