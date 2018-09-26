// Just a helper class to help manage dual wield weapons.
class DualWeaponsManager extends Object
	abstract;

struct FDualList
{
	var class<KFWeapon> Single,Dual;
};
var array<FDualList> DualMap;

static final function bool IsDualWeapon( class<Weapon> W, optional out class<KFWeapon> SingleType )
{
	local int i;
	
	if( W.Default.DemoReplacement!=None )
	{
		SingleType = class<KFWeapon>(W.Default.DemoReplacement);
		return true;
	}
	for( i=(Default.DualMap.Length-1); i>=0; --i )
		if( W==Default.DualMap[i].Dual )
		{
			SingleType = Default.DualMap[i].Single;
			return true;
		}
	return false;
}

static final function bool HasDualies( class<Weapon> W, Inventory InvList, optional out class<KFWeapon> DualType )
{
	local int i;
	local Inventory In;
	
	for ( In=InvList; In!=None; In=In.Inventory )
		if( Weapon(In)!=None && Weapon(In).DemoReplacement==W )
		{
			DualType = class<KFWeapon>(In.Class);
			return true;
		}

	for( i=(Default.DualMap.Length-1); i>=0; --i )
		if( W==Default.DualMap[i].Single )
		{
			DualType = Default.DualMap[i].Dual;
			W = Default.DualMap[i].Dual;
			for ( In=InvList; In!=None; In=In.Inventory )
				if( In.Class==W )
					return true;
			return false;
		}
	return false;
}

defaultproperties
{
	//DualMap(0)=(Single=Class'SnMod.Single',Dual=Class'SnMod.Dualies')
	//DualMap(1)=(Single=Class'SnMod.Magnum44Pistol',Dual=Class'SnMod.Dual44Magnum')
	//DualMap(2)=(Single=Class'SnMod.Deagle',Dual=Class'SnMod.DualDeagle')
	//DualMap(3)=(Single=Class'SnMod.FlareRevolver',Dual=Class'SnMod.DualFlareRevolver')
	//DualMap(4)=(Single=Class'SnMod.MK23Pistol',Dual=Class'SnMod.DualMK23Pistol')
	//DualMap(5)=(Single=Class'SnMod.GoldenDeagle',Dual=Class'SnMod.GoldenDualDeagle')
}