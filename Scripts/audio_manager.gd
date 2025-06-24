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


# AudioManagerがロードされた時に一度だけ実行される
func _ready() -> void:
	# 保存されているオーディオ設定を起動時に適用する（設定画面実装時に有効化）
	# apply_audio_settings()
	pass


# --- BGM制御関数 ---

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
	player.bus = "SFX" # SFXバスで再生するように指定
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
