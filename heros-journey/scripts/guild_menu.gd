class_name GuildMenu extends Control

@onready var gold_label = $GuildInfoPage/GoldLabel

@onready var tavern_button = $TavernButton
@onready var guild_hall_button = $GuildHallButton

@onready var guild_info_page = $GuildInfoPage
@onready var tavern_page_control = $TavernPageControl


@onready var pages = [
	tavern_page_control,
	guild_info_page
]

func _ready():
	tavern_button.pressed.connect(_switch_menu.bind(tavern_page_control))
	guild_hall_button.pressed.connect(_switch_menu.bind(guild_info_page))

func update_gold(new_gold_amount):
	gold_label.text = str(new_gold_amount, 'g')

func _switch_menu(menu: Control):
	for page in pages:
		page.visible = false
	menu.visible = true
