class_name cardMetadata extends Resource
@export var allcards:Dictionary[String,cardObject]= {}
@export var tagArray:Array = []
enum Rarity {COMMON,UNCOMMON,RARE,MYTHIC,SPECIAL}
enum MtgColors {WHITE=1, BLUE = 2, BLACK=4, RED=8, GREEN = 16}
@export var allTags:Dictionary[String,Array] = {}
