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
	var file = "res://oracleCards.jsonl"
	
	if(decodeWay == "new"):
		var fileObj = FileAccess.open(file,FileAccess.READ)
		if file:
			while not fileObj.eof_reached():
				var line = fileObj.get_line()
				addJsonWithoutKnowingLength(line)
		else:
			print("failed")
		print(Time.get_ticks_msec())
	elif(decodeWay == "string"):
		json_as_text = FileAccess.get_file_as_string(file)
		print(Time.get_ticks_msec())
		json_unprocessed = json_as_text.split("\n")
		print(Time.get_ticks_msec())
		json_as_text = ""
		var orignalLength = json_unprocessed.size()
		json_processed.resize(json_unprocessed.size())
		for i in range(orignalLength):
			json_processed[i] = json_unprocessed.find("")
		json_unprocessed = []
		print(json_unprocessed)
		print(json_processed.slice(0,100,1))
	else:
		var start = Time.get_ticks_msec()
		json_as_text = FileAccess.get_file_as_string(file)
		print(Time.get_ticks_msec()-start)
		json_unprocessed = json_as_text.split("\n")
		print(Time.get_ticks_msec())
		json_as_text = ""
		var orignalLength = json_unprocessed.size()
		json_processed.resize(json_unprocessed.size())
		for i in range(orignalLength):
			addJson(orignalLength-i-1)
			json_unprocessed.resize(orignalLength-i-1)
		print(json_unprocessed)
		print(json_processed.slice(0,100,1))
		#var task_id = WorkerThreadPool.add_group_task(addJson,json_unprocessed.size())
func addJsonWithoutKnowingLength(json):
	if(json != ""):
		var json_as_dict = JSON.parse_string(json)
		if json_as_dict:
			json_processed.append(json_as_dict)
		else:
			json_processed.append(null)
func addJson(IntTojsonParsable):
	if(json_unprocessed[IntTojsonParsable] != ""):
		json_as_dict = JSON.parse_string(json_unprocessed[IntTojsonParsable])
		if json_as_dict:
			json_processed[IntTojsonParsable] = json_as_dict["name"]
func start_game():
	for i in get_children():
		i.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
