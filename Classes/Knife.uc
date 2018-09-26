class Knife extends KFMod.Knife;

defaultproperties
{
    Skins(0)=Texture'SnTex.Null.NoTex'
    weaponRange=60.000000//65.000000
    BloodyMaterial=Texture'SnTex.Null.NoTex'
    //WeaponIdleMovementAnim="IdleMoveSyringe"
    Weight=0.000000
    bKFNeverThrow=True
    bCanThrow=false
    //FireModeClass(0)=Class'SnMod.KnifeFire'
    FireModeClass(0)=Class'SnMod.ClawsFire'
    FireModeClass(1)=Class'SnMod.ClawsFireB'
    //FireModeClass(1)=Class'SnMod.KnifeFireB'
	SelectSound=Sound'KF_9MMSnd.9mm_Select'
    Description="Bloody and Sharp. Yikes! "
    PickupClass=Class'SnMod.KnifePickup'
    AttachmentClass=Class'SnMod.ClawsAttachment'
    ItemName="Fist SN"//"Knife SN"
   	TraderInfoTexture=none
}
