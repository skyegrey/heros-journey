class_name GearPage extends Control

@onready var total_gear_cells = 30

@onready var gear_cell_grid_container = $GearCellGridContainer

const GEAR_CELL = preload("uid://cicgpj1w488po")

func _ready():
	for gear_cell_index in range(total_gear_cells):
		gear_cell_grid_container.add_child(GEAR_CELL.instantiate())

func update_gear_page(gear: Array[GearResource]):
	for gear_resource_index: int in range(gear.size()):
		gear_cell_grid_container.get_child(gear_resource_index).update_cell(gear[gear_resource_index])
