extends Node2D
signal cardparameters
signal start_game
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.




func _on_start_pressed() -> void:
	start_game.emit()


func _on_cardparameters_pressed() -> void:
	cardparameters.emit()
