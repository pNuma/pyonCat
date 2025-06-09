extends VBoxContainer

func _ready():
	$StartButton.grab_focus()	

func _has_no_focus() -> bool:
	return (
			!$StartButton.has_focus()
			and !$TutorialButton.has_focus()
			and !$OptionButton.has_focus()
			and !$ExitButton.has_focus()
	)
