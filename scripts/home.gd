extends Node;

func _ready() -> void:
	$GridContainer/Button00.pressed.connect(func(): ScreenCollection.switch_screen(self, ScreenCollection.pick_up_new));
	$GridContainer/Button01.pressed.connect(func(): ScreenCollection.switch_screen(self, ScreenCollection.pick_up_on_going));
	$GridContainer/Button02.pressed.connect(func(): ScreenCollection.switch_screen(self, ScreenCollection.deliver_new));
	$GridContainer/Button03.pressed.connect(func(): ScreenCollection.switch_screen(self, ScreenCollection.deliver_on_going));
	pass;

func _notification(what):
	if (what == NOTIFICATION_WM_GO_BACK_REQUEST):
		get_tree().quit();
	pass;
