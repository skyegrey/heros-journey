class_name RecruitableHeroControl extends Control

@onready var recruitable_hero_resource: RecruitableHeroResource
@onready var name_text = $NameLevelTextControl/NameText
@onready var gold_cost_text = $GoldCostTextControl/GoldCostText
@onready var button = $Button

signal on_recruit_button_pressed

func _ready():
	button.pressed.connect(_on_recruit_button_pressed)

func _on_recruit_button_pressed():
	on_recruit_button_pressed.emit(recruitable_hero_resource)

func set_recruitable_hero_resource(
		_recruitable_hero_resource: RecruitableHeroResource
	):
		recruitable_hero_resource = _recruitable_hero_resource
		_set_name(recruitable_hero_resource.hero_name)
		_set_gold_cost(recruitable_hero_resource.gold_cost)

func _set_name(hero_name):
	name_text.text = hero_name

func _set_gold_cost(gold_cost):
	gold_cost_text.text = str(gold_cost)
