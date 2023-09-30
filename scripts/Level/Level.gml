function Level() constructor {
	static _empty_array = []
	static _empty_struct = {}
	
	name = ""
	areas = ds_map_create()
	
	#region Properties
		rp_name = ""
		rp_icon = ""
		music = undefined
		clear_color = undefined
		ambient_color = undefined
		gravity = 0.6
	#endregion
	
	bump_x = 0
	bump_y = 0
	bump_grid = ds_grid_create(1, 1)
	bump_lists = ds_grid_create(1, 1)
	
	area_things = ds_list_create()
	syncables = ds_grid_create(1, 2)
	
	/// @desc Destroys the contents of the level, allowing it to be removed.
	static destroy = function () {
		ds_list_destroy(area_things)
		
		repeat ds_map_size(areas) {
			var _key = ds_map_find_first(areas)
			
			areas[? _key].destroy()
			ds_map_delete(areas, _key)
		}
		
		ds_map_destroy(areas)
		ds_grid_destroy(bump_grid)
		
		var i = 0
		
		repeat ds_grid_width(bump_lists) {
			var j = 0
			
			repeat ds_grid_height(bump_lists) {
				ds_list_destroy(bump_lists[# i, j++])
			}
			
			++i
		}
		
		ds_grid_destroy(syncables)
	}
	
	static goto = function (_level, _area = 0, _tag = noone, _transition = noone) {
		var _netgame = global.netgame
		
		if _netgame != undefined {
			with _netgame {
				if not master or _level == undefined {
					exit
				}
				
				var i = 0
				
				repeat ds_list_size(players) {
					var _player = players[| i++]
					
					if _player != undefined and not _player.local {
						_player.ready = false
					}
				}
				
				var b = net_buffer_create(true, NetHeaders.HOST_LEVEL)
				
				buffer_write(b, buffer_string, _level)
				buffer_write(b, buffer_u32, _area)
				buffer_write(b, buffer_s32, _tag)
				send(SEND_OTHERS, b)
				other.__force_goto(_level, _area, _tag, true)
			}
		} else {
			with proTransition {
				if state < 3 {
					exit
				}
			}
			
			if is_string(_transition) {
				if string_starts_with(_transition, "pro") {
					show_error($"!!! Level.goto: Tried to transition to level using protected Transition '{_transition}'", true)
				}
				
				var _index = asset_get_index(_transition)
				
				if not object_exists(_index) or not object_is_ancestor(_index, proTransition) {
					_index = noone
					print($"! Level.goto: Transition '{_transition}' not found")
				}
				
				_transition = _index
			}
			
			if object_exists(_transition) and object_is_ancestor(_transition, proTransition) {
				with instance_create_depth(0, 0, 0, _transition) {
					to_level = _level
					to_area = _area
					to_tag = _tag
				}
				
				exit
			}
			
			__force_goto(_level, _area, _tag, false)
		}
	}
	
	static __force_goto = function (_level, _area, _tag, _netgame) {
		with proControl {
			load_level = _level
			load_area = _area
			load_tag = _tag
			load_state = _netgame and _level != undefined ? LoadStates.NETGAME_LEVEL : LoadStates.START
		}
	}
}