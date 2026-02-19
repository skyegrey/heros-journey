class_name GearCell extends MarginContainer

@onready var item_sprite = $ItemSprite

func update_cell(gear_resource: GearResource):
	item_sprite.visible = true
	item_sprite.texture = gear_resource.gear_sprite
