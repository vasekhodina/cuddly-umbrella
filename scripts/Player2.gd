extends KinematicBody2D

export (int) var SPEED
export (float) var ROTATION_SPEED
var screensize
var velocity = Vector2()
export (PackedScene) var bullet
var dead = false
onready var bullet_container = get_node("bullet_container")
onready var gun_timer = get_node("gun_timer")
onready var anim = get_node("AnimationPlayer")

signal p2_lost

func _ready():
    # Called every time the node is added to the scene.
    # Initialization here
    screensize = get_viewport_rect().size
    

func _process(delta):
    velocity = Vector2()
    var rotation_dir = 0
    if Input.is_action_pressed("p2_right"):
        rotation_dir += 1
    if Input.is_action_pressed("p2_left"):
        rotation_dir -= 1
    if Input.is_action_pressed("p2_down"):
        velocity = Vector2(-SPEED, 0).rotated(rotation)
    if Input.is_action_pressed("p2_up"):
        velocity = Vector2(SPEED, 0).rotated(rotation)
    if Input.is_action_pressed("p2_shoot") and gun_timer.get_time_left() == 0:
        shoot()
    rotation += rotation_dir * ROTATION_SPEED * delta
    move_and_slide(velocity)
    if dead and not anim.is_playing():
        hide()
	
func shoot():
    # TODO: Fix weird shotgun bullet spawning. Maybe drop weird angles at all.
    gun_timer.start()
    var bullets = Array()
    for i in range(0, 4):
        bullets.append(bullet.instance())
        bullet_container.add_child(bullets[i])
        bullets[i].start_at(rotation - 0.8 + float(i)/10,
                            get_node("muzzle").get_global_position() + Vector2(20 * i, 4 * i).rotated(rotation),
                            velocity)

func on_hit():
    anim.play("Death")
    dead = true
    emit_signal("p2_lost")