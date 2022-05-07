extends Node

signal item_drag(node)
signal item_drag_release(node)


func notify_parent_on_item_drag(node):
	emit_signal("item_drag", node);

func notify_parent_on_item_drag_release(node):
	emit_signal("item_drag_release", node);
