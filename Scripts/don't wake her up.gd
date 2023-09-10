extends Node2D

var day = 6;
const eventTimeMinMax = [[5,8], [4,7], [3,6]]
var eventsInHour0 = [0,0];
var hour = 0;
const sInHour = 20;
var calmingEffect = 5;
@onready var obstacles = [$Cat, $Dog, $Window, $Boogeyman];
var pause = false

var rng; #random numer generator

# Called when the node enters the scene tree for the first time.
func _ready():	
	rng = RandomNumberGenerator.new();
	eventsInHour0[0] = rng.randi_range(0,1);
	eventsInHour0[1] = rng.randi_range(2,obstacles.size()-1);
	#obstacles[0].start();
	resetEventTimer(eventTimeMinMax[0][0], eventTimeMinMax[0][1]);
	$GameTimer.start(sInHour);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var i: int = 0;
	var noise = 0;
	while i < obstacles.size():
		noise += obstacles[i].get_noise_level();
		i += 1;
	if $Baby.noiseLevel > 0:
		noise -= calmingEffect;
	$Baby.noiseLevel += noise * delta;
	
	if $Baby.isTooLoud(): get_tree().change_scene_to_file("res://Scenes/defeated.tscn");
	if hour >= day: get_tree().change_scene_to_file("res://Scenes/victory_end_scene.tscn");
	pass;

func resetEventTimer(start, end):
	var time = rng.randf_range(start, end);
	print ("New time: " + str(time));
	$EventTimer.start(time);

func _on_game_timer_timeout():
	hour += 1;
	pass # Replace with function body.


func _on_event_timer_timeout():
	var number;
	if hour == 0:
		number = eventsInHour0[rng.randi_range(0,1)];
	else:
		number = rng.randi_range(0,obstacles.size()-1);
	print("Number "+str(number))
	obstacles[number].start();
	var maks_array = eventTimeMinMax.size()-1;
	if hour < maks_array:
		resetEventTimer(eventTimeMinMax[hour][0], eventTimeMinMax[hour][1]);
	else:
		resetEventTimer(eventTimeMinMax[maks_array][0], eventTimeMinMax[maks_array][1]);
	pass # Replace with function body.

func _on_pause_button_pressed():
	get_tree().paused = true
	$pause.visible = true
	
func _on_pause_popup_close_pressed():
	$pause.visible = false
	get_tree().paused = false

func _input(event):
	if Input.is_action_just_pressed("pause"):
		if pause == false:
			pause = true
			_on_pause_button_pressed()
		elif Input.is_action_just_pressed("pause") and pause == true:
			pause = false
			_on_pause_popup_close_pressed()

	if pause == true:
		if Input.is_action_just_pressed("Y"):
			pause = false
			get_tree().paused = false
			get_tree().change_scene_to_file("res://Scenes/menu.tscn");
		if Input.is_action_just_pressed("N"):
			pause = false
			_on_pause_popup_close_pressed()
