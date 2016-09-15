extends Node2D
var last_card = null

func _ready():
	randomize()
	for v in range(14):
		for s in range(4):
			add_card(v,s)
	shuffle()


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
	#card.mostra_fronte = false
	card.mostra_fronte = true
	
	if last_card!=null:
		card.set_pos(last_card.get_pos()+Vector2(-0.5,-0.5))
	
	card.add_to_group("deck")
	
	add_child(card)
	last_card = card
