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
	
	attack = randi_range(1, 10)
	defense = randi_range(1, 10)
	speed = randi_range(1, 10)

func reset_action_cooldown():
	action_cooldown = 400.0 / (100 + speed)
