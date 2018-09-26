class DualFlareRevolver extends KFMod.DualFlareRevolver;

function bool HandlePickupQuery( pickup Item )
{
	return Super.HandlePickupQuery(Item);
}

function GiveTo( pawn Other, optional Pickup Pickup )
{
	UpdateMagCapacity(Other.PlayerReplicationInfo);

	if ( KFWeaponPickup(Pickup)!=None && Pickup.bDropped )
	{
		MagAmmoRemaining = Clamp(KFWeaponPickup(Pickup).MagAmmoRemaining, 0, MagCapacity);
	}
	else
		MagAmmoRemaining = MagCapacity;

	Super(Weapon).GiveTo(Other,Pickup);
}

function DropFrom(vector StartLocation)
{
	Super(Weapon).DropFrom(StartLocation);
}

simulated function bool PutDown()
{
	return super.PutDown();
}

defaultproperties
{
    MagCapacity=12
    //Weight=3.000000//4.000000
    FireModeClass(0)=Class'SnMod.DualFlareRevolverFire'
    InventoryGroup=3//2
    PickupClass=Class'SnMod.DualFlareRevolverPickup'
    ItemName="Dual Flare Revolvers SN"
    AppID=0//210934
}
