/*
	Author: Niggl
	
	spawns loot (*_Array.sqf) at cords (position.sqf) in crate.
*/

//if (!isServer) exitWith {};


Niggl_lootDebug = true;					// Map Markers wo loot ist (sein sollte)
Niggl_initialLootSpawns = 150;				// Anzahl Lootstellen
Niggl_lootSpawnPeriod = 15;				// Zeit zwischen jeder Lootstelle

// Änder was ab hier und du hast spaß

Niggl_worldCenter = (getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"));

Niggl_fnc_setLoot =
{
	private["_Objekt_in_das_gespawnt_wird","_random","_array_waffe","_Waffe","_Waffen_NAME","_Waffen_MAGAZIN","_modifiers","_anzahl_mags","_array_ammo","_ammo_Array","_array_Kleidung","_Kleidung","_Kleidung_ENT","_array_Backpack","_Backpack"];
	_Objekt_in_das_gespawnt_wird = _this select 0;
		clearWeaponCargo _Objekt_in_das_gespawnt_wird;
		clearMagazineCargo _Objekt_in_das_gespawnt_wird;
		clearItemCargo _Objekt_in_das_gespawnt_wird;
		clearBackpackCargo _Objekt_in_das_gespawnt_wird;
	_random = round (random 100);
	_array_waffe = Niggl_Random_Weapon_Array;
	_array_ammo = Niggl_AmmoArray;
	_array_Kleidung = Niggl_Cloathing_Array;
	_array_Backpack = Niggl_Backpack_Array;
	_Backpack = _array_Backpack select (floor (random (count _array_Backpack)));
	_Backpack = _Backpack select 0;
	_Kleidung = _array_Kleidung select (floor (random (count _array_Kleidung)));
	_Kleidung_ENT = _Kleidung select 0;
	_ammo_Array = _array_ammo select (floor (random (count _array_ammo)));
	_Waffen_MAGAZIN = _ammo_Array select 0;
	_Waffe = _array_waffe select (floor (random (count _array_waffe)));
	_Waffen_NAME = _Waffe select 0;
	_modifiers = _Waffe select 1;
	_anzahl_mags = round ((random (_modifiers select 1)) + (_modifiers select 0));
	if (_Waffen_NAME != "") then
	{
		_Objekt_in_das_gespawnt_wird addWeaponCargo [_Waffen_NAME, 1];
	};
	if (_Waffen_MAGAZIN != "" && _anzahl_mags > 0) then
	{
		_Objekt_in_das_gespawnt_wird addMagazineCargo [_Waffen_MAGAZIN, _anzahl_mags];
	};
	if (_Kleidung_ENT != "") then
	{
		_Objekt_in_das_gespawnt_wird addItemCargoGlobal [_Kleidung_ENT, 1];
	};
	if (_Backpack != "") then
	{
		_Objekt_in_das_gespawnt_wird addBackpackCargoGlobal [_Backpack, 1];
	};
};

Niggl_fnc_spawnLoot =
{
	private["_a","_pos","_wepHolder","_mrk","_nearHolders"];
	_pos = Niggl_allPositionsArray select (floor (random (count Niggl_allPositionsArray)));
	_nearHolders = nearestObjects [_pos, ["_wepHolder"], 1];
	if (count _nearHolders < 1) then
	{
		_wepHolder = "Box_NATO_Wps_F" createVehicle _pos;
		clearWeaponCargo _wepHolder;
		clearMagazineCargo _wepHolder;
		clearItemCargo _wepHolder;
		clearBackpackCargo _wepHolder;
 
		_wepHolder setPos [_pos select 0, _pos select 1, _pos select 2];
	} else {
		_wepHolder = _nearHolders select 0;
	};
		clearWeaponCargo _wepHolder;
		clearMagazineCargo _wepHolder;
		clearItemCargo _wepHolder;
		clearBackpackCargo _wepHolder;
	_loot = [_wepHolder] spawn Niggl_fnc_setLoot;
	if (Niggl_lootDebug) then
	{
		_mrk = createMarker [format["%1_Marker", floor (random 100000)], _pos];
		_mrk setMarkerShape "ICON";
		_mrk setMarkerType "mil_dot";
	};
};

for [{_i = 0},{_i <= Niggl_initialLootSpawns},{_i = _i + 1}] do
{
	[] call Niggl_fnc_spawnLoot;
	sleep 0.05;
};

while {true} do
{
	[] call Niggl_fnc_spawnLoot;
	sleep Niggl_lootSpawnPeriod;
};