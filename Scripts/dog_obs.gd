extends Node2D
var mouse_in = false
var state = 0
var noise_level = 0
var state_set = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == 0:
			$Dog/AnimationPlayer.play("0")
	if state_set == 0:
		if state == 1:
			$Dog/AnimationPlayer.play("1")
		if state == 2:
			$Dog/AnimationPlayer.play("2")
		if state == 3:
			$Dog/AnimationPlayer.play("3")
	if state_set == 1:
		if state == 1:
			$Dog/AnimationPlayer.play("4")
		if state == 2:
			$Dog/AnimationPlayer.play("5")
		if state == 3:
			$Dog/AnimationPlayer.play("6")
			

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and mouse_in == true:
			print("State: ", state)
			if state >= 2:
				state = 0
				noise_level = 0
				$Timer.stop()

func _on_area_2d_mouse_entered():
	mouse_in = true;

func _on_area_2d_mouse_exited():
	mouse_in = false;

#start being an obstacle
func start():
	print("Dog starts");
	var rng_set = RandomNumberGenerator.new();
	state_set = rng_set.randf_range(0, 1);
	$Timer.start();

#return real noise level
func get_noise_level():
	return noise_level;

func _on_timer_timeout():
	state += 1
	if state == 3:
		noise_level = 0
	print("Noise: ", noise_level)
