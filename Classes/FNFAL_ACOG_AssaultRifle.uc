class FNFAL_ACOG_AssaultRifle extends KFMod.FNFAL_ACOG_AssaultRifle
	config(user);

// Use alt fire to switch fire modes
/*simulated function AltFire(float F)
{
	return;
}*/

defaultproperties
{
    MagCapacity=20
	Weight=7.000000//6.000000
    FireModeClass(0)=Class'SnMod.FNFALFire'
    PickupClass=Class'SnMod.FNFAL_ACOG_Pickup'
    PlayerViewOffset=(X=3.000000,Y=15.00000,Z=-6.000000)
    ItemName="FNFAL ACOG SN"
    //DisplayFOV=55.000000
    //StandardDisplayFOV=55.0//60.0
    PlayerIronSightFOV=45.0
    //ZoomedDisplayFOV=10//15
}
