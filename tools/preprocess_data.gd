@tool
extends EditorScript
var filepath = "res://tools/testdata2.jsonl"
#var filepath = "res://tools/defaultCards.jsonl"
var cardMetadataInstance:cardMetadata
var text_array: PackedStringArray 
var nameToRescourceDict = {}
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
	#json_processed.resize(text_array.size())
	cardMetadataInstance = cardMetadata.new()
	for _line in range(orignalLength):
		createRescource(_line)
		#json_unprocessed.resize(orignalLength-i-1)
	var valuesOfRescourceDictionary = nameToRescourceDict.values()
	print(valuesOfRescourceDictionary)
	var namesInRescourcedictionary = nameToRescourceDict.keys()
	for i in range(len(valuesOfRescourceDictionary)):
		cardMetadataInstance.allcards[namesInRescourcedictionary[i]] = valuesOfRescourceDictionary[i]
		#if(ResourceSaver.save(valuesOfRescourceDictionary[i],"res://resccource/" + str(i) +"text"+ ".tres") == OK):
			#cardMetadataInstance.nameToFileDict[namesInRescourcedictionary[i]]=str(i)
		#if(nameToRescourceDict[i]):
		#if(ResourceSaver.save(valuesOfRescourceDictionary[i],"res://resccource/" + namesInRescourcedictionary[i] +"text"+ ".tres") == OK):
			#cardMetadataInstance.nameToFileDict[namesInRescourcedictionary[i]]=namesInRescourcedictionary[i]
		#else:
			#print("error")
	print(Time.get_ticks_msec()-start)
	const metaDatapath = "res://metadata.res"
	cardMetadataInstance.take_over_path(metaDatapath)
	if(ResourceSaver.save(cardMetadataInstance,metaDatapath) == OK):
		print("disk written")
	else:
		print("error")
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
				#json_processed[IntTojsonParsable] = json_as_dict["name"]
				#TODO get firstprint data
				#print("saved")
				var rescource = cardObject.new()
				#for i in json_as_dict:
					#rescource.set(i,json_as_dict[i])
				rescource.cardName = json_as_dict["name"]
				var upercase:String = json_as_dict["rarity"].to_upper()
				print(json_as_dict["name"],cardMetadata.Rarity[upercase])
				var rarityEnum:cardMetadata.Rarity = cardMetadata.Rarity[upercase]
				if(rarityEnum):
					rescource.rarity = rarityEnum
					print(rescource.rarity)
				else:
					printerr("error with rarity:"+json_as_dict["rarity"].to_upper())
				rescource.cardType = json_as_dict["type_line"].split("—")[0]
				rescource.date = json_as_dict["released_at"]
				if(json_as_dict["name"] in nameToRescourceDict):
					if(json_as_dict["released_at"]<nameToRescourceDict[json_as_dict["name"]].date):
						nameToRescourceDict[json_as_dict["name"]] = rescource
				else:
					nameToRescourceDict[json_as_dict["name"]] = rescource
				
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
