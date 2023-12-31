extends CanvasLayer

signal start_game
# Called when the node enters the scene tree for the first time.
func _ready():
	$YarukiPlus.hide()
	$YarukiMinus.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Score.text=str(My_Global.my_score)

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	$HighScore.text=str(My_Global.high_score)
	if My_Global._is_gameclear:
		show_message(str(My_Global.my_score)+"\nnya-n!!!\n(ごはん美味しい)")
	else:
		show_message(str(My_Global.my_score)+"\nnya-n...\n(やる気が無くなった)")
	await $MessageTimer.timeout
	
	$Message.text = "ボタンをクリックして \nスタート！"
	$Message.show()
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()

func _on_StartButton_pressed():
	$StartButton.hide()
	start_game.emit()

func _on_MessageTimer_timeout():
	$Message.hide()

func update_remain_time():
	$RemainTime.text = str(My_Global.remain_time)
	
func show_yaruki_plus():
	$YarukiPlus.show()
	await get_tree().create_timer(1.0).timeout
	$YarukiPlus.hide()	

func show_yaruki_minas():
	$YarukiMinus.show()
	await get_tree().create_timer(1.0).timeout
	$YarukiMinus.hide()
	
