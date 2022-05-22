extends Node

#const Item = preload("res://scenes/inventory/Item.gd");

class_name Items

var items = {}

func register_item(assetLocation, item_id, stackable):
	var image = Image.new();
	var texture = ImageTexture.new();
	image.load(assetLocation);
	texture.create_from_image(image);
	var newItem = Item.new(texture, item_id, stackable);
	items[item_id] = newItem;
	return "Item " + item_id + " is registered!";
	
func get_item(item_id):
	 return items[item_id].get_script().new(items[item_id].texture, items[item_id].item_id, items[item_id].stackable);
	
func get_items():
	return items;

# Called when the node enters the scene tree for the first time.
func _init():
	print(self.register_item("res://assets/itempack/Item__00.png", "item_00", false));
	self.register_item("res://assets/itempack/Item__08.png", "item_01", false);
	self.register_item("res://assets/itempack/Item__19.png", "item_02", false);


