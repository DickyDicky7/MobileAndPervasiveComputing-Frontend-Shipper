extends Node;

func _ready() -> void:
	$Buttons/Accept.pressed.connect(func(): ScreenCollection.switch_screen(self, ScreenCollection.pick_up));
	$Back.pressed.connect(func(): ScreenCollection.switch_screen_back(self));
	pass;

func _notification(what):
	if (what == NOTIFICATION_WM_GO_BACK_REQUEST):
		ScreenCollection.switch_screen_back(self);
	pass;
