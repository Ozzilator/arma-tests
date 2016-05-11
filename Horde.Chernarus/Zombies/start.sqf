/*
	Author: Niggl
	File: start.sqf
	
	This file starts the "Zombie infection" #OhShit not really at the moment it spawns zombies (Zombie_Array.sqf) at the NW-Airfield of Chernarus (CUP Map).
	
	Planning on making a dynamic spawn system which analyses the players position combined the nearest cities and buildings. Means if Player xyz walks into Elektro 20 zombies spawn. If xyz walks in the forest maybe one or two zombies will spawn. This is something i probably will never do bc im to lazy.
*/

//if (!isServer) exitWith {};


Niggl_ZombieDebug = true;					// Map Markers bei Zombies
Niggl_initialZombieSpawns = 25;				// Anzahl Zombies am anfang
Niggl_ZombieSpawnPeriod = 60;				// Zeit zwischen jedem Zombiespawn
Niggl_ZombieHordeSize = 25;
// Änder was ab hier und du hast spaß

//Niggl_worldCenter = (getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"));

	private["_Zombie_Array","_Zombie","_Array_Pos","_leader","_Horde","_Horde_Marker","_Zombie_pos","_agent","_damn_pos","_trgt","_markers"];
	_Zombie_Array = ZombieBoss_Array;
	_Zombie = _Zombie_Array call BIS_fnc_selectRandom;
	_Zombie = _Zombie select 0;
	_Array_Pos = Niggl_Zombie_pos_Array;
	_Zombie_pos = _Array_Pos call BIS_fnc_selectRandom;
	_pos = _Zombie_pos;
	_damn_pos = _Array_Pos select 0;
	_trgt = _Array_Pos select 1;

	_Horde = createGroup EAST;
	_leader = _Zombie createUnit[_trgt, _Horde,"",1,"CAPTAIN"];
	
	for [{_i = 0},{_i <= Niggl_ZombieHordeSize},{_i = _i + 1}] do
{
	_Zombie = _Zombie_Array call BIS_fnc_selectRandom;
	_Zombie = _Zombie select 0;
	_agent = createAgent[_Zombie, _trgt,[], 40, "NONE"];
	_agent disableAI "FSM";
	_agent disableAI "AUTOTARGET";
	_agent setBehaviour "COMBAT";
	_agent setCombatMode "GREEN";
	_agent setSkill 0;
	_agent setUnitPos "UP";
	_agent moveTo _damn_pos;
	_agent forceSpeed 2;
	sleep 0.05;
};
leader _Horde moveto _damn_pos;