extends Node2D # Created @ Part 3


@onready var player = $Player
@onready var map = $TileMap
@onready var camera = $Camera2D

@export var enemy_scene=preload("res://Scenes/enemy.tscn")

var elevation = 0
var ele_temp = 0


func _ready():
	#AudioManager.play_bgm(AudioManager.title_music)
	My_Global.is_gameover = true	
	My_Global.my_score=0
	randomize()
	adjust_camera()
	$TileMap.hide()
	$Node2D.hide()
	$Player.hide()
	$Player.position=$InitPosition.position
	start_game_sequence()
	
func _process(_delta: float) -> void:
	if My_Global.my_score < 0:
		My_Global.my_score = 0
	camera.global_position = player.global_position
	
	if !My_Global.is_gameover:
	#標高のスコア計算
		elevation = abs(int(player.position.y)-int($InitPosition.position.y))/10
		
		if elevation > ele_temp:
			My_Global.my_score += elevation-ele_temp
			ele_temp = elevation	

func adjust_camera():
	var map_limits = map.get_used_rect()
	print("map_limits", map_limits)
	var map_cell_size = map. tile_set.tile_size	
	print("map_cell_size", map_cell_size)
	camera.limit_left = map_limits.position.x * map_cell_size.x
	camera.limit_right = map_limits.end.x * map_cell_size.x
	#camera.limit_top = map_limits.position.y * map_cell_size.y # 指定しない
	camera.limit_bottom = map_limits.end.y * map_cell_size.y
	camera.limit_smoothed = true
	
func player_hit():
	$HUD.show_yaruki_minus()
	
func tail_hit():
	$HUD.show_yaruki_plus()

func _on_StartTimer_timeout():
	$RemainTimer.start()
	$EnemyTimer.start()
	
func game_over():
	My_Global.is_gameover = true
	if My_Global.high_score < My_Global.my_score:
		My_Global.high_score = My_Global.my_score
	$RemainTimer.stop()
	$EnemyTimer.stop()
	$TileMap.hide()
	$Node2D.hide()
	$Player.hide()
	$HUD.show_game_over()
	
	$Player.position=$InitPosition.position

func new_game():
	My_Global.remain_time = 100
	My_Global.is_gameover = false
	My_Global.is_gameclear = false
	ele_temp = 0
	$Player.position=$StartPosition.position
	$Player/catTail.rotation_speed = 250
	$TileMap.show()
	$Node2D.show()
	$Player.show()
	$StartTimer.start()

func start_game_sequence() -> void:
	$HUD.show_message("3")
	AudioManager.play_se(AudioManager.countDown_sound)
	await get_tree().create_timer(1.0).timeout
	$HUD.show_message("2")
	AudioManager.play_se(AudioManager.countDown_sound)
	await get_tree().create_timer(1.0).timeout
	$HUD.show_message("1")
	AudioManager.play_se(AudioManager.countDown_sound)
	await get_tree().create_timer(1.0).timeout
	
	$HUD/ScreenCover.hide()
	$HUD.show_message("のぼれ！")
	
	new_game()

func _on_remain_timer_timeout():
	if My_Global.remain_time > 0:
		My_Global.remain_time -= 1
	$HUD.update_remain_time()
	if My_Global.remain_time <= 0:
		My_Global.remain_time = 0
		if !My_Global.is_gameover:
			game_over()
			My_Global.is_gameover = true

func _on_enemy_timer_timeout():
	# Create a new instance
	var enemy = enemy_scene.instantiate()
	enemy.connect('phit', player_hit)
	enemy.connect('thit', tail_hit)
	enemy.position = Vector2(randf_range(-133,507),player.position.y-800)
	add_child(enemy)

func _on_cat_can_goal():
	$RemainTimer.stop()
	My_Global.my_score+=My_Global.remain_time*10
	My_Global.is_gameclear=true
	game_over()
