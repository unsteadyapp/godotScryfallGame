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
	instatiateTitle()
	var metaData := preload("res://metadata.res")
	#var metaData := preload("res://metadataTest.res")
	#gamedata.nameToPathDict = metaData.nameToFileDict
	gamedata.nameToPathDict = metaData.allcards
func instatiateTitle():
	for i in get_children():
		if i != $back:
			i.queue_free()
	var title = preload("res://title.tscn").instantiate()
	title.start_game.connect(start_game)
	title.cardparameters.connect(cardParameters)
	add_child(title)
	move_child(title,1)
func cardParameters():
	for i in get_children():
		if i != $back:
			i.queue_free()
	var gameNode = preload("res://card_parameters.tscn").instantiate()
	add_child(gameNode)
	move_child(gameNode,1)
func start_game():
	for i in get_children():
		if i != $back:
			i.queue_free()
	var gameNode = preload("res://enchant_worldle_main.tscn").instantiate()
	add_child(gameNode)
	move_child(gameNode,1)
	
