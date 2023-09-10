extends Node2D

@export var noiseLevel = 0;
@export var maxQuietTime = 40;
@export var maxMediumNoise = 70;
@export var maxNoiseLevel = 100;

#var tmp_direction = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationTree.active = true;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	if tmp_direction == 0:
#		noiseLevel += 0.1;
#	else:
#		noiseLevel -= 0.1;
#	if maxNoiseLevel <= noiseLevel:
#		tmp_direction = -1;
	$Label.text = "Noise level: " + str(noiseLevel);
	#if noiseLevel > maxQuietTime:
	#	print ("Make a noise!")
	pass
