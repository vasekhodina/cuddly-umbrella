extends KinematicBody2D

var velocity = Vector2()
export var speed = 500

func start_at(dir, pos, v):
    rotation = dir
    position = pos
    velocity = v + Vector2(speed, 0).rotated(rotation)

func _process(delta):
    var collision = move_and_collide(velocity * delta)
    if collision:
        var reflect = collision.remainder.bounce(collision.normal)
        velocity = velocity.bounce(collision.normal)
        move_and_collide(reflect)

func _on_lifetime_timeout():
    queue_free()

func _on_player_bullet_body_entered(body):
    body.on_hit()
