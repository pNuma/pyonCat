# My_Global.gd

extends Node

# --- ゲーム中の状態変数 ---
var my_score: int = 0
var is_gameover: bool = false
var is_gameclear: bool = false
var remain_time: int = 100
var current_select: String = "START" 



# --- 保存対象 ---
var high_score: int = 0
var highscore_was_a_clear: bool = false
var volume_bgm: float = 1.0
var volume_se: float = 1.0
var is_muted: bool = false 
var is_fullscreen: bool = false

# --- セーブ＆ロード機能 ---
const SAVE_FILE_PATH = "user://save_data.dat"

func _ready() -> void:
	load_data()
	if is_fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

# データをまとめてファイルに保存する関数
func save_data() -> void:
	var save_dict = {
		"high_score": high_score,
		"highscore_was_a_clear": highscore_was_a_clear,
		"volume_bgm": volume_bgm,
		"volume_se": volume_se,
		"is_muted": is_muted,
		"is_fullscreen": is_fullscreen 
	}

	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	if file:
		file.store_var(save_dict)


# ファイルからデータをまとめて読み込む関数
func load_data() -> void:
	if FileAccess.file_exists(SAVE_FILE_PATH):
		var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
		if file:
			var loaded_data = file.get_var()
			
			if loaded_data.has("high_score"):
				high_score = loaded_data["high_score"]
			if loaded_data.has("highscore_was_a_clear"):
				highscore_was_a_clear = loaded_data["highscore_was_a_clear"]
			if loaded_data.has("volume_bgm"):
				volume_bgm = loaded_data["volume_bgm"]
			if loaded_data.has("volume_se"):
				volume_se = loaded_data["volume_se"]
			if loaded_data.has("is_muted"): 
				is_muted = loaded_data["is_muted"]
			if loaded_data.has("is_fullscreen"):
				is_fullscreen = loaded_data["is_fullscreen"]
				

func reset_highscore() -> void:
	high_score = 0
	highscore_was_a_clear = false
	save_data()
	print("ハイスコアがリセットされました。")
	
func get_formatted_highscore_string() -> String:
	if highscore_was_a_clear:
		return str(high_score)+"☆"
	else:
		return str(high_score)
