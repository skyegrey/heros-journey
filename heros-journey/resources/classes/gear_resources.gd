class_name GearResource extends Resource

@export var weapon_type: String
@export var gear_sprite: Texture2D

@export var bonus_max_hp: int
@export var bonus_attack: int
@export var bonus_defense: int
@export var bonus_speed: int

func _init(_weapon_type: String, _gear_sprite):
	weapon_type = _weapon_type
	gear_sprite = _gear_sprite
