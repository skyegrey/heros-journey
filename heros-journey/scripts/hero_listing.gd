class_name HeroListing extends Control

@onready var journey_button = %JourneyButton
@onready var hp_label = %HPLabel
@onready var stats_button = %StatsButton
@onready var stats_page = %StatsPage
@onready var hp_bar = %HpBar
@onready var gear_button = %GearButton
@onready var gear_page = %GearPage

signal on_journey_button_pressed

func _ready():
	journey_button.pressed.connect(_on_journey_button_pressed)
	stats_button.pressed.connect(_toggle_stats_page)
	gear_button.pressed.connect(_toggle_gear_page)

func _on_journey_button_pressed():
	on_journey_button_pressed.emit()

func on_journey_completed():
	journey_button.text = "Complete"

func reset_journey_button():
	journey_button.text = "Journey"

func update_hp_bar(current_hp: int, max_hp: int):
	hp_label.text = str("HP: ", current_hp, "/", max_hp)
	hp_bar.value = float(current_hp) / max_hp * 100

func _toggle_stats_page():
	if stats_page.visible:
		stats_page.visible = false
		custom_minimum_size.y = 150
	else:
		if gear_page.visible: 
			gear_page.visible = false
		stats_page.visible = true
		custom_minimum_size.y = 300
	
func _toggle_gear_page():
	if gear_page.visible:
		gear_page.visible = false
		custom_minimum_size.y = 150
	else:
		if stats_page.visible: 
			stats_page.visible = false
		gear_page.visible = true
		custom_minimum_size.y = 300
