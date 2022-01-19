extends KinematicBody2D

export (int) var speed = 150
export (int) var jump_speed = -900
export (int) var gravity = 3000

var velocity = Vector2.ZERO
var facing_right = true

func get_input():
	velocity.x = 0
	
	if facing_right == true:
		$Sprite.scale.x = 1
	else:
		$Sprite.scale.x = -1
		
	if Input.is_action_pressed("walk_right"):
		velocity.x += speed
		facing_right = true
		$AnimationPlayer.play("walk")
		
	elif Input.is_action_pressed("walk_left"):
		velocity.x -= speed
		facing_right = false
		$AnimationPlayer.play("walk")
	
	else:
		velocity.x = lerp(velocity.x,0,0.2)
		$AnimationPlayer.play("idle")
	


func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed
			$AnimationPlayer.play("jump")
			$jump_sound.play()
