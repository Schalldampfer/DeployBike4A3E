/*
	Author: Schalldampfer
	[_player,_vehClass]
*/
private ["_player","_puid","_owner","_position","_vehClass","_vehObj","_isOk"];
_player = _this select 0;
_puid = getPlayerUID _player;
_owner = owner _player;
_position = getPos _player;
_vehClass = _this select 1;

diag_log format["[DeployBike] Try spawning %1 by %2",_vehClass,_player];

_isOk = true;
if(isNil "Deploy_DeployedVehicles") then {Deploy_DeployedVehicles = [];};

//check player haven't spawned one
{
	if ((_x getVariable ["EPOCH_DeployOwner","-1"]) == _puid) then { _isOk = false;"You've already deployed a vehicle!" remoteExec ["Epoch_message",_player]; };
} foreach Deploy_DeployedVehicles;

//spawn
if (_isOk) then {
	_vehObj = _vehClass createVehicle _position; //create
	_vehObj allowDamage false;
	
	//init
	_vehObj setVectorUp (surfaceNormal (getPos _vehObj));
	_vehObj setVelocity [0,0,.1];
	_vehObj call EPOCH_server_setVToken;
	//_vehObj call EPOCH_server_vehicleInit;
	Deploy_DeployedVehicles set [count Deploy_DeployedVehicles, _vehObj];//add to array
	_vehObj setvariable ["EPOCH_DeployOwner",_puid];//set puid as owner
	_vehObj addEventHandler ["GetIn", {"WARNING: This vehicle will be deleted at restart!" remoteExec ["Epoch_message",_this select 2];}];//warn when get in
	
	// Normalize vehicle inventory
	clearWeaponCargoGlobal    _vehObj;
	clearMagazineCargoGlobal  _vehObj;
	clearBackpackCargoGlobal  _vehObj;
	clearItemCargoGlobal	  _vehObj;
	
	_vehObj setFuel ((random 1 max 0.1) min 0.9);//fuel
	
	//complete spaning
	_vehObj allowDamage true;
	format["You've deployed a %1!", _vehClass] remoteExec ["Epoch_message",_player];
};

_vehObj
