class_name JourneyDisplay extends Control

const HERO_JOURNEY_DISPLAY = preload("uid://bhufx6nhqm5xm")

@onready var journey_display_v_box = $JourneyDisplayVBox

func add_hero_journey():
	var new_hero_journey_display = HERO_JOURNEY_DISPLAY.instantiate()
	journey_display_v_box.add_child(new_hero_journey_display)
	return new_hero_journey_display
