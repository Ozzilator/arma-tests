call compile preProcessFile "loot\positions.sqf";
call compile preProcessFile "loot\Waffe_Array.sqf";
call compile preProcessFile "loot\Ammo_array.sqf";
call compile preProcessFile "loot\Cl_array.sqf";
call compile preProcessFile "loot\Backpack_array.sqf";
Niggl_fnc_loot = compile preProcessFile "loot\_loot.sqf";
[] spawn Niggl_fnc_loot;
//Starts all


call compile preProcessFile "Zombies\Z_Pos.sqf";
call compile preProcessFile "Zombies\Zombie_Array.sqf";
Niggl_fnc_Zombies = compile preProcessFile "Zombies\start.sqf";
[] spawn Niggl_fnc_Zombies;
