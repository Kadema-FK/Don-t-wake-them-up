extends Node2D
var mouse_in = false
var state = 4
var open = true
var noise_level = 0
var hot_level = 0
var hot_noise = 0
@export var catSelected = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	$temp_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseButton:
		if catSelected == false:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and mouse_in == true:
				print("Open: ", open)
				if open == true:
					open = false
					$AnimatedSprite2D.play("closed")
					$window_sound.play()
					$AudioStreamPlayer.volume_db = -10
					noise_level = 0
					if state == 2:
						$AnimatedSprite2D.play("closed_wewo")
					if state == 3:
						$AnimatedSprite2D.play("closed_big_wewo")
				elif open == false:
					open = true
					$window_sound.play()
					$AudioStreamPlayer.volume_db = 0
					$AnimatedSprite2D.play("open")
					if state == 2:
						$AnimatedSprite2D.play("open_wewo")
					if state == 3:
						noise_level = 10
						$AnimatedSprite2D.play("open_big_wewo")

func _on_area_2d_mouse_entered():
	mouse_in = true;

func _on_area_2d_mouse_exited():
	mouse_in = false;

#start being an obstacle
func start():
	print("Window starts");
	if state >= 4:
		state = 0
		$Timer.start()

#return real noise level
func get_noise_level():
	return noise_level + hot_noise;
	
func is_baby_hot():
	pass
	

func _on_timer_timeout():
	state += 1
	if state == 2:
		if open == true:
			$AnimatedSprite2D.play("open_wewo")
		if open == false:
			$AnimatedSprite2D.play("closed_wewo")
	if state == 3 and open == true:
		$AudioStreamPlayer.play()
		$AnimatedSprite2D.play("open_big_wewo")
		noise_level = 10
	elif state == 3 and open == false:
		$AudioStreamPlayer.play()
		noise_level = 10
		$AnimatedSprite2D.play("closed_big_wewo")
	if state >= 4:
		noise_level = 0
		$AudioStreamPlayer.stop()
		
		if open == true:
			$AnimatedSprite2D.play("open")
		if open == false:
			$AnimatedSprite2D.play("closed")
			
		$Timer.stop()
		
	print("Window noise: ", noise_level)


func _on_temp_timer_timeout():
	if open == false and hot_level <= 3:
		hot_level += 1
	elif open == true and hot_level > 0:
		hot_level -= 1
		
	print("Is baby hot: ", hot_level)
	
	if hot_level <= 1:
		$Termometer.play("normal")
	if hot_level == 2:
		$Termometer.play("warm")
		hot_noise = 0
	if hot_level == 3:
		$Termometer.play("hot")
		hot_noise = 10
