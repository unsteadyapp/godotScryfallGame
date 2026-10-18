class_name cardObject extends Resource
##card name, coresponds to "name"
@export var cardName:String = ""
##Card type/supertype
@export var cardType:String
##First print date
@export var date:String = ""
##card rarity
@export var rarity:cardMetadata.Rarity = cardMetadata.Rarity.COMMON
##coresponds to cmc
@export var cmc:float = 0.0
##card subtypes (actually anything on the right side of ---
@export var subtype:String = ""
##card color
@export var color:String = "" # colorless
##coresponds to "scryfall_uri"
@export var scryfallLink:String = "" 
##edhrec rank, lower means more popular
@export var edhrecRank:int
