class_name HeroListing extends Control

@onready var journey_button: Button = $HeroContainer/HeroMenuContainer/JourneyButton
@onready var hp_label = $HeroContainer/HeroInformation/MarginContainer2/CharacterTextContainer/HPLabel
@onready var stats_button = $HeroContainer/HeroMenuContainer/StatsButton
@onready var stats_page = $StatsPage

signal on_journey_button_pressed

func _ready():
	journey_button.pressed.connect(_on_journey_button_pressed)
	stats_button.pressed.connect(_toggle_stats_page)

func _on_journey_button_pressed():
	on_journey_button_pressed.emit()

func on_journey_completed():
	journey_button.text = "Complete"

func reset_journey_button():
	journey_button.text = "Journey"

func update_hp_bar(current_hp: int, max_hp: int):
	hp_label.text = str("HP: ", current_hp, "/", max_hp)

func _toggle_stats_page():
	if stats_page.visible:
		stats_page.visible = false
		custom_minimum_size.y = 150
	else:
		stats_page.visible = true
		custom_minimum_size.y = 300
	
