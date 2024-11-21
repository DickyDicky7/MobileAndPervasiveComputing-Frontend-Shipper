extends Node;

var plugin;
var http: AwaitableHTTPRequest = AwaitableHTTPRequest.new();

func _ready() -> void:
	add_child(http);

	if (OS.get_name() == "Android"):
		if (Engine.has_singleton("GodotGetImage")):
			plugin = Engine.get_singleton("GodotGetImage");
		else:
			print_debug("could not load plugin: ", "GodotGetImage");
			
	if (plugin):
		plugin.connect("image_request_completed", _on_image_request_completed);
		plugin.connect("error", _on_error);
		plugin.connect("permission_not_granted_by_user", _on_permission_not_granted_by_user);
		plugin.setOptions({
"use_photo_picker": true,
						"auto_rotate_image": true,
												"image_format" : "jpg",
		});
	pass;

func _on_image_request_completed(dict):
	print(Global.chosen_delivery);
	print()
	
	var done = await http.async_request(
		"https://waseminarcnpm2.azurewebsites.net/protected/delivery/update_status",
		HTTPClient.Method.METHOD_POST     ,
		["Content-Type: application/json"],
		JSON.stringify({
			"deliveryId"    : Global.chosen_delivery["_id"],
			"status": "success"
		})
	);
	print(done.json);
	print();
	
	var r = await http.async_request(
		"https://waseminarcnpm2.azurewebsites.net/up-img",
		HTTPClient.Method.METHOD_POST     ,
		["Content-Type: application/json"],
		JSON.stringify({
			"image"    : Marshalls.raw_to_base64(dict.values()[0 ]),
			"imageName": Global.chosen_order.json["_id"]
		})
	);
	print(r.json);
	print();
	
	var pod = await http.async_request(
		"https://waseminarcnpm2.azurewebsites.net/protected/extract-text-from-image",
		HTTPClient.Method.METHOD_POST     ,
		["Content-Type: application/json"],
		JSON.stringify({
			"image_url": r.json["realData"]["publicUrl"]
		})
	);
	print(pod.json);
	print();
	
	var uorder = await http.async_request(
		"https://waseminarcnpm2.azurewebsites.net/protected/order?id=" + Global.chosen_order.json["_id"],
		HTTPClient.Method.METHOD_PUT      ,
		["Content-Type: application/json"],
		JSON.stringify({
			"podTxt": pod.json["extracted_text"],
			"podImg": r.json["realData"]["publicUrl"]
		})
	);
	print(uorder.json);
	print();
	pass;
	
func _on_error(e) -> void:
	print(e);
	pass;
	
func _on_permission_not_granted_by_user(permission) -> void:
	print(permission);
	plugin.resendPermission();
	pass;
