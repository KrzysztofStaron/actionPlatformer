extends Control

onready var Items = load("res://scenes/inventory/Items.gd").new();


var gridSource : Control
var gridDestination : Control

onready var allGrids = $TextureRect/ItemGrid.get_children();

var testItems = [
	{"id": "item_00",
	 "quantity": 1,
	 "grid_location": 0
	},
	{"id": "item_01",
	 "quantity": 1,
	 "grid_location": 1
	},
]

class_name Inventory

# Called when the node enters the scene tree for the first time.
func _ready():
	for item in testItems:
		var newItem = Items.get_item(item["id"]);
		allGrids[item["grid_location"]].set_item(newItem);


func _on_ItemGrid_item_drag(node):
	gridSource = node;

func _on_ItemGrid_item_drag_release(node):
	if node == null:
		gridSource = null;
		gridDestination = null;
		return;	
	gridDestination = node;
	var sourceItem = gridSource.item;
	gridSource.set_item(gridDestination.item);
	gridDestination.set_item(sourceItem);
	
	
	
	
