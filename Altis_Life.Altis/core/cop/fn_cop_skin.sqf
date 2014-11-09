#include <macro.h>

if(playerSide == civilian) exitWith {};

if(playerSide == west) then 
{
	if ((__GETC__(life_coplevel) > 0) && (uniform player == "U_Rangemaster")) then {
		player setObjectTextureGlobal[0,"textures\police_shirt.paa"];
	};

	if ((__GETC__(life_coplevel) >= 4) && (uniform player == "U_B_CombatUniform_mcam")) then {
		player setObjectTextureGlobal[0,"textures\swat_shirt.paa"];
	};
};