extends Node;

func _ready() -> void:
	$VBoxContainer/SignIn.pressed.connect(func(): ScreenCollection.switch_screen(self, ScreenCollection.home));
	pass;

func _notification(what):
	if (what == NOTIFICATION_WM_GO_BACK_REQUEST):
		get_tree().quit();
	pass;
	
