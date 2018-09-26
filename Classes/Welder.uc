class Welder extends KFMod.Welder
	dependson(KFVoicePack);

defaultproperties
{
    AmmoRegenRate=40.000000
    weaponRange=90.000000
    Weight=0.000000
    bKFNeverThrow=True
    FireModeClass(0)=Class'SnMod.WeldFire'
    FireModeClass(1)=Class'SnMod.UnWeldFire'
    PickupClass=Class'SnMod.WelderPickup'
    ItemName="Welder SN"
}
