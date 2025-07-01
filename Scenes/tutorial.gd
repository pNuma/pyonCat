extends Control

@export var enemy_scene: PackedScene
@onready var tutorial_goal = $CatCan
@onready var spawn_points = [$SpawnPoint1, $SpawnPoint2]
@onready var enemy_spawn_timer = $EnemyTimer # タイマーへの参照

func _ready() -> void:
	My_Global.is_gameover = false
	enemy_spawn_timer.start()
	$Player.position=$InitPosition.position

# ゴールのシグナルを受け取った時に呼ばれる関数
func _on_cat_can_goal() -> void:
	My_Global.is_gameover = true
	AudioManager.play_se(AudioManager.canGet_sound)
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/title.tscn")
	
# 敵発生
func _on_enemy_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	var spawn_point = spawn_points.pick_random()
	enemy.global_position = spawn_point.global_position
	
	enemy.phit.connect(_on_enemy_hit_player)
	enemy.thit.connect(_on_enemy_hit_tail)
	
	add_child(enemy)
	enemy.owner = self

# 敵がプレイヤーに当たった時の処理
func _on_enemy_hit_player() -> void:
	AudioManager.play_se(AudioManager.scoreDown_sound)

# 敵がしっぽに当たった時の処理
func _on_enemy_hit_tail() -> void:
	AudioManager.play_se(AudioManager.scoreUp_sound)

# 戻るボタン
func _on_back_button_pressed() -> void:
	My_Global.is_gameover = true
	get_tree().change_scene_to_file("res://Scenes/title.tscn")
