extends StaticBody2D

@export var enabled: bool = true
func _ready() -> void:
	if enabled == false:
		enabled = true
		toggle()
	
func _on_button_button_pressed() -> void:
	toggle()

func toggle():
	print(name)
	if enabled:
		for child in get_children():
			if child is CollisionShape2D:
				child.set_deferred("disabled", true)
		visible=false
		enabled = false
	else:
		for child in get_children():
			if child is CollisionShape2D:
				child.set_deferred("disabled", false)
		visible=true
		enabled = true
		
