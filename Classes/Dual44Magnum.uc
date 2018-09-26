class Dual44Magnum extends KFMod.Dual44Magnum;

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
    Weight=3.000000//4.000000
    FireModeClass(0)=Class'SnMod.Dual44MagnumFire'
    InventoryGroup=3//2
    PickupClass=Class'SnMod.Dual44MagnumPickup'
    ItemName="Dual 44 Magnums SN"
}
