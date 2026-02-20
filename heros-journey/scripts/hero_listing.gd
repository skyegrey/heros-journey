class_name HeroListing extends Control

@onready var journey_button = %JourneyButton
@onready var hp_label = %HPLabel
@onready var stats_button = %StatsButton
@onready var stats_page = %StatsPage
@onready var hp_bar = %HpBar
@onready var gear_button = %GearButton
@onready var gear_page = %GearPage
@onready var armor_cell = %ArmorCell
@onready var weapon_cell = %WeaponCell
@onready var max_hp_label = %MaxHPLabel
@onready var attack_label = %AttackLabel
@onready var defense_label = %DefenseLabel
@onready var speed_label = %SpeedLabel

signal on_journey_button_pressed
signal on_weapon_equiped
signal on_armor_equiped

func _ready():
	journey_button.pressed.connect(_on_journey_button_pressed)
	stats_button.pressed.connect(_toggle_stats_page)
	gear_button.pressed.connect(_toggle_gear_page)
	armor_cell.gear_type = 'armor'
	armor_cell.gear_equiped.connect(_on_armor_equiped)
	weapon_cell.gear_type = 'weapon'
	weapon_cell.gear_equiped.connect(_on_weapon_equiped)
	

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

func _on_armor_equiped(armor_resource: GearResource):
	armor_cell.update_cell(armor_resource)
	on_armor_equiped.emit(armor_resource)

func _on_weapon_equiped(weapon_resource: GearResource):
	weapon_cell.update_cell(weapon_resource)
	on_weapon_equiped.emit(weapon_resource)

func update_stats(hero_resource: HeroResource):
	max_hp_label.text = str(hero_resource.max_hp)
	attack_label.text = str(hero_resource.attack)
	defense_label.text = str(hero_resource.defense)
	speed_label.text = str(hero_resource.speed)
