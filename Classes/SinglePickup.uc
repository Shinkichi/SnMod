class SinglePickup extends KFMod.SinglePickup;

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
	Weight=0.000000
	cost=150//0
	AmmoCost=10
	BuyClipSize=30
	ItemName="9mm Pistol SN"
	ItemShortName="9mm Pistol SN"
	InventoryType=Class'SnMod.Single'
	PickupMessage="You got the 9mm handgun SN."
	CorrespondingPerkIndex=8//2
}
