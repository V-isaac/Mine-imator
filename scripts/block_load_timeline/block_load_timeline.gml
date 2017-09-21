/// block_load_timeline(map, typemap)
/// @arg map
/// @arg typemap
/// @desc Loads the data required to create a timeline for the block

var map, typemap;
map = argument0
typemap = argument1

timeline = true
		
// Model to use
if (is_string(map[?"model"]))
{
	tl_model_name = map[?"model"]
	
	// Model state
	tl_model_state = ""
	tl_model_state_amount = 0
	tl_has_model_state = false
	
	if (typemap[?"model_state"] = e_json_type.STRING)
	{
		tl_model_state = map[?"model_state"]
		tl_has_model_state = true
	}
	else if (typemap[?"model_state"] = e_json_type.OBJECT) // Determined by block state
	{
		var key = ds_map_find_first(map[?"model_state"]);
		while (!is_undefined(key))
		{
			with (new(obj_block_tl_state))
			{
				state_map = ds_map_create()
				state_vars_string_to_map(key, state_map)
				value = ds_map_find_value(map[?"model_state"], key)
				other.tl_model_state[other.tl_model_state_amount++] = id
			}
			key = ds_map_find_next(map[?"model_state"], key)
		}
		tl_has_model_state = true
	}
}
else // Uses own block model with default state
{
	tl_model_name = ""
	tl_has_model_state = false
}

// Text
tl_has_text = false
if (is_real(map[?"has_text"]))
	tl_has_text = map[?"has_text"]
	
if (tl_has_text)
	tl_text_position = value_get_point3D(map[?"text_position"], point3D(0, 0, 0))
		
// Rotation point
tl_rot_point = point3D(0, 0, 0)
tl_rot_point_state_amount = 0
if (typemap[?"rotation_point"] = e_json_type.ARRAY)
	tl_rot_point = value_get_point3D(map[?"rotation_point"], point3D(0, 0, 0))
else if (typemap[?"rotation_point"] = e_json_type.OBJECT) // Determined by state
{
	var key = ds_map_find_first(map[?"rotation_point"]);
	while (!is_undefined(key))
	{
		with (new(obj_block_tl_state))
		{
			state_map = ds_map_create()
			state_vars_string_to_map(key, state_map)
			value = value_get_point3D(ds_map_find_value(map[?"rotation_point"], key), point3D(0, 0, 0))
			other.tl_rot_point_state[other.tl_rot_point_state_amount++] = id
		}
		key = ds_map_find_next(map[?"rotation_point"], key)
	}
}
		
// Position
tl_position = point3D(0, 0, 0)
tl_position_state_amount = 0
if (typemap[?"position"] = e_json_type.ARRAY)
	tl_position = value_get_point3D(map[?"position"], point3D(0, 0, 0))
else if (typemap[?"position"] = e_json_type.OBJECT) // Determined by state
{
	var key = ds_map_find_first(map[?"position"]);
	while (!is_undefined(key))
	{
		with (new(obj_block_tl_state))
		{
			state_map = ds_map_create()
			state_vars_string_to_map(key, state_map)
			value = value_get_point3D(ds_map_find_value(map[?"position"], key), point3D(0, 0, 0))
			other.tl_position_state[other.tl_position_state_amount++] = id
		}
		key = ds_map_find_next(map[?"position"], key)
	}
}
		
// Rotation
tl_rotation = point3D(0, 0, 0)
tl_rotation_state_amount = 0
if (typemap[?"rotation"] = e_json_type.ARRAY)
	tl_rotation = value_get_point3D(map[?"rotation"], point3D(0, 0, 0))
else if (typemap[?"rotation"] = e_json_type.OBJECT) // Determined by state
{
	var key = ds_map_find_first(map[?"rotation"]);
	while (!is_undefined(key))
	{
		with (new(obj_block_tl_state))
		{
			state_map = ds_map_create()
			state_vars_string_to_map(key, state_map)
			value = value_get_point3D(ds_map_find_value(map[?"rotation"], key), point3D(0, 0, 0))
			other.tl_rotation_state[other.tl_rotation_state_amount++] = id
		}
		key = ds_map_find_next(map[?"rotation"], key)
	}
}

// TODO create preview vbuffer