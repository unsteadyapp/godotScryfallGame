extends Node2D
##maps the user names to internal card values
const options:Dictionary[String,String]  = {"EDHREC Rank":"not implemented", "Rarity":"rarity", "Date (yyyy-mm-dd)":"date","Color":"color"}

func _ready() -> void:
	for i in options:
		$pickers/whatTochange.add_item(i)


func _process(delta: float) -> void:
	pass


func _on_add_equality_pressed() -> void:
	var labelOfNew = Label.new()
	var index = $pickers/whatTochange.selected
	var questionSelected = $pickers/whatTochange.get_item_text(index)
	var greaterindex =$pickers/greater.selected
	var comparisionSelected = $pickers/greater.get_item_text(greaterindex)
	var userInputedValue
	var toShowText = $pickers/numberORDropdown/numberInput.text
	if(options[questionSelected] == "rarity"):
		print("debug")
		if(toShowText.to_upper() in cardMetadata.Rarity.keys()):
			userInputedValue = cardMetadata.Rarity[toShowText.to_upper()]
		else:
			print(toShowText.to_upper(),cardMetadata.Rarity.values())
	else:
		userInputedValue = $pickers/numberORDropdown/numberInput.text
	var comparisionsDone:Array[Callable] = []
	if(">" in comparisionSelected):
		comparisionsDone.append(statics.greater)
	if("<" in comparisionSelected):
		comparisionsDone.append(statics.lesser)
	if("=" in comparisionSelected):
		comparisionsDone.append(statics.equal)
	gamedata.pairs.append([options[questionSelected],comparisionsDone,userInputedValue])
	print(gamedata.pairs)
	labelOfNew.text = questionSelected + " " + comparisionSelected +" "+ toShowText
	$pickers/currentrules.add_child(labelOfNew)
