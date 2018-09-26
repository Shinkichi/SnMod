class DeaglePickup extends KFMod.DeaglePickup;

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
	Weight=4.000000//2.000000
	cost=1200//500
	BuyClipSize=8//7
	ItemName="Handcannon SN"
	ItemShortName="Handcannon SN"
	InventoryType=Class'SnMod.Deagle'
	PickupMessage="You got the Handcannon SN."
	CorrespondingPerkIndex=8//2

	VariantClasses[0]=none//class'KFMod.GoldenDeaglePickup'
}
