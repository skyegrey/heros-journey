class_name HeroNode extends Node

@onready var hero_resource: HeroResource

@onready var hero_journey_display: HeroJourneyDisplay
@onready var hero_listing: HeroListing

@onready var journey_total_distance: float = 0
@onready var journey_distance: float = 0
@onready var journey_level: int = 1
@onready var is_on_journey: bool = false
@onready var in_battle: bool = false
@onready var is_returning: bool = false
@onready var awaiting_completion: bool = false

@onready var enemy_character_resource: CharacterResource
@onready var weapon_resource: GearResource
@onready var armor_resource: GearResource

signal journey_completed

func _ready():
	hero_listing.on_weapon_equiped.connect(_on_weapon_equiped)
	hero_listing.on_armor_equiped.connect(_on_armor_equiped)

func _process(delta):
	if in_battle:
		_process_battle(delta)
		return
	if is_on_journey:
		if is_returning:
			_update_return_progress(delta)
		else:
			_update_journey_progress(delta)

func _update_journey_progress(delta: float):
	journey_distance += delta
	if journey_distance >= journey_total_distance:
		_start_battle()
		return
	_update_journey_display()

func _start_return_journey():
	is_returning = true
	hero_journey_display.set_is_returning(true)

func _update_return_progress(delta: float):
	journey_distance -= delta
	if journey_distance <= 0:
		_on_return_completed()
	_update_journey_display()

func _update_journey_display():
	var journey_travel_percent = journey_distance / journey_total_distance
	hero_journey_display.update_journey_distance(journey_travel_percent)

func _start_journey():
	journey_total_distance = _calculate_journey_time()
	hero_journey_display.start_journey_display()
	is_on_journey = true

func _on_return_completed():
	is_returning = false
	is_on_journey = false
	awaiting_completion = true
	hero_listing.on_journey_completed()

func _calculate_journey_time():
	return randf_range(5, 15)

func _complete_journey():
	awaiting_completion = false
	hero_listing.reset_journey_button()
	hero_journey_display.hide_journey_display()
	journey_completed.emit(journey_level)

func _on_journey_button_pressed():
	if awaiting_completion:
		_complete_journey()
	else:
		_start_journey()

func set_hero_listing(_hero_listing: HeroListing):
	hero_listing = _hero_listing
	hero_listing.on_journey_button_pressed.connect(_on_journey_button_pressed)

func set_hero_journey_display(_hero_journey_display: HeroJourneyDisplay):
	hero_journey_display = _hero_journey_display

func _calculate_journey_reward():
	return randi_range(50, 500)

func set_hero_resource(_hero_resource: HeroResource):
	hero_resource = _hero_resource
	hero_listing.update_hp_bar(hero_resource.current_hp, hero_resource.max_hp)
	hero_listing.update_stats(hero_resource)

func _start_battle():
	in_battle = true
	hero_journey_display.enter_battle()
	_spawn_enemy()
	enemy_character_resource.reset_action_cooldown()
	hero_resource.reset_action_cooldown()

func _spawn_enemy():
	enemy_character_resource = CharacterResource.new()

func _process_battle(delta: float):
	enemy_character_resource.action_cooldown -= delta
	hero_resource.action_cooldown -= delta
	if hero_resource.action_cooldown <= 0:
		_attack()
	if enemy_character_resource.action_cooldown <= 0:
		_enemy_character_attack()


func _enemy_character_attack():
	hero_journey_display.animate_enemy_attack()
	enemy_character_resource.reset_action_cooldown()
	hero_resource.take_damage(enemy_character_resource.attack)
	hero_listing.update_hp_bar(hero_resource.current_hp, hero_resource.max_hp)
	if hero_resource.current_hp <= 0:
		_die()

func _attack():
	hero_journey_display.animate_hero_attack()
	hero_resource.reset_action_cooldown()
	enemy_character_resource.take_damage(hero_resource.attack)
	hero_journey_display.update_enemy_hp_bar(
		enemy_character_resource.current_hp, enemy_character_resource.max_hp
	)
	if enemy_character_resource.current_hp <= 0:
		_defeat_enemy_character()

func _end_battle():
	hero_journey_display.cleanup_battle()
	in_battle = false

func _die():
	_end_battle()
	hero_resource.current_hp = 1
	hero_journey_display.hide_journey_display()
	is_on_journey = false

func _defeat_enemy_character():
	_end_battle()
	_start_return_journey()

func _on_weapon_equiped(_weapon_resource: GearResource):
	if weapon_resource:
		hero_resource.attack -= weapon_resource.bonus_attack
		hero_resource.speed -= weapon_resource.bonus_speed
	hero_resource.attack += _weapon_resource.bonus_attack
	hero_resource.speed += _weapon_resource.bonus_speed
	hero_listing.update_stats(hero_resource)
	weapon_resource = _weapon_resource

func _on_armor_equiped(_armor_resource: GearResource):
	if armor_resource:
		hero_resource.attack -= armor_resource.bonus_attack
		hero_resource.speed -= armor_resource.bonus_speed
	hero_resource.max_hp += _armor_resource.bonus_max_hp
	hero_resource.defense += _armor_resource.bonus_defense
	hero_listing.update_stats(hero_resource)
	hero_listing.update_hp_bar(
		hero_resource.current_hp, 
		hero_resource.max_hp
	)
	armor_resource = _armor_resource
