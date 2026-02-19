class_name HeroResource extends CharacterResource

@export var hero_name: String

func _init(_hero_name: String):
	super()
	hero_name = _hero_name
	level_up()

func level_up():
	max_hp += randi_range(5, 10)
	current_hp = max_hp
	
	attack += randi_range(1, 3)
	defense += randi_range(1, 3)
	speed += randi_range(1, 3)
