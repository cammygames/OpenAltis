/*
	file: fn_takeOrgans.sqf
	author: [midgetgrimm] - www.grimmlife.com
	
	taken from the same idea of robbing script by tonic
*/
private["_unit"];
_unit = cursorTarget;
organList = ["kidney","lung","spleen","leg","testicles","eyes"];

if(isNull _unit) exitWith {}; //if unit is null, than NO
if((_unit getVariable ["missingOrgan",FALSE])) exitWith {};//must not be missing organ already
if((player getVariable ["hasOrgan",FALSE])) exitWith {};//thief must not have already robbed an organ within last 5 mintues
if(!([false,"scalpel",1] call life_fnc_handleInv)) exitWith {"You dont have a scalpel"};
if((animationState _unit != "Incapacitated")) exitWith {};//victim must be knocked out
if(player == _unit) exitWith {};//if the thief is the cursor target(dafuq) than NO
if(!isPlayer _unit) exitWith {};//iff the cursor target is not a player than NO
//if(life_inv_kidney >= 2) exitWith {hint "You can't possibly need that many organs!"};//if you already have 2 kidneys, then go sell them already, no stockpiling
//if(!([true,"spleen",1] call life_fnc_handleInv)) exitWith {hint "You don't have room to store any organs!"};//if no room for kidney, you cannot take their kidney, duh, waste not want not
life_action_inUse = true;//sets action to true as to prevent kidney spammming!!!!!!!!
player setVariable["hasOrgan",true,true];//sets variable on thief, so as not to consistently take organs, set to 5 minute cooldown
player playMove "AinvPknlMstpSnonWnonDnon_medic";//makes the thief do an animation as to seem like they are doing surgery
 
_sCount = count organList;
for "_x" from 0 to 0 do {
        _sSelect = floor(random _sCount);
        _item = organList select _sSelect;
        //_itemName = [([_item,0] call life_fnc_varHandle)] call life_fnc_varToStr;
        //[[1,format["%1 has cut out an Organ from %2.",name _organThief,name player]],"life_fnc_broadcast",nil,false] spawn life_fnc_MP;//lets people know you are stealing kidneys
        if(!([true,_item,1] call life_fnc_handleInv)) exitWith {hint "You don't have room to store any organs!"};
	};
	
sleep 3;//length of action, had weird results with any higher - obv not realistic, but whatever
_unit setVariable["missingOrgan",true,true];//sets the missing organ variable so effects can take place
life_action_inUse = false;//once variables are set, and actions stop, then you can use scrolly wheely
[[player], "life_fnc_hasOrgan", _unit, false] spawn life_fnc_MP;//this then calls the fn_hasOrgan.sqf on the thief