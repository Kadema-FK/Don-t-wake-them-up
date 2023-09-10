extends Node2D
var isOn: bool;
const tvNoiseLevel = 15
var mouse_in;

func get_noise_level():
	if isOn:
		return tvNoiseLevel;
	else:
		return 0;

func turnOnTV():
	$Screen.visible = true;
	$Screen.play("tv_on");
	isOn = true;
	
func turnOffTV():
	$Screen.visible = false;
	isOn = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	turnOffTV();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_mouse_entered():
	mouse_in = true;

func _on_area_2d_mouse_exited():
	mouse_in = false;

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and mouse_in == true:
			if isOn:
				turnOffTV();
			else:
				turnOnTV();
