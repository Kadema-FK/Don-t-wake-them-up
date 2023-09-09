extends Node2D
var mouse_in = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and mouse_in == true:
			print("Left button was clicked at ", event.position)

func _on_area_2d_mouse_entered():
	mouse_in = true;


func _on_area_2d_mouse_exited():
	mouse_in = false;

#start being an obstacle
func start():
	pass;

#return real noise level
func get_noise_level():
	return 0;
