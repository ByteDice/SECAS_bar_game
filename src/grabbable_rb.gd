extends RigidBody2D


@export var particles: GPUParticles2D
@export var rider: Node2D


var held: bool
var anchored: bool
var anchor: Marker2D


var is_init: bool = false


func _ready():
	self.get_parent().children_ready += 1


func init():
	anchor.limb = self
	is_init = true


func _process(delta: float):
	if self.get_parent().is_init == true and not is_init:
		init()
	
	if (not Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_LEFT) \
	or anchored) and held:
		held = false
		rider.is_grabbed_anywhere = false
		on_ungrab()
	
	if not held and anchored: move_to(anchor.global_position, delta)


func _physics_process(delta: float):
	if held: move_to(get_global_mouse_position(), delta)


func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int):
	if event is not InputEventMouseButton: return
	if event.button_index != MOUSE_BUTTON_LEFT: return

	if event.is_pressed() and not anchored and not held \
	and not rider.is_grabbed_anywhere:
		held = true
		rider.is_grabbed_anywhere = true
		on_grab(get_global_mouse_position())


func move_to(to: Vector2, delta: float):
	var dir = to - global_position
	const damping = 2
	
	self.linear_velocity = (dir / delta) / damping


func on_grab(pos: Vector2):
	particles.global_position = pos
	particles.emitting = true
	anchor.setVisible(true)


func on_ungrab():
	anchor.setVisible(false)


func ungrab():
	held = false
	if rider.is_grabbed_anywhere:
		rider.is_grabbed_anywhere = false
	on_ungrab()
