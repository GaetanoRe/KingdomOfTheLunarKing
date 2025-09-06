extends Panel

class_name InventorySlot
var item_visual : Sprite2D
var num_items : Label


func _ready() -> void:
	item_visual = get_node("ItemDisplay")


func update(item: ItemData):
	if !item:
		item_visual.visible = false
		# print("Item is not here")
	else:
		# print("Item name is: " + item.name)
		item_visual.visible = true
		item_visual.texture = item.texture
