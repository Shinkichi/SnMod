class Magnum44Pickup extends KFMod.Magnum44Pickup;

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
	cost=300//450
	BuyClipSize=6
	ItemName="44 Magnum SN"
	ItemShortName="44 Magnum SN"
	InventoryType=Class'SnMod.Magnum44Pistol'
	PickupMessage="You got the 44 Magnum SN."
	CorrespondingPerkIndex=8//2
}
