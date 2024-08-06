extends Control
# Assets
const DELETE_ICON := preload("res://assets/delete.png")
const FORWARD = preload("res://assets/forward.png")
# Header
@onready var forward: Button = %Forward
@onready var back: Button = %Back
@onready var header: HBoxContainer = %Header
@onready var header_title: Label = %HeaderTitle
# Questionnaire Main
@onready var questionnaires: PanelContainer = %Questionnaires
# Detail
@onready var current_commission_title: Label = %CurrentCommissionTitle
@onready var detail_list_parent: PanelContainer = %DetailListParent
@onready var mockup_details: VBoxContainer = %MockupDetails
@onready var material_details: VBoxContainer = %MaterialDetails
@onready var sizing_details: VBoxContainer = %SizingDetails
@onready var total: Label = %Total
@onready var mural_detail_list: VBoxContainer = %MuralDetailList
@onready var paint_detail_list: VBoxContainer = %PaintDetailList
@onready var sculpt_detail_list: VBoxContainer = %SculptDetailList
@onready var crochet_detail_list: VBoxContainer = %CrochetDetailList
# Type
@onready var type_choose: PanelContainer = %TypeChoose
@onready var service: Label = %Type
# Mural Imports
@onready var mural_main: VBoxContainer = %MuralMain
@onready var m_area_main: VBoxContainer = %MAreaMain
# Mural Area Imports
@onready var label_mural_detail: Label = %LabelMuralDetail
@onready var input_height: LineEdit = %InputHeight
@onready var input_width: LineEdit = %InputWidth
@onready var input_detail: HSlider = %InputDetail
@onready var input_rate: LineEdit = %InputRate
@onready var m_area_deadline_le: LineEdit = %MAreaDeadlineLE
@onready var m_area_address_le: LineEdit = %MAreaAddressLE
# Mural Expense
@onready var m_exp_main: VBoxContainer = %MExpMain
@onready var m_exp_name_le: LineEdit = %MExpNameLE
@onready var m_exp_quantity_le: LineEdit = %MExpQuantityLE
@onready var m_exp_price_le: LineEdit = %MExpPriceLE
@onready var m_exp_payment_le: LineEdit = %MExpPaymentLE
@onready var m_exp_phone_le: LineEdit = %MExpPhoneLE
@onready var m_exp_email_le: LineEdit = %MExpEmailLE
@onready var m_exp_social_le: LineEdit = %MExpSocialLE
# Painting Imports
@onready var painting_main: VBoxContainer = %PaintingMain
# Painting Area
@onready var p_area_main: VBoxContainer = %PAreaMain
# Painting Material
@onready var p_exp_main: VBoxContainer = %PExpMain
# Sculpting Imports
@onready var sculpting_main: VBoxContainer = %SculptingMain
# Sculpting Area
@onready var s_area_main: VBoxContainer = %SAreaMain
# Sculpting Material
@onready var s_exp_main: VBoxContainer = %SExpMain
# Crochet Main
@onready var crochet_main: VBoxContainer = %CrochetMain
# Crochet Area
@onready var c_area_main: VBoxContainer = %CAreaMain
# Crochet Material
@onready var c_exp_main: VBoxContainer = %CExpMain
# Utility Script
var Util := preload("res://scripts/utilities.gd").new()

#region Var States
# Global Var States
var current_comms := 0
var current_page := 0
const avail_comms := ["Mural", "Painting", "Crochet", "Sculpting"]
# Pages Var States
var mural_pages := []
var painting_pages := []
var sculpt_pages := []
var crochet_pages := []
const mural_titles := ["Price For?", "Mural Size & Rate", "Materials / Extra Service"]
const painting_titles := ["Price For?", "Painting Size & Rate", "Materials / Extra Service"]
const sculpt_titles := ["Price For?", "Sculpt Size & Rate", "Materials / Extra Service"]
const crochet_titles := ["Price For?", "Crochet Size & Rate", "Materials / Extra Service"]
#endregion

#region Quotes
const art_quotes = [
	"\"Every child is an artist. The problem is how to remain an artist once we grow up.\" - Pablo Picasso",
	"\"I dream my painting and I paint my dream.\" - Vincent Van Gogh",
	"\"Creativity takes courage.\" - Henri Matisse",
	"\"It's on the strength of observation and reflection that one finds a way. So we must dig and delve unceasingly.\" - Claude Monet",
	"\"To create one's world in any of the arts takes courage.\" - Georgia O'Keeffe",
	"\"Have no fear of perfection, you'll never reach it.\" - Salvador Dalí",
	"\"Don't think about making art, just get it done. Let everyone else decide if it's good or bad, whether they love it or hate it. While they are deciding, make even more art.\" - Andy Warhol",
	"\"I paint my own reality. The only thing I know is that I paint because I need to.\" - Frida Kahlo",
	"\"Art is never finished, only abandoned.\" - Leonardo da Vinci",
	"\"Art is not what you see, but what you make others see.\" - Edgar Degas",
	"\"Focus on the next step, not on the goal.\" - The Creator of this App"
]
#endregion

func _ready() -> void :	
	for details: Variant in detail_list_parent.get_children():
		details.visible = false		
	var main_pages: Array = [mural_main, painting_main, sculpting_main, crochet_main]	
	mural_pages = [type_choose, m_area_main, m_exp_main]
	painting_pages = [type_choose, p_area_main, p_exp_main]
	sculpt_pages = [type_choose, s_area_main, s_exp_main]
	crochet_pages = [type_choose, c_area_main, c_exp_main]
		
	Util.iterate_array(main_pages, "visible", false)
	Util.iterate_array(mural_pages, "visible", false)
	Util.iterate_array(painting_pages, "visible", false)
	Util.iterate_array(sculpt_pages, "visible", false)
	Util.iterate_array(crochet_pages, "visible", false)	
	
	questionnaires.visible = false
	type_choose.visible = true
	current_commission_title.text = art_quotes.pick_random()
		
# Navigation
func _on_forward_pressed() -> void :
	current_commission_title.text = service.text + " Price Details"
	
	if(service.text == "Mural"):
		mural_main.visible = true
		mural_pages[current_page].visible = false
		if current_page < mural_pages.size() - 1:
			current_page += 1	
		mural_pages[current_page].visible = true
		Util.navigationVisibility(mural_pages, back, forward, questionnaires, current_page)		
		header_title.text = mural_titles[current_page]		
		
		mural_detail_list.visible = true
	else:
		mural_main.visible = false			
				
	if(service.text == "Painting"):
		painting_main.visible = true
		painting_pages[current_page].visible = false
		if current_page < painting_pages.size() - 1:
			current_page += 1
		painting_pages[current_page].visible = true
		Util.navigationVisibility(painting_pages, back, forward, questionnaires, current_page)		
		header_title.text = painting_titles[current_page]	
		
		paint_detail_list.visible = true	
	else:
		painting_main.visible = false		
	
	if(service.text == "Sculpting"):
		sculpting_main.visible = true
		sculpt_pages[current_page].visible = false
		if current_page < sculpt_pages.size() - 1: current_page += 1	
		sculpt_pages[current_page].visible = true
		Util.navigationVisibility(sculpt_pages, back, forward, questionnaires, current_page)		
		header_title.text = sculpt_titles[current_page]				
		
		sculpt_detail_list.visible = true
	else:
		sculpting_main.visible = false			
	
	if(service.text == "Crochet"):
		crochet_main.visible = true
		crochet_pages[current_page].visible = false
		if current_page < crochet_pages.size() - 1: current_page += 1	
		crochet_pages[current_page].visible = true
		Util.navigationVisibility(crochet_pages, back, forward, questionnaires, current_page)			
		header_title.text = crochet_titles[current_page]				
		
		crochet_detail_list.visible = true
	else:
		crochet_main.visible = false			

		
func _on_back_pressed() -> void :
	if(service.text == "Mural"):		
		mural_pages[current_page].visible = false		
		if(current_page > 0): current_page -= 1
		mural_pages[current_page].visible = true
		Util.navigationVisibility(mural_pages, back, forward, questionnaires, current_page)
		
		header_title.text = mural_titles[current_page]				
	else:
		mural_main.visible = false		
								
	if(service.text == "Painting"):
		painting_main.visible = true
		painting_pages[current_page].visible = false
		if current_page > 0: current_page -= 1
		painting_pages[current_page].visible = true
		Util.navigationVisibility(painting_pages, back, forward, questionnaires, current_page)
		
		header_title.text = painting_titles[current_page]
	else:
		painting_main.visible = false
	
	if(service.text == "Sculpting"):
		sculpting_main.visible = true
		sculpt_pages[current_page].visible = false
		if current_page > 0: current_page -= 1	
		sculpt_pages[current_page].visible = true
		Util.navigationVisibility(sculpt_pages, back, forward, questionnaires, current_page)
			
		header_title.text = crochet_titles[current_page]				
	else:
		sculpting_main.visible = false
						
	if(service.text == "Crochet"):
		crochet_main.visible = true
		crochet_pages[current_page].visible = false
		if current_page > 0: current_page -= 1	
		crochet_pages[current_page].visible = true
		Util.navigationVisibility(crochet_pages, back, forward, questionnaires, current_page)
			
		header_title.text = crochet_titles[current_page]				
	else:
		crochet_main.visible = false
	
	if current_page == 0:		
		current_commission_title.text = art_quotes.pick_random()
		mural_detail_list.visible = false
		paint_detail_list.visible = false
		sculpt_detail_list.visible = false
		crochet_detail_list.visible = false

# Type choose
func _on_next_type_pressed() -> void :
	current_comms += 1
	current_comms %= avail_comms.size()
	service.text = avail_comms[current_comms]

func _on_add_wall_pressed() -> void :
	var not_empty : bool = input_height.text != "" && input_width.text != "" && input_rate.text != "" && m_area_address_le.text != "" && m_area_deadline_le.text != ""
	if(not_empty):		
		var detail : String = label_mural_detail.text
		var new_panel := PanelContainer.new()
		var new_vbox := VBoxContainer.new()
		var new_hbox := HBoxContainer.new()
		var new_wall := Label.new()
		var new_info := Label.new()
		var new_delete := Button.new()
		setUpNodes(new_panel, new_vbox, new_hbox, new_delete, new_wall, new_info, sizing_details)
		
		var wall_str : String = detail + " : " + input_height.text + " ft * " + input_width.text + " ft = " + " ₱" + input_rate.text	 + " / " + str(input_height.text.to_float() * input_width.text.to_float()) + " sq ft" + " = ₱" + str((input_height.text.to_float() * input_width.text.to_float()) * input_rate.text.to_float())		
		var extra_info_str: String = "Deadline: " + m_area_deadline_le.text + " | Address: " + m_area_address_le.text
		
		new_wall.text = wall_str
		new_info.text = extra_info_str		
		input_height.text = ""
		input_width.text = ""
		input_detail.value = 1
		input_rate.text = ""
		m_area_deadline_le.text = ""
		m_area_address_le.text = ""

		getTotal(sizing_details, mockup_details, material_details)

func _on_m_exp_add_bt_pressed() -> void:
	var not_empty :bool = m_exp_name_le.text != "" && m_exp_quantity_le.text != "" && m_exp_price_le.text != "" && m_exp_payment_le.text != "" && m_exp_phone_le.text != "" && m_exp_email_le.text != "" && m_exp_social_le.text != ""

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

# Mural Expense
func _on_add_material_pressed() -> void :
	pass
		
func getTotal(vbox1: VBoxContainer, vbox2: VBoxContainer, vbox3: VBoxContainer) -> void:
	#var total_regex := RegEx.new()
	#var total_amount : float = 0
	#total_regex.compile("₱(\\d+)$")
	#var sizing_parent: Array = vbox1.get_children()
	#var mockup_parent: Array = vbox2.get_children()
	#var material_parent: Array = vbox3.get_children()
	#
	#if sizing_parent.size() > 0:		
		#for wall: Variant in sizing_parent:
			#if !wall.is_queued_for_deletion():
				#total_amount += total_regex.search(wall.get_child(0).text).get_string(1).to_float()			
	#if mockup_parent.size() > 0:		
		#for wall: Variant in mockup_parent:
			#if !wall.is_queued_for_deletion():
				#total_amount += total_regex.search(wall.get_child(0).text).get_string(1).to_float()
	#if material_parent.size() > 0:		
		#for wall: Variant in material_parent:
			#if !wall.is_queued_for_deletion():
				#total_amount += total_regex.search(wall.get_child(0).text).get_string(1).to_float()	
	#
	#total.text = "Total: ₱" + str(total_amount)		
	pass	
		
func _on_delete_wall_pressed(node: PanelContainer) -> void :
	node.queue_free()
	getTotal(sizing_details, mockup_details, material_details)

func setUpNodes(new_panel: PanelContainer, new_vbox: VBoxContainer, new_hbox: HBoxContainer, new_delete: Button, new_wall: Label, new_info: Label, attach_list: Variant) -> void:
	new_panel.add_child(new_vbox)
	new_vbox.add_child(new_hbox)
	new_vbox.add_child(new_info)
	new_hbox.add_child(new_wall)
	new_hbox.add_child(new_delete)	
	attach_list.add_child(new_panel)		
	new_delete.set_button_icon(DELETE_ICON)
	new_delete.set_theme_type_variation("DeleteButton")
	new_panel.set_theme_type_variation("DetailElement")
	new_wall.set_h_size_flags(Control.SIZE_EXPAND_FILL)
	new_delete.pressed.connect(self._on_delete_wall_pressed.bind(new_panel))



