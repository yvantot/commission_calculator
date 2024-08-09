extends Control

# If I have to rewrite this, I'd make the components more modular. The Main nodes will handle its children operations
# and if a data is requested, just request with a message.
# I would also write make functions more seperated, categorized by their function.
# I still don't understand Godot's import system truly, but there must be a better way than importing a fuck ton of them. Of course, other than accessing them
# from their parents. That would be node digging.
# I think it would be a great idea to have an HTML way of creating a node, like...
# Node
# --Node
# --Node
# ----Node
# And you don't have to manually create them imperatively everytime, you just have to do this.

#region New Code Region
# Assets
const DELETE_ICON := preload("res://assets/delete.png")
const FORWARD = preload("res://assets/forward.png")
# Screen
@onready var screen_adapt: MarginContainer = %ScreenAdapt
@onready var screen_adapt_question: MarginContainer = %ScreenAdaptQuestion
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
@onready var material_details: VBoxContainer = %MaterialDetails
@onready var sizing_details: VBoxContainer = %SizingDetails
@onready var total: Label = %Total
@onready var mural_detail_list: VBoxContainer = %MuralDetailList
@onready var paint_detail_list: VBoxContainer = %PaintDetailList
@onready var sculpt_detail_list: VBoxContainer = %SculptDetailList
@onready var crochet_detail_list: VBoxContainer = %CrochetDetailList
@onready var crochet_total: Label = %CrochetTotal
@onready var sculpting_total: Label = %SculptingTotal
@onready var painting_total: Label = %PaintingTotal
# Contacts
@onready var contact_main: VBoxContainer = %ContactMain
# Mural Detail
@onready var m_title_wall: Label = %MTitleWall
@onready var m_title_expense: Label = %MTitleExpense
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
@onready var p_area_details_vb: VBoxContainer = %PAreaDetailsVB
@onready var p_area_width_le: LineEdit = %PAreaWidthLE
@onready var p_area_height_le: LineEdit = %PAreaHeightLE
@onready var p_area_deadline_le: LineEdit = %PAreaDeadlineLE
@onready var p_area_rate_le: LineEdit = %PAreaRateLE
@onready var p_area_detail_hs: HSlider = %PAreaDetailHS
@onready var p_area_detail_lb: Label = %PAreaDetailLB
# Painting Material
@onready var p_exp_main: VBoxContainer = %PExpMain
@onready var p_exp_payment_le: LineEdit = %PExpPaymentLE
@onready var p_exp_phone_le: LineEdit = %PExpPhoneLE
@onready var p_exp_email_le: LineEdit = %PExpEmailLE
@onready var p_exp_social_le: LineEdit = %PExpSocialLE
@onready var p_exp_name_le: LineEdit = %PExpNameLE
@onready var p_exp_quantity_le: LineEdit = %PExpQuantityLE
@onready var p_exp_price_le: LineEdit = %PExpPriceLE
@onready var p_exp_details_vb: VBoxContainer = %PExpDetailsVB
@onready var p_area_medium_le: LineEdit = %PAreaMediumLE
# Sculpting Imports
@onready var sculpting_main: VBoxContainer = %SculptingMain
# Sculpting Area
@onready var s_area_details_vb: VBoxContainer = %SAreaDetailsVB
@onready var s_area_main: VBoxContainer = %SAreaMain
@onready var s_area_width_le: LineEdit = %SAreaWidthLE
@onready var s_area_height_le: LineEdit = %SAreaHeightLE
@onready var s_area_deadline_le: LineEdit = %SAreaDeadlineLE
@onready var s_area_rate_le: LineEdit = %SAreaRateLE
@onready var s_area_detail_hs: HSlider = %SAreaDetailHS
@onready var s_area_detail_lb: Label = %SAreaDetailLB
# Sculpting Material
@onready var s_exp_details_vb: VBoxContainer = %SExpDetailsVB
@onready var s_exp_main: VBoxContainer = %SExpMain
@onready var s_exp_name_le: LineEdit = %SExpNameLE
@onready var s_exp_quantity_le: LineEdit = %SExpQuantityLE
@onready var s_exp_price_le: LineEdit = %SExpPriceLE
@onready var s_exp_payment_le: LineEdit = %SExpPaymentLE
@onready var s_exp_phone_le: LineEdit = %SExpPhoneLE
@onready var s_exp_email_le: LineEdit = %SExpEmailLE
@onready var s_exp_social_le: LineEdit = %SExpSocialLE
# Crochet Main
@onready var crochet_main: VBoxContainer = %CrochetMain
# Crochet Area
@onready var c_area_details_vb: VBoxContainer = %CAreaDetailsVB
@onready var c_area_main: VBoxContainer = %CAreaMain
@onready var c_area_detail_lb: Label = %CAreaDetailLB
@onready var c_area_detail_sl: HSlider = %CAreaDetailSL
@onready var c_area_width_le: LineEdit = %CAreaWidthLE
@onready var c_area_height_le: LineEdit = %CAreaHeightLE
@onready var c_area_deadline_le: LineEdit = %CAreaDeadlineLE
@onready var c_area_rate_le: LineEdit = %CAreaRateLE
@onready var c_area_ply_le: LineEdit = %CAreaPlyLE
# Crochet Material
@onready var c_exp_main: VBoxContainer = %CExpMain
@onready var c_exp_name_le: LineEdit = %CExpNameLE
@onready var c_exp_quantity_le: LineEdit = %CExpQuantityLE
@onready var c_exp_price_le: LineEdit = %CExpPriceLE
@onready var c_exp_payment_le: LineEdit = %CExpPaymentLE
@onready var c_exp_phone_le: LineEdit = %CExpPhoneLE
@onready var c_exp_email_le: LineEdit = %CExpEmailLE
@onready var c_exp_social_le: LineEdit = %CExpSocialLE
@onready var c_exp_details_vb: VBoxContainer = %CExpDetailsVB
# Utility Script
var Util := preload("res://scripts/utilities.gd").new()
#endregion

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
	"\"Focus on the next step, not on the goal.\" - The Creator of this App",
	"\"Mm mm\" - Rodilyn"
]
#endregion

func _ready() -> void :	
	for details: Variant in detail_list_parent.get_child(0).get_children():
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
	
func pageVisibleForward(main: VBoxContainer, pages: Array, titles: Array, detail_list: VBoxContainer) -> void:	
	main.visible = true
	pages[current_page].visible = false
	if current_page < pages.size() - 1: current_page += 1
	pages[current_page].visible = true
	Util.navigationVisibility(pages, back, forward, questionnaires, current_page)		
	header_title.text = titles[current_page]	
	detail_list.visible = true
	
func pageVisibleBackward(main: VBoxContainer, pages: Array, titles: Array) -> void:	
	main.visible = true
	pages[current_page].visible = false
	if current_page > 0: current_page -= 1
	pages[current_page].visible = true
	Util.navigationVisibility(pages, back, forward, questionnaires, current_page)		
	header_title.text = titles[current_page]
	
# Navigation
func _on_forward_pressed() -> void :
	current_commission_title.text = service.text + " Price Details"
	if(service.text == "Mural"):
		pageVisibleForward(mural_main, mural_pages, mural_titles, mural_detail_list)		
	else:
		mural_main.visible = false			
				
	if(service.text == "Painting"):
		pageVisibleForward(painting_main, painting_pages, painting_titles, paint_detail_list)
	else:
		painting_main.visible = false		
	
	if(service.text == "Sculpting"):
		pageVisibleForward(sculpting_main, sculpt_pages, sculpt_titles, sculpt_detail_list)
	else:
		sculpting_main.visible = false			
	
	if(service.text == "Crochet"):
		pageVisibleForward(crochet_main, crochet_pages, crochet_titles, crochet_detail_list)
	else:
		crochet_main.visible = false			
	
	if current_page > 0:
		contact_main.visible = true
		
func _on_back_pressed() -> void :
	if(service.text == "Mural"):
		pageVisibleBackward(mural_main, mural_pages, mural_titles)		
	else:
		mural_main.visible = false		
								
	if(service.text == "Painting"):
		pageVisibleBackward(painting_main, painting_pages, painting_titles)
	else:
		painting_main.visible = false
	
	if(service.text == "Sculpting"):
		pageVisibleBackward(sculpting_main, sculpt_pages, sculpt_titles)
	else:
		sculpting_main.visible = false
						
	if(service.text == "Crochet"):
		pageVisibleBackward(crochet_main, crochet_pages, crochet_titles)
	else:
		crochet_main.visible = false
	
	if current_page == 0:		
		current_commission_title.text = art_quotes.pick_random()
		mural_detail_list.visible = false
		paint_detail_list.visible = false
		sculpt_detail_list.visible = false
		crochet_detail_list.visible = false
	
	if current_page == 0:
		contact_main.visible = false

# Type choose
func _on_next_type_pressed() -> void :
	current_comms += 1
	current_comms %= avail_comms.size()
	service.text = avail_comms[current_comms]

func add_size(height: LineEdit, width: LineEdit, deadline: LineEdit, rate: LineEdit, detail: Label, detaillist: VBoxContainer, extrainfo: Variant = LineEdit.new()) -> void:
	var not_empty : bool = height.text != "" && width.text != "" && rate.text != "" && deadline.text != ""
	if not_empty:
		var detail_str : String = detail.text
		var new_panel := PanelContainer.new()
		var new_vbox := VBoxContainer.new()
		var new_hbox := HBoxContainer.new()
		var new_add := Label.new()
		var new_deadline := Label.new()
		var new_delete := Button.new()
		setUpNodes(new_panel, new_vbox, new_hbox, new_delete, new_add, new_deadline, detaillist)
						
		var add_str : String = detail_str + ": " + height.text + " ft * " + width.text + " ft = " + " ₱" + rate.text + " / " + str(height.text.to_float() * width.text.to_float()) + " sq ft" + " = ₱" + str((height.text.to_float() * width.text.to_float()) * rate.text.to_float())
		var deadline_str: String = "Deadline: " + deadline.text
		
		if extrainfo != null:
			if "Medium" in extrainfo.name:
				deadline_str += " | Medium: " + extrainfo.text
			elif "Ply" in extrainfo.name:
				deadline_str += " | Ply: " + extrainfo.text
			elif "Address" in extrainfo.name:
				deadline_str += " | Address: " + extrainfo.text
			extrainfo.text = ""
			
		new_add.text = add_str
		new_deadline.text = deadline_str
		
		height.text = ""
		width.text = ""
		rate.text = ""
		deadline.text = ""

func add_material(mname: LineEdit, quantity: LineEdit, price: LineEdit, service_details: VBoxContainer, payment: LineEdit, phone: LineEdit, email: LineEdit, social: LineEdit) -> void:
	# Material Add
	var not_empty :bool = mname.text != "" && quantity.text != "" && price.text != ""
	if not_empty:
		var new_panel = PanelContainer.new()
		var new_hbox = HBoxContainer.new()
		var new_material = Label.new()
		var new_delete = Button.new()
		Util.addNodes(new_hbox, [new_material, new_delete])
		new_panel.add_child(new_hbox)
		
		var material_str = mname.text + " : #" + quantity.text + " • ₱" + price.text + " = ₱" + str(quantity.text.to_float() * price.text.to_float())
		new_material.text = material_str
		service_details.add_child(new_panel)
		new_delete.set_button_icon(DELETE_ICON)
		new_delete.set_theme_type_variation("DeleteButton")
		new_panel.set_theme_type_variation("DetailElement")
		new_material.set_h_size_flags(Control.SIZE_EXPAND_FILL)
		new_delete.pressed.connect(self._on_delete_wall_pressed.bind(new_panel))
		
		mname.text = ""
		quantity.text = ""
		price.text = ""
	
	# Payment & Contacts
	var not_empty1 = payment.text != "" && (social.text != "" || email.text != "" || phone.text != "")
	if contact_main.get_child_count() == 1 && not_empty1:
		var new_panel1 = PanelContainer.new()
		var new_vbox = VBoxContainer.new()
		var new_payment = Label.new()
		var new_phone = Label.new()
		var new_email = Label.new()
		var new_social = Label.new()		
				
		Util.addNodes(new_vbox, [new_payment, new_phone, new_email, new_social])				
		contact_main.add_child(new_panel1)
		new_panel1.add_child(new_vbox)		
		new_panel1.set_theme_type_variation("DetailElement")			
		
		new_payment.text = "Payment Info: " + payment.text
		new_phone.text = "Phone: " + phone.text
		new_email.text = "Email: " + email.text
		new_social.text = "Social: " + social.text
	elif contact_main.get_child_count() == 2 && not_empty1:
		var contact_details = contact_main.get_child(1).get_child(0)		
		contact_details.get_child(0).text = "Payment: " + payment.text
		contact_details.get_child(1).text = "Phone: " + phone.text
		contact_details.get_child(2).text = "Email: " + email.text
		contact_details.get_child(3).text = "Social: " + social.text					

func _on_input_detail_value_changed(value: float) -> void:
	label_mural_detail.text = sliderDescription(value)

func _on_p_area_detail_hs_value_changed(value: float) -> void:
	p_area_detail_lb.text = sliderDescription(value)

func _on_s_area_detail_hs_value_changed(value: float) -> void:
	s_area_detail_lb.text = sliderDescription(value)
	
func _on_c_area_detail_sl_value_changed(value: float) -> void:
	c_area_detail_lb.text = sliderDescription(value)
	
func sliderDescription(value) -> String:
	var detail := ""
	if(value == 1):
		detail = "Simple"
	elif(value == 2):
		detail = "Normal"
	elif(value == 3):
		detail = "Realistic"
	return detail


func getTotal(area_list: VBoxContainer, expense_list: VBoxContainer, total_label: Label) -> void:
	var total_regex := RegEx.new()	
	total_regex.compile("₱(\\d+)$")
	var total_amount : float = 0
	
	var area_arr: Array = area_list.get_children()
	var expense_arr: Array = expense_list.get_children()
	
	if area_arr.size() > 0:
		for elem in area_arr:
			if !elem.is_queued_for_deletion():
				total_amount += total_regex.search(elem.get_child(0).get_child(0).get_child(0).text).get_string(1).to_float()			
	if area_arr.size() > 0:
		for elem in expense_arr:
			if !elem.is_queued_for_deletion():
				total_amount += total_regex.search(elem.get_child(0).get_child(0).text).get_string(1).to_float()			
	
	total_label.text = "Total: ₱" + str(total_amount)	
	
	# TODO Remove this later because this function is a duplicate
	var msizing_details_size = 0
	var mexp_details_size = 0
	for node in sizing_details.get_children():
		if !node.is_queued_for_deletion():
			msizing_details_size += 1
	for node in material_details.get_children():
		if !node.is_queued_for_deletion():
			mexp_details_size += 1
	
	m_title_expense.text = "Expenses: #" + str(mexp_details_size)
	m_title_wall.text = "Wall : #" + str(msizing_details_size)
	pass	

func _on_delete_wall_pressed(node: PanelContainer) -> void :
	node.queue_free()	
	if mural_detail_list.visible == true:
		getTotal(sizing_details, material_details, total)
	elif paint_detail_list.visible == true:
		getTotal(p_area_details_vb, p_exp_details_vb, painting_total)
	elif sculpt_detail_list.visible == true:
		getTotal(s_area_details_vb, s_exp_details_vb, sculpting_total)
	elif crochet_detail_list.visible == true:
		getTotal(c_area_details_vb, c_exp_details_vb, crochet_total)	

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

# Expenses
func _on_m_exp_add_bt_pressed() -> void:
	add_material(m_exp_name_le, m_exp_quantity_le, m_exp_price_le, material_details, m_exp_payment_le, m_exp_phone_le, m_exp_email_le, m_exp_social_le)
	getTotal(sizing_details, material_details, total)

func _on_p_exp_add_bt_pressed() -> void:
	add_material(p_exp_name_le, p_exp_quantity_le, p_exp_price_le, p_exp_details_vb, p_exp_payment_le, p_exp_phone_le, p_exp_email_le, p_exp_social_le)
	getTotal(p_area_details_vb, p_exp_details_vb, painting_total)

func _on_s_exp_add_bt_pressed() -> void:
	add_material(s_exp_name_le, s_exp_quantity_le, s_exp_price_le, s_exp_details_vb, s_exp_payment_le, s_exp_phone_le, s_exp_email_le, s_exp_social_le)
	getTotal(s_area_details_vb, s_exp_details_vb, sculpting_total)

func _on_c_exp_add_bt_pressed() -> void:
	add_material(c_exp_name_le, c_exp_quantity_le, c_exp_price_le, c_exp_details_vb, c_exp_payment_le, c_exp_phone_le, c_exp_email_le, c_exp_social_le)
	getTotal(c_area_details_vb, c_exp_details_vb, crochet_total)

## Area
func _on_add_wall_pressed() -> void :
	add_size(input_height, input_width, m_area_deadline_le, input_rate, label_mural_detail, sizing_details, m_area_address_le)
	getTotal(sizing_details, material_details, total)
	
func _on_p_area_add_bt_pressed() -> void:
	add_size(p_area_height_le, p_area_width_le, p_area_deadline_le, p_area_rate_le, p_area_detail_lb, p_area_details_vb, p_area_medium_le)
	getTotal(p_area_details_vb, p_exp_details_vb, painting_total)

func _on_s_area_add_bt_pressed() -> void:
	add_size(s_area_height_le, s_area_width_le, s_area_deadline_le, s_area_rate_le, s_area_detail_lb, s_area_details_vb)
	getTotal(s_area_details_vb, s_exp_details_vb, sculpting_total)

func _on_c_area_add_bt_pressed() -> void:
	add_size(c_area_height_le, c_area_width_le, c_area_deadline_le, c_area_rate_le, c_area_detail_lb, c_area_details_vb, c_area_ply_le)
	getTotal(c_area_details_vb, c_exp_details_vb, crochet_total)
