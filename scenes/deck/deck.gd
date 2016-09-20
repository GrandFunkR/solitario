extends Node2D
var last_card = null
var ia = 0
func _ready():
	randomize()
	for v in range(13):
		for s in range(4):
			add_card(v+1,s)
	#shuffle()
	get_node("reload").connect("input_event", self, "on_input_event_reload")

func on_input_event_reload(ev):
	if (ev.type==InputEvent.MOUSE_BUTTON or ev.type==InputEvent.SCREEN_TOUCH) and !ev.is_pressed():
		reload()
		
func on_input_event(ev):
	if (ev.type==InputEvent.MOUSE_BUTTON or ev.type==InputEvent.SCREEN_TOUCH) and !ev.is_pressed():
		remove_card()

func reload():
	var arr_waste = get_tree().get_nodes_in_group("waste")
	var i = arr_waste.size()
	var len = i
	
	while i > 0:
		if last_card!=null:
			last_card.disconnect("input_event", self, "on_input_event")
		
		last_card = arr_waste[i-1]
		
		last_card.remove_from_group("waste")
		get_parent().remove_child(last_card)
		
		last_card.mostra_fronte = false
		last_card.add_to_group("deck")
		last_card.connect("input_event", self, "on_input_event")
		
		last_card.set_pos(Vector2(-(len-i)/2,-(len-i)/2))
			
			
		add_child(last_card)
		last_card.connect("input_event", self, "on_input_event")
	
		
		i -= 1 
	

func remove_card():
	last_card.disconnect("input_event", self, "on_input_event")
	last_card.remove_from_group("deck")
	remove_child(last_card)
	
	last_card.mostra_fronte = true
	
	var offset = get_tree().get_nodes_in_group("waste").size()/2
	last_card.set_pos(get_pos()+Vector2(300-offset,-offset))
	
	last_card.add_to_group("waste")
	get_parent().add_child(last_card)
	
	var cards = get_tree().get_nodes_in_group("deck")
	var len = cards.size()
	
	if len > 0:
		last_card = cards[len-1]
		last_card.connect("input_event", self, "on_input_event")
	else:
		last_card = null
	
	
	
func shuffle():
	var cards = get_tree().get_nodes_in_group("deck")
	var len = cards.size()
	var next_card
	var tmp_valore
	var tmp_seme
	
	for card in cards:
		next_card = cards[rand_range(0,len)]
		
		tmp_valore = card.valore
		tmp_seme = card.seme
		
		card.valore = next_card.valore
		card.seme = next_card.seme
		
		next_card.valore = tmp_valore
		next_card.seme = tmp_seme
		

func add_card(valore, seme):
	var card = load("res://scenes/carta/carta.tscn").instance()
	
	card.valore = valore
	card.seme = seme
	card.mostra_fronte = false
	
	add_child(card)
	
	if last_card!=null:
		last_card.disconnect("input_event", self, "on_input_event")
		var p = last_card.get_pos()+Vector2(-0.5,-0.5)
		print("P: ", p)
		card.set_pos(p)
		print("x: ", card.get_pos())
		ia += 1
		print("P: ", p)
	
	card.add_to_group("deck")
	card.connect("input_event", self, "on_input_event")
	
	
	
	last_card = card
	print(card.get_pos(), ia)
	
	