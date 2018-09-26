class FlareRevolverPickup extends KFMod.FlareRevolverPickup;

function inventory SpawnCopy(pawn Other)
{
	Return Super.SpawnCopy(Other);
}

defaultproperties
{
     Weight=4.000000//2.000000
     cost=600//500
     AmmoCost=13
     ItemName="Flare Revolver SN"
     ItemShortName="Flare Revolver SN"
     InventoryType=Class'SnMod.FlareRevolver'
     PickupMessage="You got the Flare Revolver SN."
}
