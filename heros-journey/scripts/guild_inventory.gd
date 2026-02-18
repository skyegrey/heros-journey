class_name GuildInventory extends Node

@onready var guild_menu = %GuildMenu
@onready var tavern_page_control = %TavernPageControl

@onready var gold: int = 500

func _ready():
	update_gold_texts()

func add_gold(gold_amount: int):
	gold += gold_amount
	update_gold_texts()

func pay_gold(gold_amount: int):
	gold -= gold_amount
	update_gold_texts()

func update_gold_texts():
	guild_menu.update_gold(gold)
	tavern_page_control.update_gold(gold)
