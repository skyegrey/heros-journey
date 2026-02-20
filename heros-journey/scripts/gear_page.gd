class_name GearPage extends Control

@onready var total_gear_cells = 30

@onready var gear_cell_grid_container = $GearCellGridContainer

const GEAR_CELL = preload("uid://cicgpj1w488po")

signal on_gear_left_cell

func _ready():
	for gear_cell_index in range(total_gear_cells):
		gear_cell_grid_container.add_child(GEAR_CELL.instantiate())

func update_gear_page(gear: Array[GearResource]):
	for child_cell: GearCell in gear_cell_grid_container.get_children():
		child_cell.reset_cell()
		if child_cell.gear_left_cell.is_connected(_on_gear_left_cell):
			child_cell.gear_left_cell.disconnect(_on_gear_left_cell)
	for gear_resource_index: int in range(gear.size()):
		var gear_cell: GearCell = gear_cell_grid_container.get_child(gear_resource_index)
		gear_cell.update_cell(gear[gear_resource_index])
		gear_cell.gear_left_cell.connect(_on_gear_left_cell.bind(gear_resource_index))

func _on_gear_left_cell(gear_resource_index: int):
	on_gear_left_cell.emit(gear_resource_index)
