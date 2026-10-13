@tool
extends EditorScript
#var json_processed = []
var filepath = "res://tools/testdata2.jsonl"
#var filepath = "res://tools/defaultCards.jsonl"
var json_unprocessed
var cardMetadataInstance:cardMetadata
var re:= RegEx.create_from_string(r"[^\w]")
var text_array: PackedStringArray 
var nameToRescourceDict = {}
var namelist = []
var stripedList = []
func _run():
	allAtOnce()
func allAtOnce():
	var start = Time.get_ticks_msec()
	var jsonFile = FileAccess.open(filepath,FileAccess.READ)
	print(Time.get_ticks_msec()-start)
	#json_unprocessed = json_as_text.split("\n")
	print(Time.get_ticks_msec())
	#json_as_text = ""
	text_array = jsonFile.get_buffer(jsonFile.get_length()).get_string_from_utf8().split("\n")
	var orignalLength = text_array.size()
	for _line in range(orignalLength):
		createRescource(_line)
	print(Time.get_ticks_msec()-start)
	#var task_id = WorkerThreadPool.add_group_task(addJson,json_unprocessed.size())
#func addJson(IntTojsonParsable):
	#if(json_unprocessed[IntTojsonParsable] != ""):
		#var json_as_dict = JSON.parse_string(json_unprocessed[IntTojsonParsable])
		#if json_as_dict:
			#json_processed[IntTojsonParsable] = json_as_dict["name"]

func createRescource(IntTojsonParsable):
	if(text_array[IntTojsonParsable] != ""):
		var json_as_dict = JSON.parse_string(text_array[IntTojsonParsable])
		if json_as_dict:
			if(json_as_dict["legalities"]["vintage"] != "not_legal" and json_as_dict["legalities"]["vintage"]!="banned"):
				if(json_as_dict["name"] not in namelist):
					var stripped = re.sub(json_as_dict["name"],"",true)
					print(json_as_dict["name"])
					if stripped in stripedList:
						print(json_as_dict["name"],namelist[stripedList.find(stripped)])
						print(stripped)
					else:
						print(stripped)
						stripedList.append(stripped)
						namelist.append(json_as_dict["name"])
				#return [json_as_dict["name"],rescource]
#func linebyline():
	#var start_time = Time.get_ticks_msec()
	##print("jf")
	#
	##var lines = FileAccess.open(filepath,FileAccess.READ)
	##print(lines.get_as_text()[0])
	#var fileObj = FileAccess.open(filepath,FileAccess.READ)
	#if fileObj:
		#while not fileObj.eof_reached():
			#var line = fileObj.get_line()
			#addJsonWithoutKnowingLength(line)
			##break
	#else:
		#print("failed")
	#print((Time.get_ticks_msec()-start_time)/1000.0)
#func addJsonWithoutKnowingLength(json):
	#if(json != ""):
		#var json_as_dict = JSON.parse_string(json)
		#if json_as_dict:
			#json_processed.append(json_as_dict)
		#else:
			#json_processed.append(null)
