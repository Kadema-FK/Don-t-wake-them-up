extends Node2D
var mouse_in = false
var mouse_in_food = false
var state = 0
var noise_level = 0
var move_food = false

# Called when the node enters the scene tree for the first time.
func _ready():
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if move_food == true:
		$DogFood.global_position = $DogFood.get_global_mouse_position()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and mouse_in == true:
			move_food = true
			print("food move", move_food)
		if mouse_in_food == true and state >= 2 and move_food == true:
			$AnimatedSprite2D.play("4")
			noise_level = 0
			$Timer.stop()
			$dog_back.start()
			$dog_bark.stop()
		if event.is_released():
			$DogFood.position.x = 673
			$DogFood.position.y = 547
			move_food = false
			
	

func _on_area_2d_mouse_entered():
	mouse_in = true;

func _on_area_2d_mouse_exited():
	mouse_in = false;

#start being an obstacle
func start():
	print("Dog starts");
	if state <= 0:
		$Timer.start();

#return real noise level
func get_noise_level():
	return noise_level;

func _on_timer_timeout():
	if state <=3:
		state += 1
	
	if state == 2:
		$AnimatedSprite2D.play("2")
	if state == 4:
		$AnimatedSprite2D.play("3")
		noise_level = 10
		$dog_bark.play()
		


func _on_bowl_area_mouse_entered():
	mouse_in_food = true;


func _on_bowl_area_mouse_exited():
	mouse_in_food = false;


func _on_dog_back_timeout():
	$AnimatedSprite2D.play("1")
	$dog_back.stop()
	state = 0
