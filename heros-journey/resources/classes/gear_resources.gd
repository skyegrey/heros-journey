class_name GearResource extends Resource

@export var weapon_type: String
@export var gear_sprite: Texture2D

func _init(_weapon_type: String, _gear_sprite):
	weapon_type = _weapon_type
	gear_sprite = _gear_sprite
