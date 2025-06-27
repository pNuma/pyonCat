extends Node2D

@onready var player = $Player
@onready var map = $TileMap
@onready var camera = $Camera2D
@onready var enemy_spawner = $EnemySpawner 

var elevation = 0
var ele_temp = 0

func _ready():
	My_Global.is_gameover = true	
	My_Global.my_score=0
	randomize()
	adjust_camera()
	$TileMap.hide()
	$TimerBlocks.hide()
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
	var map_cell_size = map. tile_set.tile_size	
	camera.limit_left = map_limits.position.x * map_cell_size.x
	camera.limit_right = map_limits.end.x * map_cell_size.x
	camera.limit_bottom = map_limits.end.y * map_cell_size.y
	camera.limit_smoothed = true

func player_hit():
	AudioManager.play_se(AudioManager.scoreDown_sound)
	$HUD.show_yaruki_minus()
	
func tail_hit():
	AudioManager.play_se(AudioManager.scoreUp_sound)
	$HUD.show_yaruki_plus()
	
func game_over():
	AudioManager.stop_bgm()
	My_Global.is_gameover = true
	if My_Global.high_score < My_Global.my_score:
		My_Global.high_score = My_Global.my_score
		My_Global.highscore_was_a_clear = My_Global.is_gameclear
		My_Global.save_data() # セーブ処理
		
	$RemainTimer.stop()
	enemy_spawner.stop() 
	
	$TileMap.hide()
	$TimerBlocks.hide()
	$Player.hide()
	$HUD.show_game_over()
	$Player.position=$InitPosition.position

func new_game():
	My_Global.remain_time = 100
	My_Global.is_gameover = false
	My_Global.is_gameclear=false
	ele_temp = 0
	$Player.position=$StartPosition.position
	$TileMap.show()
	$TimerBlocks.show()
	$Player.show()
	$RemainTimer.start()
	enemy_spawner.start() 

func start_game_sequence() -> void:
	AudioManager.stop_bgm()
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
	AudioManager.play_bgm(AudioManager.main_music)
	
	new_game()

func _on_remain_timer_timeout():
	if My_Global.remain_time > 0:
		My_Global.remain_time -= 1
	$HUD.update_remain_time()
	if My_Global.remain_time <= 0:
		if !My_Global.is_gameover:
			game_over()
			My_Global.is_gameover = true

func _on_cat_can_goal():
	$RemainTimer.stop()
	if My_Global.is_gameclear:
		return # すでにクリア済みなら何もしない
	AudioManager.play_se(AudioManager.canGet_sound) 
	
	My_Global.my_score += 3000
	My_Global.my_score+=My_Global.remain_time*10
	My_Global.is_gameclear=true
	game_over()
