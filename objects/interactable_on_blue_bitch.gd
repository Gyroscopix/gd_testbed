class_name Interactable
extends StaticBody3D

signal interacted(body)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.

@export var prompt_message = "Interact"
@export var prompt_action = "interact"

func get_prompt():
	var key_name = ""
	for action in InputMap.action_get_events(prompt_action):
		if action is InputEventKey:
			key_name = OS.get_keycode_string(action.keycode)
	return prompt_message + "\n[" + key_name + "]"

func interact(body):
	emit_signal("interacted", body)
