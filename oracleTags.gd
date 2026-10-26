@tool
extends EditorScript
var file = r"tools\oracleTags.jsonl"
var metaAcualPath = r"res://metadataTest.res"
var metaPath:cardMetadata
var text_array =[]
var hint = preload("res://hint.res")
const mode = "makeTags"
#var cardMetadataInstancesmetaAcualPath
func _run() -> void:
	var oldMetaPath:cardMetadata = load(metaAcualPath)
	metaPath = cardMetadata.new()
	#REMEMVER THAT IT ONLY COPIES SPECIFIED
	metaPath.allcards = oldMetaPath.allcards
	var start = Time.get_ticks_msec()
	var jsonFile = FileAccess.open(file,FileAccess.READ)
	print(Time.get_ticks_msec()-start)
	#json_unprocessed = json_as_text.split("\n")
	print(Time.get_ticks_msec())
	#json_as_text = ""
	text_array = jsonFile.get_buffer(jsonFile.get_length()).get_string_from_utf8().split("\n")
	var orignalLength = text_array.size()
	#json_processed.resize(text_array.size())
	#print(metaPath.tagArray.is_read_only())
	#return
	#cardMetadataInstance = load(metaPath)
	for _line in range(orignalLength):
		if(text_array[_line] != ""):
			var json_as_dict:Dictionary = JSON.parse_string(text_array[_line])
			if json_as_dict:
				if(mode=="tagCards"):
					metaPath.tagArray.append(json_as_dict["label"])
					for i in json_as_dict["taggings"]:
						if("oracle_id" in i):
							var oracleId = i["oracle_id"]
							if(oracleId in hint.hint):
								var hintedCardname = hint.hint[oracleId]
								if hintedCardname in metaPath.allcards:
									print(json_as_dict["label"])
									metaPath.allcards[hintedCardname].tags.append(json_as_dict["label"])
								else:
									print(hintedCardname)
				elif(mode=="makeTags"):
					for i in json_as_dict["taggings"]:
						if("oracle_id" in i):
							var oracleId = i["oracle_id"]
							if(oracleId in hint.hint):
								var hintedCardname = hint.hint[oracleId]
								if hintedCardname in metaPath.allcards:
									print(json_as_dict["label"])
									if(json_as_dict["label"] in metaPath.allTags):
										metaPath.allTags[json_as_dict["label"]].append(hintedCardname)
									else:
										metaPath.allTags[json_as_dict["label"]] = [hintedCardname]
	metaPath.take_over_path(metaAcualPath)
	if(ResourceSaver.save(metaPath,metaAcualPath) == OK):
		print("disk written")
	else:
		print("error")
