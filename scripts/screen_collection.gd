extends Node;

var deliver: PackedScene;
var pick_up: PackedScene;
var auth: PackedScene;
var home: PackedScene;
var pick_up_new: PackedScene;
var pick_up_on_going: PackedScene;
var deliver_new: PackedScene;
var deliver_on_going: PackedScene;

var screen_stack: Array[PackedScene];

func _ready() -> void:
	deliver = preload("res://screens/Deliver.tscn");
	pick_up = preload("res://screens/Pick_up.tscn");
	auth = preload("res://screens/Auth.tscn");
	home = preload("res://screens/Home.tscn");
	pick_up_new = preload("res://screens/Pick_upNew.tscn");
	pick_up_on_going = preload("res://screens/Pick_upOnGoing.tscn");
	deliver_new = preload("res://screens/DeliverNew.tscn");
	deliver_on_going = preload("res://screens/DeliverOngoing.tscn");
	pass;

func switch_screen(node: Node, screen: PackedScene) -> void:
	node.get_tree().call_deferred("change_scene_to_packed", screen);
	match (node.name):
		"Deliver":
			screen_stack.push_back(deliver);
		"Pick_up":
			screen_stack.push_back(pick_up);
		"Auth":
			screen_stack.push_back(auth);
		"Home":
			screen_stack.push_back(home);
		"Pick_upNew":
			screen_stack.push_back(pick_up_new);
		"Pick_upOnGoing":
			screen_stack.push_back(pick_up_on_going);
		"DeliverNew":
			screen_stack.push_back(deliver_new);
		"DeliverOnGoing":
			screen_stack.push_back(deliver_on_going);
	pass;

func switch_screen_back(node: Node) -> void:
	if (!screen_stack.is_empty()):
		node.get_tree().call_deferred("change_scene_to_packed", screen_stack.pop_back());
	pass;

"""
func _process(_delta: float) -> void:
	print(Engine.get_frames_per_second());
	pass;
"""
