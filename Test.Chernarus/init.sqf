call compile preProcessFile "loot\positions.sqf";
call compile preProcessFile "loot\wepArrays.sqf";
Niggl_fnc_loot = compile preProcessFile "loot\hrn_loot.sqf";
[] spawn Niggl_fnc_loot;
//Starts all