/*
	Author: Niggl
	
*/

//if (!isServer) exitWith {};


Niggl_ZombieDebug = true;					// Map Markers wo loot ist (sein sollte)
Niggl_initialZombieSpawns = 5;				// Anzahl Lootstellen am anfang
Niggl_ZombieSpawnPeriod = 15;				// Zeit zwischen jeder Lootstelle

// Änder was ab hier und du hast spaß

//Niggl_worldCenter = (getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"));

Niggl_fnc_spawnZombie =
{
	private["_Zombie_Array","_Zombie","_Array_Pos","_Zombie_pos"];
	_Zombie_Array = ZombieBoss_Array;
	_Zombie = _Zombie_Array select (floor (random (count _Zombie_Array)));
	_Zombie = _Zombie select 0;
	_Array_Pos = Niggl_Zombie_pos_Array;
	_Zombie_pos = _Array_Pos select (floor (random (count _Array_Pos)));
	_pos = _Zombie_pos;
	_Zombie createUnit [_pos, group player];
	if (Niggl_ZombieDebug) then
	{
		_mrk = createMarker [format["%1_Marker", floor (random 100000)], _pos];
		_mrk setMarkerShape "ICON";
		_mrk setMarkerType "hd_warning";
		_mrk setMarkerColor "ColorRed";
	};
};

for [{_i = 0},{_i <= Niggl_initialZombieSpawns},{_i = _i + 1}] do
{
	[] call Niggl_fnc_spawnZombie;
	sleep 0.05;
};

while {true} do
{
	[] call Niggl_fnc_spawnZombie;
	sleep Niggl_ZombieSpawnPeriod;
};