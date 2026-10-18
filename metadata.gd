class_name cardMetadata extends Resource
@export var nameToFileDict:Dictionary[String,String] = {}
@export var allcards:Dictionary[String,cardObject]= {}
enum Rarity {COMMON,UNCOMMON,RARE,MYTHIC,SPECIAL}
enum MtgColors {WHITE=1, BLUE = 2, BLACK=4, RED=8, GREEN = 16}
