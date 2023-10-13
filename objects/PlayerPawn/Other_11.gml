/// @description Create
// Feather disable GM2016
event_inherited()

playcam = [x, y, z]
playcam_z = z
playcam_z_to = z

camera = area.add(PlayerCamera, x, y, z, angle)

if instance_exists(camera) {
	camera.add_target(playcam, 128, 0, 0, height + 4)
}

add_net_variable("face_angle", NetVarFlags.GENERIC)

add_net_variable("player", NetVarFlags.CREATE, function (_value) {
	var _player = global.players[_value]
	
	player = _player
	states = _player.states
	input = _player.input
	input_previous = _player.input_previous
	
	with _player {
		if instance_exists(thing) and thing != other {
			thing.destroy()
		}
		
		thing = other
		
		var _newcam = other.camera
		
		if instance_exists(camera) and camera != _newcam {
			camera.destroy()
		}
		
		camera = _newcam
	}
}, function () {
	return global.last_player
})

add_net_variable("playcam_yaw", NetVarFlags.GENERIC, function (_value) {
	if instance_exists(camera) {
		camera.yaw = _value
	}
}, function () {
	return instance_exists(camera) ? camera.yaw : 0
})

add_net_variable("playcam_pitch", NetVarFlags.GENERIC, function (_value) {
	if instance_exists(camera) {
		camera.pitch = _value
	}
}, function () {
	return instance_exists(camera) ? camera.pitch : 0
})

sync_jump = add_net_variable("net_jump", NetVarFlags.DEFAULT, function (_value) {
	do_jump()
}, function () {
	return undefined
})

sync_maneuver = add_net_variable("net_maneuver", NetVarFlags.DEFAULT, function (_value) {
	do_maneuver()
}, function () {
	return undefined
})