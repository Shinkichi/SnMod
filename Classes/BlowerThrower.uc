class BlowerThrower extends KFMod.BlowerThrower;

defaultproperties
{
    MagCapacity=50
    Weight=10.000000//6.000000
    FireModeClass(0)=Class'SnMod.BlowerThrowerFire'
    //FireModeClass(1)=Class'SnMod.BlowerThrowerAltFire'
    FireModeClass(1)=Class'KFmod.NoFire'
    InventoryGroup=4//3
    PickupClass=Class'SnMod.BlowerThrowerPickup'
    ItemName="BlowerThrower SN"

    PutDownTime = 0.33//0.5
    PutDownAnimRate=1.00//1.3636
    QuickPutDownTime=0.15//0.25

	AppID=0//258751
}
