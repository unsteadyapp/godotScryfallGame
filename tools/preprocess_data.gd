@tool
extends EditorScript
var filepath = "res://tools/testdata2.jsonl"
#var filepath = "res://tools/defaultCards.jsonl"
var hintpath = "hint.res"
var cardMetadataInstance:cardMetadata
var text_array: PackedStringArray 
var nameToRescourceDict = {}
var cardHint:metaHint
#var hintDict:Dictionary[String,String] = {}
func _run():
	allAtOnce()
func allAtOnce():
	cardHint = metaHint.new()
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
		if(createRescource(_line)):
			return
		#json_unprocessed.resize(orignalLength-i-1)
	var valuesOfRescourceDictionary:Array = nameToRescourceDict.values()
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
	var metaDatapath
	if(filepath == "res://tools/testdata2.jsonl"):
		metaDatapath = "res://metadataTest.res"
	else:
		metaDatapath = "res://metadata.res"
	cardMetadataInstance.take_over_path(metaDatapath)
	print(otherBroken.slice(0,100))
	#print(testOfbroken.slice(0,100))
	#for i in range(100):
		#print(testOfbroken[i]["scryfall_uri"])
	if(ResourceSaver.save(cardMetadataInstance,metaDatapath) == OK):
		print("disk written")
	else:
		print("error")
	cardHint.take_over_path(hintpath)
	if(ResourceSaver.save(cardHint,hintpath) == OK):
		print("disk written")
	else:
		print("error")
	#var task_id = WorkerThreadPool.add_group_task(addJson,json_unprocessed.size())
#func addJson(IntTojsonParsable):
	#if(json_unprocessed[IntTojsonParsable] != ""):
		#var json_as_dict = JSON.parse_string(json_unprocessed[IntTojsonParsable])
		#if json_as_dict:
			#json_processed[IntTojsonParsable] = json_as_dict["name"]
var testOfbroken = []
var otherBroken = []
func createRescource(IntTojsonParsable):
	if(text_array[IntTojsonParsable] != ""):
		var json_as_dict:Dictionary = JSON.parse_string(text_array[IntTojsonParsable])
		if json_as_dict:
			if(json_as_dict["legalities"]["vintage"] == "legal" or json_as_dict["legalities"]["vintage"]=="restricted"):
				if("oracle_id" in json_as_dict):
					cardHint.hint[json_as_dict["oracle_id"]] = json_as_dict["name"]
				else:
					#print(json_as_dict["name"], " no oid")
					return
				#json_processed[IntTojsonParsable] = json_as_dict["name"]
				#TODO get firstprint data
				#print("saved")
				var rescource = cardObject.new()
				#for i in json_as_dict:
					#rescource.set(i,json_as_dict[i])#
				rescource.cardName = json_as_dict["name"]
				if "edhrec_rank" in json_as_dict:
					rescource.edhrecRank = int(json_as_dict["edhrec_rank"])
					if rescource.edhrecRank == 0:
						otherBroken.append(json_as_dict["edhrec_rank"])
					#print(json_as_dict["edhrec_rank"])
				else:
					#print(json_as_dict["name"])
					testOfbroken.append(json_as_dict)
				if("cmc" not in json_as_dict):
					#print("Not sure what happened", json_as_dict)
					#return true
					#print(json_as_dict["name"])
					return
				else:
					rescource.cmc = json_as_dict["cmc"]
					
				rescource.scryfallLink = json_as_dict["scryfall_uri"]
				var upercase:String = json_as_dict["rarity"].to_upper()
				#print(json_as_dict["name"],cardMetadata.Rarity[upercase])
				var rarityEnum:cardMetadata.Rarity
				if upercase in cardMetadata.Rarity:
					rarityEnum = cardMetadata.Rarity[upercase]
					if(rarityEnum!=null):
						rescource.rarity = rarityEnum
					#print(rescource.rarity)
					else:
						printerr("error with rarity:"+json_as_dict["rarity"].to_upper(),json_as_dict["name"])
				else:
					#print(json_as_dict["name"], upercase)
					return
				if "type_line" in json_as_dict:
					var typeLineArray = json_as_dict["type_line"].split("—")
					rescource.cardType = typeLineArray[0]
					if(typeLineArray.size()>1):
						rescource.subtype = json_as_dict["type_line"].split("—")[1]
				else:
					return
				if "colors" in json_as_dict:
					for i in json_as_dict["colors"]:
						rescource.color+=i
				else:
					#print(json_as_dict["name"]," didn't have color")
					return
				
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
