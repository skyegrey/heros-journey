class_name GuildInventory extends Node

@onready var ui = %UI

@onready var guild_menu = %GuildMenu
@onready var tavern_page_control = %TavernPageControl
@onready var gear_page = %GearPage

@onready var gold: int = 500
@onready var gear: Array[GearResource]

@export var weapon_texture: Texture2D
@export var armor_texture: Texture2D

@export var reward_gold_lower_bound = 50
@export var reward_gold_upper_bound = 100

func _ready():
	update_gold_texts()
	_create_initial_gear()
	gear_page.on_gear_left_cell.connect(_on_gear_left_cell)

func add_gold(gold_amount: int):
	gold += gold_amount
	update_gold_texts()

func pay_gold(gold_amount: int):
	gold -= gold_amount
	update_gold_texts()

func update_gold_texts():
	guild_menu.update_gold(gold)
	tavern_page_control.update_gold(gold)

func _create_initial_gear():
	add_gear(
		[
			roll_weapon(1),
			roll_armor(1)
		]
	)

func add_gear(new_gear: Array[GearResource]):
	gear.append_array(new_gear)
	gear_page.update_gear_page(gear)

func _on_gear_left_cell(gear_cell_index: int):
	gear.remove_at(gear_cell_index)
	gear_page.update_gear_page(gear)

func roll_weapon(weapon_level: int):
	var new_weapon = GearResource.new('weapon', weapon_texture)
	new_weapon.bonus_attack = randi_range(1 * weapon_level, 3 * weapon_level)
	new_weapon.bonus_speed = randi_range(0 * weapon_level, 2 * weapon_level)
	return new_weapon

func roll_armor(armor_level: int):
	var new_armor = GearResource.new('armor', armor_texture)
	new_armor.bonus_defense = randi_range(1 * armor_level, 3 * armor_level)
	new_armor.bonus_max_hp = randi_range(0 * armor_level, 2 * armor_level)
	return new_armor

func roll_journey_reward_gold(journey_level: int):
	var reward_gold = randi_range(
		reward_gold_lower_bound * journey_level,
		reward_gold_upper_bound * journey_level
		)
	add_gold(reward_gold)

func roll_journey_reward_gear(journey_level: int):
	var gear_count = randi_range(1, 2)
	var reward_gear: Array[GearResource] = []
	for gear_index in range(gear_count):
		if randf() <= .5:
			reward_gear.append(roll_weapon(journey_level))
		else:
			reward_gear.append(roll_armor(journey_level))
	add_gear(reward_gear)
