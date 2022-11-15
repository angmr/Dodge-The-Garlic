extends RigidBody2D

export var min_speed = 150
export var max_speed = 250
var mob_scale


func _ready():
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	# randomly chose mobe type
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
	# randomly choose mob size
	var mob_size = rand_range(0.50, 1)
	mob_scale = Vector2(mob_size, mob_size)
	$AnimatedSprite.set_scale(mob_scale)
	$CollisionShape2D.set_scale(mob_scale)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
