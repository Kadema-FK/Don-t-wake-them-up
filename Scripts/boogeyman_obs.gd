extends Node
var mouse_in = false
var torch_active = false
var state = 0
var noise_level = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if torch_active == true:
		$TorchAcive.global_position = $TorchAcive.get_global_mouse_position()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and mouse_in == true:
			if torch_active == false:
				torch_active = true
				$TorchAcive/RayCast2D.enabled = true
				$TorchAcive.visible = true
				$Torch.visible = false
				print("Torch is active: ", torch_active)
		elif event.button_index == MOUSE_BUTTON_LEFT and event.pressed and torch_active == true:
			torch_active = false
			$TorchAcive/RayCast2D.enabled = false
			$TorchAcive.visible = false
			$Torch.visible = true
			print("Torch is active: ", torch_active)

func _on_area_2d_mouse_entered():
	mouse_in = true;

func _on_area_2d_mouse_exited():
	mouse_in = false;

func start():
	if state <= 0:
		print("Boogy starts")
		state = 1
		$Timer.start()
		$Boogy_run.start()
	
func _on_timer_timeout():
	if state <=3:
		state += 1
		
	if state == 1:
		$Boogeyman.play("1")
		$AnimationPlayer.play("satart")
		noise_level = 0
	
	if state == 2:
		$Boogeyman.play("2")
		$AnimationPlayer.play("satart")
		noise_level = 0
	if state >= 3:
		$Boogeyman.play("3")
		noise_level = 10


func _on_boogy_run_timeout():
	if $TorchAcive/RayCast2D.is_colliding() and $TorchAcive/RayCast2D.get_collider() == $Boogeyman/Boogey_Area2D and state >= 1:
		print("Owwww... My eyes!!!")
		state -= 1
		
	if state == 0:
		noise_level = 0
		$Boogeyman.play("0")
		$Timer.stop()
		$AnimationPlayer.play("stop")
		$Boogy_run.stop()
	if state == 1:
		$Boogeyman.play("1")
		noise_level = 0
	if state == 2:
		$Boogeyman.play("2")
		noise_level = 0

func get_noise_level():
	return noise_level;
