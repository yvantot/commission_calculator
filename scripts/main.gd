extends Control

# Assets
const DELETE_ICON := preload("res://assets/delete.png")
const FINISH = preload("res://assets/finish.png")
const FORWARD = preload("res://assets/reply-1.png")
# Header
@onready var forward: Button = %Forward
@onready var header: HBoxContainer = %Header
@onready var header_title: Label = %HeaderTitle
# Detail
@onready var detail_list: VBoxContainer = %DetailList
@onready var mockup_details: VBoxContainer = %MockupDetails
@onready var material_details: VBoxContainer = %MaterialDetails
@onready var sizing_details: VBoxContainer = %SizingDetails
@onready var total: Label = %Total
# Type
@onready var type_choose: PanelContainer = %TypeChoose
@onready var service: Label = %Type
# Mural Imports
@onready var mural_area: VBoxContainer = %MuralArea
@onready var mural_mockup: VBoxContainer = %MuralMockup
@onready var mural_materials: VBoxContainer = %MuralMaterials
# Mural Area Imports
@onready var label_mural_detail: Label = %LabelMuralDetail
@onready var input_height: LineEdit = %InputHeight
@onready var input_width: LineEdit = %InputWidth
@onready var input_detail: HSlider = %InputDetail
@onready var input_rate: LineEdit = %InputRate
# Mural Mockups
@onready var mockup_inputs: VBoxContainer = %MockupInputs
@onready var add_design: Button = %AddDesign
@onready var input_name: LineEdit = %InputName
@onready var input_number: LineEdit = %InputNumber
@onready var input_price: LineEdit = %InputPrice
@onready var toggle_need_design: CheckButton = %ToggleNeedDesign
# Mural Materials
@onready var add_material: Button = %AddMaterial
@onready var input_material_name: LineEdit = %InputMaterialName
@onready var input_material_quantity: LineEdit = %InputMaterialQuantity
@onready var input_material_price: LineEdit = %InputMaterialPrice

# Var States
var mural_pages := []
const avail_comms := ["Mural", "Painting", "Crochet", "Sculpting"]
const mural_titles := ["Price For?", "Mural Size & Rate", "Design Needs?", "Needed Materials"]
var current_comms := 0
var current_page := 0

func _ready() -> void :
	mural_pages = [type_choose, mural_area, mural_mockup, mural_materials]
	for i in range(1, mural_pages.size()):
		mural_pages[i].visible = false		
	mural_pages[current_page].visible = true

# Mural Functions
func _on_back_pressed() -> void :
	if(service.text == "Mural"):
		mural_pages[current_page].visible = false		
		if(current_page > 0): current_page -= 1
		mural_pages[current_page].visible = true
		header_title.text = mural_titles[current_page]
		
		if current_page == mural_pages.size() - 2:			
			forward.visible = true
								
	elif(service.text == "Painting"):
		pass
	elif(service.text == "Crochet"):
		pass
	elif(service.text == "Sculpting"):
		pass

func _on_forward_pressed() -> void :
	if(service.text == "Mural"):
		mural_pages[current_page].visible = false
		if current_page < mural_pages.size() - 1:
			current_page += 1	
		
		mural_pages[current_page].visible = true
		header_title.text = mural_titles[current_page]
		
		if current_page == mural_pages.size() - 1:			
			forward.visible = false
			
	elif(service.text == "Painting"):
		pass
	elif(service.text == "Crochet"):
		pass
	elif(service.text == "Sculpting"):
		pass	
	
func _on_next_type_pressed() -> void :
	current_comms += 1
	current_comms %= avail_comms.size()
	service.text = avail_comms[current_comms]

# Mural Area
func _on_add_wall_pressed() -> void :
	var not_empty : bool = input_height.text != "" && input_width.text != "" && input_rate.text != ""
	if(not_empty):		
		var detail : String = label_mural_detail.text
		var new_hbox := HBoxContainer.new()
		var new_wall := Label.new()
		var new_delete := Button.new()		
		setUpNodes(new_hbox, new_delete, new_wall, sizing_details)
		
		var wall_str : String = detail + " : " + input_height.text + " ft * " + input_width.text + " ft = " + " ₱" + input_rate.text	 + " / " + str(input_height.text.to_float() * input_width.text.to_float()) + " sq ft" + " = ₱" + str((input_height.text.to_float() * input_width.text.to_float()) * input_rate.text.to_float())		
		new_wall.text = wall_str
		
		input_height.text = ""
		input_width.text = ""
		input_detail.value = 1
		input_rate.text = ""

		getTotal(sizing_details, mockup_details, material_details)

func _on_input_detail_value_changed(_value: float) -> void:
	label_mural_detail.text = sliderDescription()
		
func sliderDescription() -> String:
	var detail := ""
	if(input_detail.value == 1):
		detail = "Simple"
	elif(input_detail.value == 2):
		detail = "Normal"
	elif(input_detail.value == 3):
		detail = "Realistic"
	return detail
		
# Mural Mockup
func _on_add_design_pressed() -> void:
	var not_empty: bool = input_number.text != "" && input_price.text != "" && input_name.text != ""
	if not_empty:
		var new_hbox := HBoxContainer.new()
		var new_design := Label.new()
		var new_delete := Button.new()		
		setUpNodes(new_hbox, new_delete, new_design, mockup_details)
		
		var design_str : String = input_name.text + " : " + " ₱" + input_price.text + " / #" + input_number.text + " = ₱" + str(input_number.text.to_float() * input_price.text.to_float())		
		new_design.text = design_str		
		
		input_number.text = ""		
		input_price.text = ""
		input_name.text = ""
		
		getTotal(sizing_details, mockup_details, material_details)

func _on_check_button_toggled(toggled_on: bool) -> void :
	if toggled_on:
		mockup_inputs.visible = true
	else:
		mockup_inputs.visible = false

# Mural Material
func _on_add_material_pressed() -> void :
	var not_empty : bool = input_material_name.text != "" && input_material_price.text != "" && input_material_quantity.text != ""
	if not_empty:
		var new_hbox := HBoxContainer.new()
		var new_material := Label.new()
		var new_delete := Button.new()		
		setUpNodes(new_hbox, new_delete, new_material, material_details)
		
		var material_str : String = input_material_name.text + " : ₱" + input_material_price.text + " / #" + input_material_quantity.text + " = ₱" + str(input_material_price.text.to_float() * input_material_quantity.text.to_float())		
		new_material.text = material_str
					
		input_material_name.text = ""
		input_material_price.text = ""
		input_material_quantity.text = ""
		
		getTotal(sizing_details, mockup_details, material_details)
		
func getTotal(vbox1: VBoxContainer, vbox2: VBoxContainer, vbox3: VBoxContainer) -> void:
	var total_regex := RegEx.new()
	var total_amount : float = 0
	total_regex.compile("₱(\\d+)$")
	var sizing_parent: Array = vbox1.get_children()
	var mockup_parent: Array = vbox2.get_children()
	var material_parent: Array = vbox3.get_children()
	
	if sizing_parent.size() > 0:		
		for wall: Variant in sizing_parent:
			if !wall.is_queued_for_deletion():
				total_amount += total_regex.search(wall.get_child(0).text).get_string(1).to_float()			
	if mockup_parent.size() > 0:		
		for wall: Variant in mockup_parent:
			if !wall.is_queued_for_deletion():
				total_amount += total_regex.search(wall.get_child(0).text).get_string(1).to_float()
	if material_parent.size() > 0:		
		for wall: Variant in material_parent:
			if !wall.is_queued_for_deletion():
				total_amount += total_regex.search(wall.get_child(0).text).get_string(1).to_float()	
	
	total.text = "Total: ₱" + str(total_amount)			
		
func _on_delete_wall_pressed(hbox: HBoxContainer) -> void :
	hbox.queue_free()
	getTotal(sizing_details, mockup_details, material_details)

func setUpNodes(new_hbox: HBoxContainer, new_delete: Button, new_wall: Label, attach_list: Variant) -> void:
	new_hbox.add_child(new_wall)
	new_hbox.add_child(new_delete)
	attach_list.add_child(new_hbox)			
	new_delete.set_button_icon(DELETE_ICON)
	new_delete.set_theme_type_variation("DeleteButton")
	new_wall.set_h_size_flags(Control.SIZE_EXPAND_FILL)
	new_delete.pressed.connect(self._on_delete_wall_pressed.bind(new_hbox))
	
