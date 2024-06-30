extends Node;

var plugin;

func _ready() -> void:
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
	print(dict);
	pass;
	
func _on_error(e) -> void:
	print(e);
	pass;
	
func _on_permission_not_granted_by_user(permission) -> void:
	print(permission);
	plugin.resendPermission();
	pass;
