class_name HeroJourneyDisplay extends Control

@onready var start_position: Marker2D = $StartPosition
@onready var end_position: Marker2D = $EndPosition
@onready var battle_hero_position = $BattleHeroPosition

@onready var enemy_sprite = $EnemySprite
@onready var hero_sprite = $HeroSprite
@onready var journey_distance: float
@onready var enemy_hp_bar = $EnemyHpBar


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
	pass

func animate_player_attack():
	pass
