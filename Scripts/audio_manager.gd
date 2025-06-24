extends Node

const MAX_SE_INSTANCES = 16
# ノードへの参照を準備
@onready var bgm_player: AudioStreamPlayer = $BgmPlayer
@onready var se_player: AudioStreamPlayer = $SePlayer

var title_music = preload("res://Sounds/title_BGM.ogg")
var main_music = preload("res://Sounds/main_BGM.ogg")

var jump_sound = preload("res://Sounds/jump.wav")
var scoreUp_sound = preload("res://Sounds/scoreup.wav")
var scoreDown_sound = preload("res://Sounds/socoredown.wav")
var canGet_sound = preload("res://Sounds/canGet.wav")
var countDown_sound = preload("res://Sounds/countdown.wav")
var select_sound = preload("res://Sounds/select.wav")
var decision_sound = preload("res://Sounds/decision.wav")


func _ready() -> void:
	apply_audio_settings()


func apply_audio_settings() -> void:
	var bgm_bus_idx = AudioServer.get_bus_index("BGM")
	var se_bus_idx = AudioServer.get_bus_index("SE")
	
	AudioServer.set_bus_volume_db(bgm_bus_idx, linear_to_db(My_Global.volume_bgm))
	AudioServer.set_bus_volume_db(se_bus_idx, linear_to_db(My_Global.volume_se))
	
	
# BGMを再生する
func play_bgm(music_file) -> void:
	# もし現在再生中の曲と違う曲を再生しようとした場合
	if bgm_player.stream != music_file:
		bgm_player.stream = music_file
		bgm_player.play()
	# もし止まっている場合に、同じ曲をもう一度再生する場合
	elif not bgm_player.playing:
		bgm_player.play()
		

# BGMを停止する
func stop_bgm() -> void:
	bgm_player.stop()

func play_se(sound_file) -> void:
	# 現在のSE再生数が上限に達していないかチェック
	if get_playing_se_count() >= MAX_SE_INSTANCES:
		return 

	# 使い捨てプレイヤーを生成して再生
	var player = AudioStreamPlayer.new()
	player.stream = sound_file
	player.bus = "SE" 
	player.finished.connect(player.queue_free)
	add_child(player)
	player.play()


# 現在再生中の効果音プレイヤーの数を返すヘルパー関数
func get_playing_se_count() -> int:
	var count = 0
	for child in get_children():
		if child is AudioStreamPlayer and child != bgm_player:
			count += 1
	return count
