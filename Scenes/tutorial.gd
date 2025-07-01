extends Control

@export var enemy_scene: PackedScene
@onready var tutorial_goal = $CatCan
@onready var spawn_points = [$SpawnPoint1, $SpawnPoint2]
# ゴールのシグナルを受け取った時に呼ばれる関数
func _on_cat_can_goal() -> void:
	print("チュートリアルゴール！タイトルに戻ります。")
	AudioManager.play_se(AudioManager.canGet_sound)
	get_tree().change_scene_to_file("res://Scenes/title.tscn")
	
func _on_enemy_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	var spawn_point = spawn_points.pick_random()
	enemy.global_position = spawn_point.global_position
	
	enemy.phit.connect(_on_enemy_hit_player)
	enemy.thit.connect(_on_enemy_hit_tail)
	
	add_child(enemy)

func _on_enemy_hit_player() -> void:
	AudioManager.play_se(AudioManager.score_down_sound)
	print("チュートリアル：プレイヤーにヒット！")

# 敵がしっぽに当たった時の処理
func _on_enemy_hit_tail() -> void:
	AudioManager.play_se(AudioManager.score_up_sound)
	print("チュートリアル：しっぽにヒット！")
