class_name cardMetadata extends Resource
@export var nameToFileDict:Dictionary[String,String] = {}
@export var allcards:Dictionary[String,cardObject]= {}
enum Rarity {COMMON,UNCOMMON,RARE,MYTHIC,SPECIAL}
