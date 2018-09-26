class ClawsAttachment extends KFMod.KFMeleeAttachment;

defaultproperties
{
	Mesh=SkeletalMesh'KF_Weapons3rd_Trip.Knife_3rd'
    Skins(0)=Texture'SnTex.Null.NoTex'
    MovementAnims(0)=JogF_Knife
    MovementAnims(1)=JogB_Knife
    MovementAnims(2)=JogL_Knife
    MovementAnims(3)=JogR_Knife
    CrouchAnims(0)=CHwalkF_Knife
    CrouchAnims(1)=CHwalkB_Knife
    CrouchAnims(2)=CHwalkL_Knife
    CrouchAnims(3)=CHwalkR_Knife
//    WalkAnims(0)=WalkF
//    WalkAnims(1)=WalkB
//    WalkAnims(2)=WalkL
//    WalkAnims(3)=WalkR
    AirStillAnim=JumpF_Mid
    AirAnims(0)=JumpF_Mid
    AirAnims(1)=JumpF_Mid
    AirAnims(2)=JumpL_Mid
    AirAnims(3)=JumpR_Mid
    TakeoffStillAnim=JumpF_Takeoff
    TakeoffAnims(0)=JumpF_Takeoff
    TakeoffAnims(1)=JumpF_Takeoff
    TakeoffAnims(2)=JumpL_Takeoff
    TakeoffAnims(3)=JumpR_Takeoff
    LandAnims(0)=JumpF_Land
    LandAnims(1)=JumpF_Land
    LandAnims(2)=JumpL_Land
    LandAnims(3)=JumpR_Land

    TurnRightAnim=TurnR_Knife
    TurnLeftAnim=TurnL_Knife
    CrouchTurnRightAnim=CH_TurnR_Knife
    CrouchTurnLeftAnim=CH_TurnL_Knife
    IdleRestAnim=Idle_Knife//Idle_Rest
    IdleCrouchAnim=CHIdle_Knife
    IdleSwimAnim=Swim_Tread
    IdleWeaponAnim=Idle_Knife//Idle_Rifle
    IdleHeavyAnim=Idle_Knife//Idle_Biggun
    IdleRifleAnim=Idle_Knife//Idle_Rifle
    IdleChatAnim=Idle_Knife
    FireAnims(0)=Attack1_Knife
    FireAnims(1)=Attack1_Knife
    FireAnims(2)=Attack1_Knife
    FireAnims(3)=Attack1_Knife
    FireAltAnims(0)=Attack2_Knife
    FireAltAnims(1)=Attack2_Knife
    FireAltAnims(2)=Attack2_Knife
    FireAltAnims(3)=Attack2_Knife
    FireCrouchAnims(0)=CHAttack1_Knife
    FireCrouchAnims(1)=CHAttack1_Knife
    FireCrouchAnims(2)=CHAttack1_Knife
    FireCrouchAnims(3)=CHAttack1_Knife
    FireCrouchAltAnims(0)=CHAttack2_Knife
    FireCrouchAltAnims(1)=CHAttack2_Knife
    FireCrouchAltAnims(2)=CHAttack2_Knife
    FireCrouchAltAnims(3)=CHAttack2_Knife
    HitAnims(0)=HitF_Knife
    HitAnims(1)=HitB_Knife
    HitAnims(2)=HitL_Knife
    HitAnims(3)=HitR_Knife
    PostFireBlendStandAnim=Blend_Knife
    PostFireBlendCrouchAnim=CHBlend_Knife
}