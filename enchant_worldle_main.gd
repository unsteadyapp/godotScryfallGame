extends Node2D
var listOfAllowedCards:Dictionary[String,cardObject] = {}
var secretCard:cardObject
func _ready() -> void:
	print(gamedata.nameToPathDict.size())
	print(gamedata.pairs)
	if(gamedata.pairs.size()>0):
		for i in gamedata.nameToPathDict:
			var cardAsObject:cardObject = gamedata.nameToPathDict[i]
			var shouldBreak = false
			
			for j in gamedata.pairs:
				shouldBreak = false
				var canBeCalled:Array[Callable] = j[1]
				for k in canBeCalled:
					#print(cardAsObject.get(j[0]),j[0])
					if(k.call(cardAsObject.get(j[0]),j[2])):
						shouldBreak = true
						break
				if not shouldBreak:
					break
			if(not shouldBreak):
				continue
			listOfAllowedCards[i] = cardAsObject
	else:
		listOfAllowedCards = gamedata.nameToPathDict
	secretCard = listOfAllowedCards[listOfAllowedCards.keys().pick_random()]
	print(secretCard.cardName,cardMetadata.Rarity.find_key(secretCard.rarity))
func _process(delta: float) -> void:
	if "\n" in $controlLayers/input.text:
		makeGuess()
func _on_button_pressed() -> void:
	makeGuess()
func makeGuess():
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
				if(not file in listOfAllowedCards.values()):
					child.color = Color(0.415, 0.406, 0.406, 1.0)
				var nameLabel:LinkButton = child.find_child("name")
				nameLabel.text = file.cardName
				nameLabel.uri = file.scryfallLink
				#type
				var typeLabel:Label = child.find_child("type")
				typeLabel.text = file.cardType
				if(file.cardType == secretCard.cardType):
					typeLabel.modulate = Color(0.0, 0.413, 0.0, 1.0)
				elif(includesIn(secretCard.cardType,file.cardType)):
					typeLabel.modulate = Color(0.745, 0.647, 0.0, 1.0)
				else:
					typeLabel.modulate =  Color(0.546, 0.0, 0.0, 1.0)
				#subtype
				var subtypeLabel:Label = child.find_child("subtype")
				if(file.subtype != ""):
					subtypeLabel.text = file.subtype
				else:
					subtypeLabel.text = "No subtype"
				if(file.subtype == secretCard.subtype):
					subtypeLabel.modulate = Color(0.0, 0.413, 0.0, 1.0)
				elif(includesIn(secretCard.subtype,file.subtype)):
					subtypeLabel.modulate = Color(0.745, 0.647, 0.0, 1.0)
				else:
					subtypeLabel.modulate =  Color(0.546, 0.0, 0.0, 1.0)
				#color
				var colorLabel:Label= child.find_child("color")
				if(file.color != ""):
					colorLabel.text = file.color
				else:
					colorLabel.text = "C"
				#print(file.color)
				if(file.color == secretCard.color):
					colorLabel.modulate = Color(0.0, 0.413, 0.0, 1.0)
				elif(includesIn(secretCard.color,file.color,"")):
					colorLabel.modulate = Color(0.745, 0.647, 0.0, 1.0)
				else:
					colorLabel.modulate =  Color(0.546, 0.0, 0.0, 1.0)
				#date label
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
				dateLabel.text += yeartext
				#if(file.cardType == secretCard.cardType):
					#typeLabel.modulate = Color(0.0, 0.413, 0.0, 1.0)
				#elif(includesIn(secretCard.cardType,file.cardType)):
					#typeLabel.modulate = Color(0.745, 0.647, 0.0, 1.0)
				#else:
					#typeLabel.modulate =  Color(0.546, 0.0, 0.0, 1.0)
				#CMC
				var fileCmc=str(round(file.cmc))
				var secretCmc=str(round(secretCard.cmc))
				var cmcLabel = child.find_child("cmc")
				if(file.cmc==secretCard.cmc):
					cmcLabel.modulate = Color(0.0, 0.413, 0.0, 1.0)
				else:
					cmcLabel.modulate = Color(0.546, 0.0, 0.0, 1.0)
					if fileCmc<secretCmc:
						cmcLabel.text += "↑"
					else:
						cmcLabel.text += "↓"
				cmcLabel.text+=fileCmc
				
				var rarityGreater:ColorRect =  child.find_child("rarity")
				print(rarityGreater.name)
				if(secretCard.rarity != file.rarity):
					rarityGreater.color = Color(0.546, 0.0, 0.0, 1.0)
					print("gave red")
				else:
					rarityGreater.color =Color(0.0, 0.413, 0.0, 1.0)
				var rarityColorbox:ColorRect =rarityGreater.get_child(0)
				print(file.rarity)
				print(rarityColorbox.name)
				#AI was used in the choice of RGB values for rarity representation
				if(file.rarity == cardMetadata.Rarity.COMMON):
					rarityColorbox.color = Color()
				elif(file.rarity == cardMetadata.Rarity.UNCOMMON):
					rarityColorbox.color = Color(0.73, 0.86, 0.92)
				elif(file.rarity == cardMetadata.Rarity.RARE):
					rarityColorbox.color = Color(0.90, 0.80, 0.55, 1.0)
				elif(file.rarity == cardMetadata.Rarity.MYTHIC):
					rarityColorbox.color = Color(0.96, 0.57, 0.02)
				else:
					rarityColorbox.color = Color(0.76, 0.61, 0.78, 1.0)
				$controlLayers/cardsScroll/ordering.add_child(child)
				$controlLayers/debug.text = file.date
		else:
			print("weird error, said file existed but didn't")
	else:
		$controlLayers/debug.text = $controlLayers/input.text + " failed to find"
	$controlLayers/input.text = ""
func includesIn(a:String,b:String,delimiter=" "):
	##checks if any word in string a is in string b
	for i in a.split(delimiter,false):
		if i in b.split(delimiter,false):
			return true
	return false
