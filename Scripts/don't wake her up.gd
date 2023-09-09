extends Node2D

var day = 6;
var eventTime = [[5,8], [4,7], [3,6]]
var hour = 0;
const sInHour = 20;

# Called when the node enters the scene tree for the first time.
func _ready():	
	resetEventTimer(eventTime[0][0], eventTime[0][1]);
	$GameTimer.start(sInHour);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func resetEventTimer(start, end):
	var rng = RandomNumberGenerator.new();
	var time = rng.randf_range(start, end);
	print ("New time: " + str(time));
	$Window.start();
	$EventTimer.start(time);

func _on_game_timer_timeout():
	hour += 1;
	pass # Replace with function body.


func _on_event_timer_timeout():
	var maks_array = eventTime.size()-1;
	#print("Maks "+str(maks_array))
	#print ("Timeout. Game time: "+ str(hour)  + " hour: " + str($GameTimer.time_left) + "s")
	if hour < maks_array:
		resetEventTimer(eventTime[hour][0], eventTime[hour][1]);
	else:
		resetEventTimer(eventTime[maks_array][0], eventTime[maks_array][1]);
	pass # Replace with function body.
