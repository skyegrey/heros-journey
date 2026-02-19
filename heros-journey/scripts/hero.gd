class_name HeroNode extends Node

@onready var hero_resource: HeroResource

@onready var hero_journey_display: HeroJourneyDisplay
@onready var hero_listing: HeroListing

@onready var journey_total_distance: float = 0
@onready var journey_distance: float = 0
@onready var is_on_journey: bool = false
@onready var in_battle: bool = false
@onready var is_returning: bool = false
@onready var awaiting_completion: bool = false

@onready var enemy_character_resource: CharacterResource

signal journey_completed

func _process(delta):
	if in_battle:
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

func _start_return_trip():
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
	journey_completed.emit(_calculate_journey_reward())

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
	if enemy_character_resource.action_cooldown <= 0:
		_enemy_character_attack()
	if hero_resource.action_cooldown:
		_attack()

func _enemy_character_attack():
	hero_journey_display.animate_enemy_attack()

func _attack():
	hero_journey_display.animate_player_attack()
