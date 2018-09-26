class DualDeagle extends KFMod.DualDeagle;

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
    //Weight=6.000000//4.000000
    FireModeClass(0)=Class'SnMod.DualDeagleFire'
    InventoryGroup=3//2
    PickupClass=Class'SnMod.DualDeaglePickup'
    ItemName="Dual Handcannons SN"
}
