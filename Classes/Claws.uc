class Claws extends KFMod.KFMeleeGun;

defaultproperties
{
    Skins(0)=Texture'SnTex.Null.NoTex'

    weaponRange=60.000000//65.000000
    BloodyMaterial=Texture'SnTex.Null.NoTex'
    BloodSkinSwitchArray=0
    bSpeedMeUp=True
    //WeaponIdleMovementAnim="IdleMoveSyringe"
    Weight=0.000000
    bKFNeverThrow=True
    bCanThrow=False
    FireModeClass(0)=Class'SnMod.ClawsFire'
    FireModeClass(1)=Class'SnMod.ClawsFireB'
	SelectSound=Sound'KF_9MMSnd.9mm_Select'
    Description="Bloody and Sharp. Yikes! "
    Priority=0
    SmallViewOffset=(X=0.000000,Y=0.000000,Z=0.000000)
    GroupOffset=1
    PickupClass=Class'SnMod.ClawsPickup'
    PlayerViewOffset=(X=0.000000,Y=0.000000,Z=0.000000)
    BobDamping=8.000000
    AttachmentClass=Class'SnMod.ClawsAttachment'
    IconCoords=(X1=246,Y1=80,X2=332,Y2=106)
    ItemName="Fists SN"
    Mesh=SkeletalMesh'KF_Weapons_Trip.Knife_Trip'
    AmbientGlow=0

    AIRating=0.2
    CurrentRating=0.2

    DisplayFOV=75.000000
    StandardDisplayFOV=75.0

    HudImage=none
    SelectedHudImage=none
    TraderInfoTexture=none
}