extends Node;

@export var http: AwaitableHTTPRequest;

func _ready() -> void:
	$VBoxContainer/SignIn.pressed.connect(func():
		var re = await http.async_request(
			"https://waseminarcnpm2.azurewebsites.net/auth/sign-in",
			HTTPClient.Method.METHOD_POST     ,
			["Content-Type: application/json"],
			JSON.stringify({
				"username": $VBoxContainer/Username.text,
				"password": $VBoxContainer/Password.text
			})
		);
		Global.  auth_result = re;
		if (re.status_code  == 200):
			ScreenCollection.switch_screen(self, ScreenCollection.home));
	pass;

func _notification(what):
	if (what == NOTIFICATION_WM_GO_BACK_REQUEST):
		get_tree().quit();
	pass;
	
