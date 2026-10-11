@tool
extends EditorScript
var json_processed = []
var filepath = "res://tools/testdata2.jsonl"
#var filepath = "res://tools/defaultCards.jsonl"
var json_unprocessed
func _run():
	allAtOnce()
func allAtOnce():
	var start = Time.get_ticks_msec()
	var json_as_text = FileAccess.get_file_as_string(filepath)
	print(Time.get_ticks_msec()-start)
	json_unprocessed = json_as_text.split("\n")
	print(Time.get_ticks_msec())
	json_as_text = ""
	var orignalLength = json_unprocessed.size()
	json_processed.resize(json_unprocessed.size())
	for i in range(orignalLength):
		createRescource(orignalLength-i-1)
		#json_unprocessed.resize(orignalLength-i-1)
	print(Time.get_ticks_msec()-start)
	print(json_processed.slice(0,100,1))
	
	#var task_id = WorkerThreadPool.add_group_task(addJson,json_unprocessed.size())
func addJson(IntTojsonParsable):
	if(json_unprocessed[IntTojsonParsable] != ""):
		var json_as_dict = JSON.parse_string(json_unprocessed[IntTojsonParsable])
		if json_as_dict:
			json_processed[IntTojsonParsable] = json_as_dict["name"]

func createRescource(IntTojsonParsable):
	if(json_unprocessed[IntTojsonParsable] != ""):
		var json_as_dict = JSON.parse_string(json_unprocessed[IntTojsonParsable])
		if json_as_dict:
			if(json_as_dict["legalities"]["vintage"] != "not_legal" and json_as_dict["legalities"]["vintage"]!="banned"):
				#json_processed[IntTojsonParsable] = json_as_dict["name"]
				#TODO get firstprint data
				print("saved")
				var rescource = Resource.new()
				for i in json_as_dict:
					rescource.set(i,json_as_dict[i])
				if(ResourceSaver.save(rescource,"res://resccource/"+str(Time.get_datetime_string_from_system()+".tres")) == OK):
					print("disk written")
				else:
					print("error")
func linebyline():
	var start_time = Time.get_ticks_msec()
	#print("jf")
	
	#var lines = FileAccess.open(filepath,FileAccess.READ)
	#print(lines.get_as_text()[0])
	var fileObj = FileAccess.open(filepath,FileAccess.READ)
	if fileObj:
		while not fileObj.eof_reached():
			var line = fileObj.get_line()
			addJsonWithoutKnowingLength(line)
			#break
	else:
		print("failed")
	print((Time.get_ticks_msec()-start_time)/1000.0)
func addJsonWithoutKnowingLength(json):
	if(json != ""):
		var json_as_dict = JSON.parse_string(json)
		if json_as_dict:
			json_processed.append(json_as_dict)
		else:
			json_processed.append(null)
