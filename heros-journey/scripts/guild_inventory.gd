class_name GuildInventory extends Node

@onready var guild_menu = %GuildMenu
@onready var tavern_page_control = %TavernPageControl
@onready var gear_page = %GearPage

@onready var gold: int = 500
@onready var gear: Array[GearResource]

@export var weapon_texture: Texture2D
@export var armor_texture: Texture2D

func _ready():
	update_gold_texts()
	_create_initial_gear()

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
	var starting_weapon = GearResource.new('weapon', weapon_texture)
	var starting_armor = GearResource.new('armor', armor_texture)
	add_gear([starting_weapon, starting_armor])

func add_gear(new_gear: Array[GearResource]):
	gear.append_array(new_gear)
	gear_page.update_gear_page(gear)
