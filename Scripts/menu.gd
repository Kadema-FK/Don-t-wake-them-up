extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/don't wake her up.tscn");


func _on_credits_pressed():
	$Credits2.visible = true
	$back.visible = true
	$Play.visible = false
	$Credits.visible = false
	$Quit.visible = false
	#get_tree().change_scene_to_file("res://Scenes/credits.tscn");


func _on_quit_pressed():
	get_tree().quit();


func _on_back_pressed():
	$Credits2.visible = false
	$back.visible = false
	$Play.visible = true
	$Credits.visible = true
	$Quit.visible = true
