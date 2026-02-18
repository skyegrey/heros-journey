class_name RecruitableHeroResource extends Resource

@export var hero_name: String
@export var gold_cost: int

func _init(_hero_name: String, _gold_cost: int):
	hero_name = _hero_name
	gold_cost = _gold_cost
