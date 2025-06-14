extends Button

@export var select_id: String = ""

func _ready() -> void:
	# 自身のシグナルを、自身の関数に接続
	focus_entered.connect(_on_focus_entered)
	focus_exited.connect(_on_focus_exited)

# フォーカスが当たったときの処理（共通）
func _on_focus_entered() -> void:
	AudioManager.play_se(AudioManager.select_sound)
	My_Global.can_pos = self.global_position
	self_modulate = Color.LIGHT_CORAL
	
	## インスペクターで設定したIDをグローバル変数にセット
	My_Global.current_select = select_id

# フォーカスが外れたときの処理（共通）
func _on_focus_exited() -> void:
	self_modulate = Color(1, 1, 1, 1) # Color.WHITEと同じ
