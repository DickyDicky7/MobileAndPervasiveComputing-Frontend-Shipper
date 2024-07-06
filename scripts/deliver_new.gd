extends Node;

@export var http: AwaitableHTTPRequest;

func _ready() -> void:
	$Back.pressed.connect(func(): ScreenCollection.switch_screen_back(self));
	$VBoxContainer/ScrollContainer/VBoxContainer/ItemList.item_clicked.connect(
		func(index: int, at_position: Vector2, mouse_button_index: int):
			Global.chosen_delivery = Global.deliveries.json["list"][index]
			ScreenCollection.switch_screen(self, ScreenCollection.deliver);
			pass;);
	var r = await http.async_request(
		"https://waseminarcnpm.azurewebsites.net/protected/deliveries/staff?staffId=" + Global.staff.json["staff"]["_id"],
		HTTPClient.Method.METHOD_GET      ,
		["Content-Type: application/json"],
		JSON.stringify({
		})
	);
	Global.deliveries = r;
	for order in r.json["list"]:
		$VBoxContainer/ScrollContainer/VBoxContainer/ItemList.add_item(order["_id"], preload("res://Game Icons/PNG/White/2x/stop.png"));
	pass;

func _notification(what):
	if (what == NOTIFICATION_WM_GO_BACK_REQUEST):
		ScreenCollection.switch_screen_back(self);
	pass;
