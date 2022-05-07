extends Object

class_name Item

var texture : ImageTexture
var item_id : String
var stackable : bool
var quantity : int

func _init(imageTexture, id, itemStackable, quantity = 1):
	self.texture = imageTexture;
	self.item_id = id;
	self.quantity = 1 if not itemStackable else quantity
	self.stackable = itemStackable;
	
