class_name TavernPageControl extends Control

@onready var tavern_listing_container = $TavernListingContainer
@onready var hero_manager = %HeroManager
@onready var tavern = %Tavern
@onready var gold_label = $GoldLabel

const RECRUITABLE_HERO_CONTROL = preload("uid://cnx46umktrgpm")

signal on_recruitable_hero_control_recruit_button_pressed

func create_recruitable_hero_list(
		recruitable_hero_resources: Array[RecruitableHeroResource]
	):
	# TODO, fix this
	for child in tavern_listing_container.get_children():
		child.queue_free()
	for recruitable_hero_resource in recruitable_hero_resources:
		var recruiltable_hero_control: RecruitableHeroControl = \
			 RECRUITABLE_HERO_CONTROL.instantiate()
		recruiltable_hero_control.on_recruit_button_pressed.connect(
			_on_recruitable_hero_control_recruit_button_pressed.bind(recruiltable_hero_control)
		)
		tavern_listing_container.add_child(recruiltable_hero_control)
		recruiltable_hero_control.set_recruitable_hero_resource(
			recruitable_hero_resource
		)

func _on_recruitable_hero_control_recruit_button_pressed(
		recruitable_hero_resource: RecruitableHeroResource,
		recruitable_hero_control: RecruitableHeroControl
	):
		tavern.on_hero_recruit_button_pressed(
			recruitable_hero_resource,
			recruitable_hero_control
		)

func update_gold(new_gold_value):
	gold_label.text = str(new_gold_value)
