class ClawsPickup extends KFMod.KFWeaponPickup;

defaultproperties
{
	Weight=0.000000
	cost=0//50
	PowerValue=4//5
	SpeedValue=48//60
	RangeValue=-20
	Description="Bloody and Sharp. Yikes! "
	ItemName="Fist SN"
	ItemShortName="Fist SN"
	PickupMessage="You got the Claws SN."
	InventoryType=Class'SnMod.Claws'
	PickupSound=none // can't ever drop this weapon
	PickupForce="AssaultRiflePickup"
	StaticMesh=StaticMesh'22Patch.ClotGibArm'
	CollisionHeight=5.000000
	CorrespondingPerkIndex=4
}
