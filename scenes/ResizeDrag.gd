extends PanelContainer
# event.position will cover the whole node, where the node starts, that's also where the mouse will start.
# Basically, the whole area of a node is the only space the event knows.
# event.position only knows the space of the node. event.global_position knows the whole space

var dragging = false
var drag_start_size = 0.0
var drag_start_mouse = 0.0
var drag_start_position_y = 0.0
@export var max_height = 800
@export var min_height = 100

var vbox = VBoxContainer.new()
var current_size_y = Label.new()
var mouse_start = Label.new()
var self_pos_y = Label.new()
var offset = Label.new()
var new_h = Label.new()
var new_pos = Label.new()

const WINDOW = preload("res://window.tscn")

func _ready():
	self.mouse_filter = Control.MOUSE_FILTER_STOP
	self.gui_input.connect(_on_gui_input)
	
	var mywin = WINDOW.instantiate()
	self.add_child(mywin)
	mywin.position = Vector2(100, 100)	
	vbox.add_child(mouse_start)	
	vbox.add_child(offset)
	vbox.add_child(current_size_y)
	vbox.add_child(self_pos_y)	
	vbox.add_child(new_h)
	vbox.add_child(new_pos)
	mywin.add_child(vbox)
	
func _on_gui_input(event):	
	current_size_y.text = "Current node height: " + str(self.size.y).substr(0, 6)
	self_pos_y.text = "Current node pos.y: " + str(self.position.y).substr(0, 6)
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				dragging = true
				drag_start_size = self.size.y
				drag_start_mouse = event.global_position.y
				drag_start_position_y = self.position.y
				mouse_start.text = "Mouse start: " + str(drag_start_mouse).substr(0, 6)
			else:
				dragging = false
	
	elif event is InputEventMouseMotion and dragging:	
		var drag_offset = drag_start_mouse - event.global_position.y
		offset.text = "Mouse offset: " + str(drag_start_mouse).substr(0, 6) + " - " + str(event.global_position.y).substr(0, 6) + " = " + str(drag_offset).substr(0, 6)
		var new_height = drag_start_size + drag_offset
		new_height = clamp(new_height, min_height, max_height)		
		var new_position_y = drag_start_position_y + (drag_start_size - new_height)
		new_position_y = clamp(new_position_y, min_height, get_parent_area_size().y - new_height)
		new_h.text = "Node new height: " + str(new_height).substr(0, 6)
		self.size.y = new_height
		self.position.y = new_position_y
		new_pos.text = "Node new pos.y: " + str(new_position_y).substr(0, 6)
		
	
	
	
