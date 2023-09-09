extends Node2D

var clock;
const hour = 9000;
var day = 6;


# Called when the node enters the scene tree for the first time.
func _ready():
	clock=0;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	clock+=1;
	get_node("Test_Clock").text = str(clock) + " - " + str(clock/hour) + ":" + str(clock%hour);
	pass
