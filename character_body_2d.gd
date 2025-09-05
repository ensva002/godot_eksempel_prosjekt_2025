extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -600.0

var anim
var walking
var crouch
var dead
var facing = 1
var bomb = preload("res://bomb.tscn")
var charge
var charging
var bomb_cooldown = false

func _ready() -> void:
	anim = $AnimatedSprite2D
	charge = $Charge
	
	for enemy in get_tree().get_nodes_in_group("enemy"):
		enemy.connect("player_hurt", Callable(self,"on_player_hurt"))
	

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if !dead:
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
			walking = true
			if velocity.x < 0:
				anim.flip_h = true
				facing = -1
			else:
				anim.flip_h = false
				facing = 1
		elif Input.is_action_pressed("ui_down"):
			crouch = true
		elif Input.is_action_just_released("ui_down"):
			crouch = false
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			walking = false
		
		if Input.is_action_just_pressed("shift") && !bomb_cooldown:
			charging = true
			charge.tint_under = Color(0,0,0,1)
		if charging:
			if charge.value < 100:
				charge.value += 1.75
			if charge.value >= 20:
				charge.tint_progress = Color(1,1,1,1)

			
		if (Input.is_action_just_released("shift") or charge.value >= 100) && charging:
			charging = false
			charge.tint_under = Color(0,0,0,0)
			
			if charge.value > 20:
				var bombInsta = bomb.instantiate()
				bombInsta.global_position = Vector2(global_position)
				bombInsta.linear_velocity = Vector2(charge.value*facing,-charge.value)*7
				get_tree().current_scene.add_child(bombInsta)
			charge.value = 100
			charge.tint_progress = Color(0,0,0,1)
			bomb_cooldown = true
			
			
		if !charging && bomb_cooldown:
			charge.value -= 3.5
			if charge.value <= 0:
				bomb_cooldown = false
				charge.value = 0
				charge.tint_progress = Color(1,1,1,0.5)

	move_and_slide()
	animationHandler()
	
func animationHandler():
	if dead:
		anim.play("hurt")
	elif velocity.y < 0:
		anim.play("jump")
	elif velocity.y > 0:
		anim.play("fall")
	elif walking:
		anim.play("walk")
	elif crouch:
		anim.play("crouch")
	else:
		anim.play("idle")
		
func on_player_hurt():
	dead = true
	collision_mask=0
	collision_layer =  0
	velocity.y = -350
	velocity.x =200*-facing
	
