class_name GearCell extends MarginContainer

@onready var item_sprite = $ItemSprite
@onready var gear_resource: GearResource
@onready var gear_type: String

@onready var is_mouse_hovered: bool = false

signal gear_equiped
signal gear_left_cell

func _ready():
	pass

func reset_cell():
	gear_resource = null
	item_sprite.visible = false
	item_sprite.texture = null

func update_cell(_gear_resource: GearResource):
	gear_resource = _gear_resource
	item_sprite.visible = true
	item_sprite.texture = gear_resource.gear_sprite

func _get_drag_data(at_position: Vector2):
	if gear_type:
		return null
	if not gear_resource:
		return null
	set_drag_preview(make_preview())
	return self

func _can_drop_data(position, data):
	if not gear_type:
		return false
	if data is not GearCell:
		return false
	elif gear_type == data.gear_resource.weapon_type:
		return true

func _drop_data(at_position: Vector2, data: Variant):
	if data is not GearCell:
		return false
	gear_equiped.emit(data.gear_resource)
	data.gear_left_cell.emit()

func make_preview():
	var item_preview_rect = TextureRect.new()
	item_preview_rect.scale = Vector2(2, 2)
	item_preview_rect.texture = item_sprite.texture
	return item_preview_rect
