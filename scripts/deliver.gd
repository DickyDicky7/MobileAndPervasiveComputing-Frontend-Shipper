extends Node;

@export var http: AwaitableHTTPRequest;

func _ready() -> void:
	#print(Global.chosen_delivery)
	$Buttons/Accept.pressed.connect(func(): ScreenCollection.switch_screen(self, ScreenCollection.pick_up));	
	$Buttons/PackageDelivered.pressed.connect(func():  CameraGallery.plugin.getGalleryImage());
#	$Buttons/Accept.pressed.connect(func(): CameraGallery.plugin.getCameraImage());
	$Back.pressed.connect(func(): ScreenCollection.switch_screen_back(self));
	var r = await http.async_request(
		"https://waseminarcnpm.azurewebsites.net/protected/order?id=" + Global.chosen_delivery["orderId"],
		HTTPClient.Method.METHOD_GET      ,
		["Content-Type: application/json"],
		JSON.stringify({
		})
	);
	#print(Global.chosen_delivery["orderId"]);
	Global.chosen_order = r;
	print(Global.chosen_order.json);
	print();
	$Details/Address.text = r.json["deliveryAddress"];
	pass;

func _notification(what):
	if (what == NOTIFICATION_WM_GO_BACK_REQUEST):
		ScreenCollection.switch_screen_back(self);
	pass;
