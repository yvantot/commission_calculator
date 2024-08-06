# Utilities
func iterate_array(arr: Array, property: String, value: bool) -> void:
	for el in arr:
		if el.has_method(property):
			el.set(property, value)
			
func navigationVisibility(page, back, forward, questionnaires, current_page):
	if current_page == 0:
		back.visible =  false
		questionnaires.visible = false
	else:
		back.visible =  true
		questionnaires.visible = true
		
	if current_page == page.size() - 1:	
		forward.visible = false		
	else:
		forward.visible = true

func typeIs(obj: Variant):
	print(type_string(typeof(obj)))
