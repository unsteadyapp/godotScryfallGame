extends Node2D
var json_as_text:String = ""
var json_as_dict:Dictionary = {}
var json_unprocessed:Array = []
var json_processed:Array =[]
var listOfNames:Array = []
var start_time:int
const decodeWay = "random"
# Called when the node enters the scene tree for the first time.
#TODO chunk and read the json to get a list of names, then when you need it load thet specific line
func _ready() -> void:
	#start_time = Time.get_ticks_msec()
	$title.start_game.connect(start_game)
	var metaData := preload("res://metadata.res")
	#gamedata.nameToPathDict = metaData.nameToFileDict
	gamedata.nameToPathDict = metaData.allcards
func start_game():
	for i in get_children():
		i.queue_free()
	add_child(preload("res://enchant_worldle_main.tscn").instantiate())
	
