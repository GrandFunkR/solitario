tool
extends Node
export (int) var valore = 1 setget set_valore
export (int, "Fiori", "Quadri", "Cuori", "Picche") var seme = 0 setget set_seme
export (bool) var rossa = false setget set_rossa
export (bool) var mostra_fronte = true setget set_mostra_fronte


func set_mostra_fronte(new_mostra_fronte):
	mostra_fronte = new_mostra_fronte
	aggiorna()
	
func set_rossa(new_rossa):
	if new_rossa and !rossa:
		self.seme = 1
	elif !new_rossa and rossa:
		self.seme = 0
	rossa=new_rossa

func set_seme(new_seme):
	seme = new_seme
	aggiorna()
	
func set_valore(new_valore):
	if new_valore < 1:
		new_valore=1
	elif new_valore > 13:
		new_valore = 13
		
	valore = new_valore
	aggiorna()

func aggiorna():
	get_node("fronte").set_frame(valore-1+(seme*13))
	if mostra_fronte:
		get_node("retro").hide()
	else:
		get_node("retro").show()