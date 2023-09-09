extends Node2D
@onready var _animated_sprite = $CatAnimatedSprite
var state = 0
var mouse_in = false
var noise_level = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and mouse_in == true:
			print("State: ", state)
			if state >= 2:
				state = 0
				noise_level = 0
				$Timer.stop()
				_animated_sprite.play("sleep")

func _on_area_2d_mouse_entered():
	mouse_in = true;

func _on_area_2d_mouse_exited():
	mouse_in = false;

func start():
	print("cat starts");
	$Timer.start()

#return real noise level
func get_noise_level():
	return 0;

func _on_timer_timeout():
	state += 1
	print("state: ", state)
		
	if state == 0 or state == 1:
		_animated_sprite.play("sleep")
	if state == 2:
		_animated_sprite.play("pac2")
	if state == 3:
		_animated_sprite.play("pac3")
		noise_level = 10
		print("cat3")

