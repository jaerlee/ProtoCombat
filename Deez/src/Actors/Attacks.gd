extends Area2D

onready var anim = $AnimationPlayer

func _ready():
	pass
	get_node("Mid").disabled = true
	get_node("High").disabled = true
	get_node("Low").disabled = true
	get_node("Back").disabled = true

func midattack():
	anim.play("mid_attack")

func lowattack():
	anim.play("low_attack")
	
func highattack():
	anim.play("high_attack")
	
func backattack():
	anim.play("back_attack")
	
func _on_Attacks_body_entered(body):
	if body.has_method("handle_hit"):
		body.handle_hit()
