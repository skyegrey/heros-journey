class_name HeroListControl extends Control

const HERO_CONTROL = preload("uid://sp0w2rrlaiwg")

@onready var heros_list_v_box = $HerosListVBox

func add_hero():
	var new_hero_listing = HERO_CONTROL.instantiate()
	heros_list_v_box.add_child(new_hero_listing)
	return new_hero_listing
