class_name HeroJourneyDisplay extends Control

@onready var start_position: Marker2D = $StartPosition
@onready var end_position: Marker2D = $EndPosition
@onready var battle_hero_position = $BattleHeroPosition

@onready var enemy_sprite = $EnemySprite
@onready var hero_sprite = $HeroSprite
@onready var journey_distance: float
@onready var enemy_hp_bar = $EnemyHpBar

@export var attack_animation_time = .15
@export var attack_movement_distance = 25

func _ready():
	journey_distance = end_position.position.x - start_position.position.x

func start_journey_display():
	hero_sprite.flip_h = false
	visible = true

func hide_journey_display():
	visible = false

func update_journey_distance(travel_percent: float):
	hero_sprite.position.x = start_position.position.x + travel_percent * journey_distance

func set_is_returning(is_returning: bool):
	if is_returning:
		hero_sprite.flip_h = true

func enter_battle():
	hero_sprite.position.x = battle_hero_position.position.x
	enemy_sprite.visible = true
	enemy_hp_bar.visible = true

func animate_enemy_attack():
	var enemy_attack_tween = get_tree().create_tween()
	var enemy_sprite_starting_x_position = enemy_sprite.position.x
	enemy_attack_tween.tween_property(
		enemy_sprite, 
		"position:x", 
		enemy_sprite_starting_x_position - attack_movement_distance, 
		attack_animation_time
	)
	enemy_attack_tween.tween_property(
		enemy_sprite, 
		"position:x", 
		enemy_sprite_starting_x_position, 
		attack_animation_time
	)

func animate_hero_attack():
	var hero_attack_tween = get_tree().create_tween()
	var hero_sprite_starting_x_position = hero_sprite.position.x
	hero_attack_tween.tween_property(
		hero_sprite, 
		"position:x", 
		hero_sprite_starting_x_position + attack_movement_distance, 
		attack_animation_time
	)
	hero_attack_tween.tween_property(
		hero_sprite, 
		"position:x", 
		hero_sprite_starting_x_position, 
		attack_animation_time
	)

func update_enemy_hp_bar(current_hp: int, max_hp: int):
	enemy_hp_bar.value = float(current_hp) / max_hp * 100

func cleanup_battle():
	enemy_sprite.visible = false
