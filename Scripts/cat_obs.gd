extends Node
var mouse_in = false
var state = 0
var noise_level = 0

#var isDoingMischief: bool = false;
const time = 5;

enum {SLEEP, LOOKING, TOUCHING, SCARED}

#@onready var catAnimatedSprite = $Sprite2D/CatAnimatedSprite;

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationTree.active = true;
#	catAnimatedSprite.play("sleep");
	start();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start():
	print("Cat starts");
	#isDoingMischief = true;
	state = LOOKING;
#	catAnimatedSprite.play("pac2");
	$MischiefTimer.start(time);
	pass


func _on_mischief_timer_timeout():
	if state == LOOKING:
#		catAnimatedSprite.play("pac3");
		state = TOUCHING
		$MischiefTimer.start(time);
	elif state == TOUCHING:
		noise_level = 10;
		$TV.turnOnTV();
		state = SCARED;
		$MischiefTimer.start(time);
	elif state == SCARED:
		state = SLEEP;
		noise_level = 0;
#		catAnimatedSprite.play("sleep");
		
	pass # Replace with function body.

func _input(event):
	#print("_input")
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and mouse_in == true:
			print("State: ", state)
			if state >= LOOKING:
				state = SLEEP;
#				catAnimatedSprite.play("sleep");
				noise_level = 0;
				$MischiefTimer.stop()

func _on_area_2d_mouse_entered():
	mouse_in = true;

func _on_area_2d_mouse_exited():
	mouse_in = false;

func get_noise_level():
	return $TV.get_noise_level();
