extends TextureRect

var x_ad = 50.0
var y_ad = 35.0

func _process(_delta: float) -> void:
	self.position = Vector2(My_Global.can_pos.x-x_ad,My_Global.can_pos.y+y_ad)
