extends Control

class_name GridItem

var item : Item

func register_item(assetLocation, item_id, stackable):
	var image = Image.new();
	var texture = ImageTexture.new();
	image.load(assetLocation);
	texture.create_from_image(image);
	var newItem = Item.new(texture, item_id, stackable);
	set_item(newItem);

func _ready():
	if item == null:
		set_mouse_filter(Control.MOUSE_FILTER_IGNORE);
		print(get_mouse_filter());
	else:
		set_mouse_filter(Control.MOUSE_FILTER_STOP);
		
	update_display();
	
	
func update_display():
	if item == null:
		$Panel/TextureRect.set_texture(null);
		$Panel/Label.text = "";
		return;
		
	$Panel/TextureRect.set_texture(self.item.texture); 
	$Panel/Label.text = str(self.item.quantity) if self.item.stackable else "";

func set_item(localItem):
	self.item = localItem;
	update_display();
	
func check_if_mergeable(localItem: Item):
	if localItem.stackable and self.item.stackable and (localItem.item_id == self.item.item_id):
		return true;
	return false;
		
func get_item():
	return self.item;
	
	
func get_drag_data(_position):
	if self.item == null:
		return null;
		
	get_parent().notify_parent_on_item_drag(self);
	var drag_preview = TextureRect.new();
	drag_preview.set_texture(self.item.texture);
	set_drag_preview(drag_preview);
	return self.item;
	
func drop_data(_position, _data):
	get_parent().notify_parent_on_item_drag_release(self);
	
func can_drop_data(_position, _data):
	return true;



