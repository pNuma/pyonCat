extends Node

# ノードへの参照を準備
@onready var bgm_player: AudioStreamPlayer2D = $BgmPlayer
#@onready var se_player: AudioStreamPlayer2D = $SePlayer

# 事前にサウンドファイルを読み込んでおく


var jump_sound = preload("res://Sounds/jump.wav")
var scoreUp_sound = preload("res://Sounds/scoreup.wav")
var scoreDown_sound = preload("res://Sounds/socoredown.wav")
var canGet_sound = preload("res://Sounds/canGet.wav")
var countDown_sound = preload("res://Sounds/countdown.wav")
var select_sound = preload("res://Sounds/select.wav")
var decision_sound = preload("res://Sounds/decision.wav")


# BGMを再生するための関数
func play_bgm(music_file, should_loop: bool = true) -> void:
	# もし同じ曲が再生中でなければ
	if bgm_player.stream != music_file:
		bgm_player.stream = music_file
		bgm_player.play()
	# ループ設定
	bgm_player.stream.loop = should_loop

# 効果音を再生するための関数
func play_se(sound_file) -> void:
	var player = AudioStreamPlayer.new()
	player.stream = sound_file
	player.finished.connect(player.queue_free)
	add_child(player)
	player.play()

# 音を止める関数
func stop_bgm() -> void:
	bgm_player.stop()
