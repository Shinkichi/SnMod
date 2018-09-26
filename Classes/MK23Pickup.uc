class MK23Pickup extends KFMod.MK23Pickup;

function inventory SpawnCopy( pawn Other )
{
	local inventory Copy;

	if ( Inventory != None )
	{
		Copy = Inventory;
		Inventory = None;
	}
	else
		Copy = spawn(InventoryType,Other,,,rot(0,0,0));

	Copy.GiveTo( Other, self );

	return Copy;
}

defaultproperties
{
    Weight=3.000000//2.000000
    cost=600//500
    BuyClipSize=12
    ItemName="MK23 SN"
    ItemShortName="MK23 SN"
    InventoryType=Class'SnMod.MK23Pistol'
    PickupMessage="You got the MK.23 SN."
    CorrespondingPerkIndex=8//2
}
