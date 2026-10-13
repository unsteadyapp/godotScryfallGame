extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	var file:cardObject = load("res://resccource/" + gamedata.nameToPathDict[$controlLayers/input.text] + ".tres")
	if file:
		$controlLayers/debug.text = file.date
	else:
		print($controlLayers/input.text + " failed to find")
