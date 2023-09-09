extends Node2D

var day = 6;
const eventTimeMinMax = [[5,8], [4,7], [3,6]]
var eventsInHour0 = [0,0];
var hour = 0;
const sInHour = 20;
@onready var obstacles = [$Cat, $Dog, $Window, $Boogeyman];


var rng; #random numer generator

# Called when the node enters the scene tree for the first time.
func _ready():	
	rng = RandomNumberGenerator.new();
	eventsInHour0[0] = rng.randi_range(0,1);
	eventsInHour0[1] = rng.randi_range(2,obstacles.size()-1);
	resetEventTimer(eventTimeMinMax[0][0], eventTimeMinMax[0][1]);
	$GameTimer.start(sInHour);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

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
