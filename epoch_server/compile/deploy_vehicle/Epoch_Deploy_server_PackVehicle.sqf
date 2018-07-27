/*
	Author: Schalldampfer

	[_player,_vehObj]
*/
private ["_player","_puid","_owner","_vehObj","_vehClass"];
_player = _this select 0;
_puid = getPlayerUID _player;
_owner = owner _player;
_vehObj = _this select 1;
_vehClass = typeOf _vehObj;

if ((_vehObj getVariable ["EPOCH_DeployOwner","-1"]) == _puid) then {//check owner
	Deploy_DeployedPlayer = Deploy_DeployedPlayer - [_puid];//remove from array
	deleteVehicle _vehObj;//remove vehicle
	format["You've packed a %1!", _vehClass] remoteExec ["Epoch_message",_player];
};

