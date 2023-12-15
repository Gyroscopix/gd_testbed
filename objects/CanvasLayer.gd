extends CanvasLayer


var wait_time = 3.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$response.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_blue_box_bro_interacted(body):
	$response.show()
	await get_tree().create_timer(2).timeout
	$response.hide()
	
	
	
