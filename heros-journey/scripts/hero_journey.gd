class_name HeroJourneyDisplay extends Control

@onready var start_position: Marker2D = $StartPosition
@onready var end_position: Marker2D = $EndPosition
@onready var reina = $Reina

@onready var journey_distance: float

func _ready():
	journey_distance = end_position.position.x - start_position.position.x

func start_journey_display():
	reina.flip_h = false
	visible = true

func hide_journey_display():
	visible = false

func update_journey_distance(travel_percent: float):
	reina.position.x = start_position.position.x + travel_percent * journey_distance

func set_is_returning(is_returning: bool):
	if is_returning:
		reina.flip_h = true
