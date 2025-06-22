extends Button

@export var select_id: String = ""

signal focused(button_node)

func _ready() -> void:
	focus_entered.connect(_on_focus_entered)
	focus_exited.connect(_on_focus_exited)

func _on_focus_entered() -> void:
	AudioManager.play_se(AudioManager.select_sound)
	self_modulate = Color.LIGHT_CORAL
	
	focused.emit(self) 

func _on_focus_exited() -> void:
	self_modulate = Color(1, 1, 1, 1)
