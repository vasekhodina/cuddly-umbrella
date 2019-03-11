extends KinematicBody2D

signal p1_lost

export (int) var SPEED
export (float) var ROTATION_SPEED
export (float) var MUZZLE_DEVIATION
var screensize
var velocity = Vector2()
var dead = false
export (PackedScene) var bullet
onready var bullet_container = get_node("bullet_container")
onready var gun_timer = get_node("gun_timer")
onready var gun_sound = get_node("Gunshot")
onready var anim = get_node("Death")

func _ready():
    # Called every time the node is added to the scene.
    # Initialization here
    screensize = get_viewport_rect().size
    set_process(true)

func _process(delta):
    velocity = Vector2()
    var rotation_dir = 0
    if Input.is_action_pressed("p1_right"):
        rotation_dir += 1
    if Input.is_action_pressed("p1_left"):
        rotation_dir -= 1
    if Input.is_action_pressed("p1_down"):
        velocity = Vector2(-SPEED, 0).rotated(rotation)
    if Input.is_action_pressed("p1_up"):
        velocity = Vector2(SPEED, 0).rotated(rotation)
    if Input.is_action_pressed("p1_shoot") and gun_timer.get_time_left() == 0:
        shoot()
    rotation += rotation_dir * ROTATION_SPEED * delta
    move_and_slide(velocity)
    if dead and not anim.is_playing():
        hide()

func shoot():
    gun_timer.start()
    gun_sound.play()
    var b1 = bullet.instance()
    bullet_container.add_child(b1)
    b1.start_at(rotation - 0.25, get_node("muzzle_1").get_global_position(), velocity)
    var b2 = bullet.instance()
    bullet_container.add_child(b2)
    b2.start_at(rotation + 0.25, get_node("muzzle_2").get_global_position(), velocity)
    
func on_hit():
    anim.play("Death")
    dead = true
    emit_signal("p1_lost")
    