extends CanvasLayer
@onready var textbox_container = $TextboxContainer
@onready var start_symbol = $TextboxContainer/MarginContainer/HBoxContainer/start
@onready var end_symbol = $TextboxContainer/MarginContainer/HBoxContainer/end
@onready var label = $TextboxContainer/MarginContainer/HBoxContainer/Label2
@onready var tween = get_tree().create_tween()

enum State{	
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var text_queue = []

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Starting state is: State.READY")
	hide_textbox()
	queue_text("I need to find something... I can't remember what exactly, but I've lost something, I'm sure of it!")
	queue_text("Why are there so many borbs over there?")
	queue_text("Where am I?")
	queue_text("It's so dark.")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match current_state:
		State.READY:
			if !text_queue.is_empty():
				display_text()
		State.READING:
			if Input.is_action_just_pressed("faster"):
				label.visible_ratio = 1
				tween.kill()
				end_symbol.text = "v"
				change_state(State.FINISHED)
				
		State.FINISHED:
			if Input.is_action_just_pressed("faster"):
				change_state(State.READY)
				hide_textbox()

func queue_text(next_text):
	text_queue.push_back(next_text)

func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	textbox_container.hide()

func show_textbox():
	start_symbol.text = "*"
	textbox_container.show()
	
func display_text():
	var next_text = text_queue.pop_front()
	label.text = next_text
	change_state(State.READING)
	show_textbox()
	label.visible_ratio = 0
	tween = get_tree().create_tween()
	tween.tween_property(label, "visible_ratio", 1, 1.5)
	tween.connect("finished", on_tween_finished)
	
func on_tween_finished():
	end_symbol.text = "v"
	change_state(State.FINISHED)

func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("changing to State.READY")
		State.READING:
			print("changing to State.READING")
		State.FINISHED:
			print("changing to State.FINISHED")
