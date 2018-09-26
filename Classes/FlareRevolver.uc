class FlareRevolver extends KFMod.FlareRevolver;

function bool HandlePickupQuery( pickup Item )
{
	return Super.HandlePickupQuery(Item);
}

simulated function bool PutDown()
{
	return Super.PutDown();
}

defaultproperties
{
    Weight=4.000000//2.000000
    FireModeClass(0)=Class'SnMod.FlareRevolverFire'
    PickupClass=Class'SnMod.FlareRevolverPickup'
    ItemName="Flare Revolver SN"

    AppID=0//210934
}
