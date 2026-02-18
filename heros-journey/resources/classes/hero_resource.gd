class_name HeroResource extends Node

@export var hero_name: String

@export var max_hp: int
@export var current_hp: int

@export var attack: int
@export var defense: int
@export var speed: int

func _init(_hero_name: String):
	hero_name = _hero_name
	max_hp = randi_range(10, 20)
	current_hp = max_hp
	
	attack = randi_range(1, 10)
	defense = randi_range(1, 10)
	speed = randi_range(1, 10)
