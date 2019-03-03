extends Area2D
signal p1_hit
signal p2_hit

var velocity = Vector2()
export var speed = 500

func start_at(dir, pos, v):
    rotation = dir
    position = pos
    velocity = v + Vector2(speed, 0).rotated(rotation)

func _process(delta):
    position = position + velocity * delta

func _on_lifetime_timeout():
    queue_free()

func _on_player_bullet_body_entered(body):
    body.on_hit()
