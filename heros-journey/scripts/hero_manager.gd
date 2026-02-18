class_name HeroManager extends Node

@onready var heros_list_control: HeroListControl = %HerosListControl
@onready var journey_display = %JourneyDisplay
@onready var guild_inventory = %GuildInventory

const HERO_NODE = preload("uid://dgyst2jhoj1tp")

func add_hero(recruitable_hero_resource: RecruitableHeroResource):
	var hero_resource = create_hero_resource_from_recruitable_hero_resource(
		recruitable_hero_resource
	)
	var hero_node: HeroNode = HERO_NODE.instantiate()
	var hero_listing = heros_list_control.add_hero()
	var hero_journey_display = journey_display.add_hero_journey()
	hero_journey_display.visible = false
	hero_node.set_hero_listing(hero_listing)
	hero_node.set_hero_journey_display(hero_journey_display)
	
	hero_node.set_hero_resource(hero_resource)
	
	hero_node.journey_completed.connect(_on_hero_journey_completed)
	add_child(hero_node)

func _on_hero_journey_completed(gold_value: int):
	guild_inventory.add_gold(gold_value)

func create_hero_resource_from_recruitable_hero_resource(
		recruitable_hero_resource: RecruitableHeroResource
	):
		return HeroResource.new(
			recruitable_hero_resource.hero_name
		)
