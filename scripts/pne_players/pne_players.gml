#macro PLAYER_INPUT_INVERSE 0.0078740157480315
#macro PLAYER_AIM_INVERSE 0.010986328125
#macro PLAYER_AIM_DIRECT 91.02222222222222

enum PlayerStatus {
	INACTIVE,
	PENDING,
	ACTIVE,
}

enum PlayerInputs {
	UP_DOWN,
	LEFT_RIGHT,
	JUMP,
	INTERACT,
	ATTACK,
	INVENTORY_UP,
	INVENTORY_LEFT,
	INVENTORY_DOWN,
	INVENTORY_RIGHT,
	AIM,
	AIM_UP_DOWN,
	AIM_LEFT_RIGHT,
	FORCE_UP_DOWN,
	FORCE_LEFT_RIGHT,
	__SIZE,
}

global.players_active = 0
global.players_ready = 0

var _players = array_create(INPUT_MAX_PLAYERS)
var i = 0

repeat INPUT_MAX_PLAYERS {
	var _player = new Player()
	
	with _player {
		slot = i
		
		if i == 0 {
			__show_reconnect_caption = false
			activate()
		}
	}
	
	_players[i] = _player;
	++i
}

global.players = _players
input_join_params_set(1, INPUT_MAX_PLAYERS, "leave", undefined, false)
input_source_mode_set(INPUT_SOURCE_MODE.JOIN)