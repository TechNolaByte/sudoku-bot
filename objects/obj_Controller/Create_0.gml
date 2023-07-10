#macro SubCellSize 20
#macro CellSize SubCellSize*3
#macro MetaCellSize CellSize*3

board = array_create_ext(9, function(){
	return array_create(9);
})

for(var _x = 0; _x < array_length(board); _x++){
	for(var _y = 0; _y < array_length(board[_x]); _y++){
		var _inst = instance_create_depth(5+(CellSize*_x), 5+(CellSize*_y), 0, obj_Cell);
		_inst.tileX = _x;
		_inst.tileY = _y;
		
		board[_x][_y] = _inst;
	}
}


history = [];
save_board = function(){
	var _state = {};
	with(obj_Cell) struct_set(_state, id, json_stringify(self))

	array_push(history, _state);
}

restore_history = function(){
	var _state = array_pop(history);
	if(_state == undefined) return;
	
	with(obj_Cell){
		var _substate = json_parse(struct_get(_state, id));
		var _keys = struct_get_names(_substate);
		for(var i = 0; i < array_length(_keys); i++){
			variable_instance_set(id, _keys[i], struct_get(_substate, _keys[i]));
		}
	}
}