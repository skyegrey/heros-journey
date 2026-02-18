class_name Tavern extends Node

@onready var initial_recruitable_hero_count = 5

@onready var tavern_heros: Array[RecruitableHeroResource] = []
@onready var tavern_page_control = %TavernPageControl
@onready var hero_manager = %HeroManager
@onready var guild_inventory = %GuildInventory

@onready var character_names: Array = [ 
		"Myriil", "Aywin", "Vulred", "Simimar", "Vesryn", "Ailluin", 
		"Falael",  "Lyari", "Toross", "Taerentym", "Reina"
	]

func _ready():
	for _hero_count in range(initial_recruitable_hero_count):
		tavern_heros.append(_generate_hero())
	_update_tavern_listing_ui()

func _generate_hero():
	var hero_name = character_names.pick_random()
	var gold_cost = _roll_gold_cost()
	return RecruitableHeroResource.new(hero_name, gold_cost)

func _roll_gold_cost():
	return randi_range(77, 513)

func _update_tavern_listing_ui():
	tavern_page_control.create_recruitable_hero_list(tavern_heros)

func on_hero_recruit_button_pressed(
		recruitable_hero_resource: RecruitableHeroResource,
		recruitable_hero_control: RecruitableHeroControl
	):
	if guild_inventory.gold < recruitable_hero_resource.gold_cost:
		return
	guild_inventory.pay_gold(recruitable_hero_resource.gold_cost)
	hero_manager.add_hero(recruitable_hero_resource)
	tavern_heros.erase(recruitable_hero_resource)
	_update_tavern_listing_ui()
