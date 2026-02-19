class_name CharacterResource extends Resource

@export var max_hp: int
@export var current_hp: int

@export var attack: int
@export var defense: int
@export var speed: int

@export var action_cooldown: float

func _init():
	max_hp = randi_range(10, 20)
	current_hp = max_hp
	
	attack = randi_range(1, 5)
	defense = randi_range(1, 5)
	speed = randi_range(1, 5)

func reset_action_cooldown():
	action_cooldown = 400.0 / (100 + speed)

func take_damage(raw_damage_amount: int):
	var damage = max(1, raw_damage_amount - defense)
	current_hp -= damage
