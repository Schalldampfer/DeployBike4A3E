# DeployBike4A3E
*Deploy vehicle from dyna menu (Space key menu)
*Pack vehicle from dyna menu while looking at it
*You can define any vehicle to spawn 
*The vehicle is spawned server side (not saved in the hive, but theoretically possible)
*No animation like DayZ Epoch's "deploy anything" for now (but theoretically possible with client side modification)

Server side

copy these two files:
epoch_server\compile\deploy_vehicle\Epoch_Deploy_server_PackVehicle.sqf
epoch_server\compile\deploy_vehicle\Epoch_Deploy_server_SpawnVehicle.sqf

Modify those files:
epoch_server\config.cpp Line146~(in class CfgServerFunctions -> class A3E):

        class deploy_vehicle {
            class Deploy_server_SpawnVehicle {};
            class Deploy_server_PackVehicle {};
        };

epoch_server\init\server_init.sqf : at bottom (outside any curly brackets)
"Deploy_SpawnVehicle" addPublicVariableEventHandler{(_this select 1) call Epoch_Deploy_server_SpawnVehicle};
"Deploy_PackVehicle"  addPublicVariableEventHandler{(_this select 1) call Epoch_Deploy_server_PackVehicle};


Client side

Modify two files:
epoch_config\Configs\CfgActionMenu\CfgActionMenu_self.hpp (at bottom)

class Deploy_deploy
{
	condition = "!dyna_inVehicle";
	action = "Deploy_SpawnVehicle = [player,'MBK_01_EPOCH']; publicVariableServer 'Deploy_SpawnVehicle';";
	icon = "x\addons\a3_epoch_code\Data\UI\buttons\repair.paa";
	tooltip = "Deploy Bike";
};

epoch_config\Configs\CfgActionMenu\CfgActionMenu_target.hpp (at bottom)

class Deploy_pack
{
	condition = "(dyna_cursorTarget iskindof 'MBK_01_EPOCH') && ((crew dyna_cursorTarget) isEqualTo [])";
	action = "Deploy_PackVehicle = [player,dyna_cursorTarget]; publicVariableServer 'Deploy_PackVehicle';";
	icon = "x\addons\a3_epoch_code\Data\UI\buttons\repair.paa";
	tooltip = "Pack Vehicle";
};

BE filter:
in the end of the 1st line of publicvariable.txt :
 !="Deploy_SpawnVehicle" !="Deploy_PackVehicle"
