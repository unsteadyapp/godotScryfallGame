extends Node2D

var secretCard:cardObject
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	secretCard = gamedata.nameToPathDict[gamedata.nameToPathDict.keys().pick_random()]
	print(secretCard.cardName)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	var guessedText:String = $controlLayers/input.text
	var editedGuessedText = guessedText.strip_edges()
	if editedGuessedText in gamedata.nameToPathDict:
		var file:cardObject = gamedata.nameToPathDict[editedGuessedText]
		#var file:cardObject = load("res://resccource/" + gamedata.nameToPathDict[$controlLayers/input.text] + ".tres")
		if file:
			if(secretCard.cardName == editedGuessedText):
				$controlLayers/debug.text = "you win!"
			else:
				var child := preload("res://list_entry.tscn").instantiate()
				var nameLabel = child.find_child("name")
				nameLabel.text = file.cardName
				var typeLabel:Label = child.find_child("type")
				typeLabel.text = file.cardType
				
				if(file.cardType == secretCard.cardType):
					typeLabel.modulate = Color(0.0, 0.413, 0.0, 1.0)
				elif(includesIn(secretCard.cardType,file.cardType)):
					typeLabel.modulate = Color(0.745, 0.647, 0.0, 1.0)
				else:
					typeLabel.modulate =  Color(0.546, 0.0, 0.0, 1.0)
				var dateLabel = child.find_child("year")
				var yeartext = file.date.get_slice("-",0)
				var secretCardyeartext = secretCard.date.get_slice("-",0)
				if(yeartext == secretCardyeartext):
					dateLabel.modulate = Color(0.0, 0.413, 0.0, 1.0)
				else:
					dateLabel.modulate = Color(0.546, 0.0, 0.0, 1.0)
					if secretCardyeartext>yeartext:
						dateLabel.text += "↑"
					else:
						dateLabel.text += "↓"
				var rarityGreater:ColorRect =  child.find_child("rarity")
				if(secretCard.rarity == file.rarity):
					rarityGreater.self_modulate = Color(0.546, 0.0, 0.0, 1.0)
				else:
					rarityGreater.self_modulate =Color(0.0, 0.413, 0.0, 1.0)
				var rarityColorbox:ColorRect =rarityGreater.get_child(0)
				print(file.rarity)
				#AI was used in the choice of RGB values for rarity representation
				if(file.rarity == cardMetadata.Rarity.COMMON):
					rarityColorbox.modulate = Color(33/255, 33/255, 33/255)
				elif(file.rarity == cardMetadata.Rarity.UNCOMMON):
					rarityColorbox.modulate = Color(0.73, 0.86, 0.92)
				elif(file.rarity == cardMetadata.Rarity.RARE):
					rarityColorbox.modulate = Color(0.90, 0.80, 0.55, 1.0)
				elif(file.rarity == cardMetadata.Rarity.MYTHIC):
					rarityColorbox.modulate = Color(0.96, 0.57, 0.02)
				else:
					rarityColorbox.modulate = Color(0.76, 0.61, 0.78, 1.0)
				dateLabel.text += yeartext
				$controlLayers/cardsScroll/ordering.add_child(child)
				$controlLayers/debug.text = file.date
		else:
			print("weird error, said file existed but didn't")
	else:
		$controlLayers/debug.text = $controlLayers/input.text + " failed to find"
func includesIn(a,b):
	##checks if any word in string a is in string b
	for i in a.split():
		if i in b.split():
			return true
	return false
