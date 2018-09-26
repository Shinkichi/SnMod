class ThompsonFire extends KFMod.KFFire;

defaultproperties
{
    FireAimedAnim=Fire_Iron
    FireSound=Sound'KF_IJC_HalloweenSnd.Thompson_Fire_Single_M'
    StereoFireSoundRef="KF_IJC_HalloweenSnd.Thompson_Fire_Single_S"
    NoAmmoSound=Sound'KF_AK47Snd.AK47_DryFire'
    DamageType=Class'SnMod.DamTypeThompson'
    DamageMin=25//35
    DamageMax=35//40
    Momentum=8500.000000
    bPawnRapidFireAnim=True
    TransientSoundVolume=1.8
    FireLoopAnim="Fire"//"Fire_Loop"
    FireForce="AssaultRifleFire"
    FireRate=0.1//0.0857
    RecoilRate=0.080000
    maxVerticalRecoilAngle=150
    maxHorizontalRecoilAngle=100
    TweenTime=0.025000
    bAccuracyBonusForSemiAuto=true

    AmmoClass=Class'SnMod.ThompsonAmmo'
    AmmoPerFire=1
    BotRefireRate=0.990000
    FlashEmitterClass=Class'ROEffects.MuzzleFlash1stSTG'
    aimerror=42.000000
    Spread=0.012000
    SpreadStyle=SS_Random

    //** View shake **//
    ShakeOffsetMag=(X=6.0,Y=3.0,Z=7.5)
    ShakeOffsetRate=(X=1000.0,Y=1000.0,Z=1000.0)
    ShakeOffsetTime=1.25
    ShakeRotMag=(X=50.0,Y=50.0,Z=350.0)
    ShakeRotRate=(X=5000.0,Y=5000.0,Z=5000.0)
    ShakeRotTime=0.75

    ShellEjectClass=class'KFMod.IJCShellEjectThompson'
    ShellEjectBoneName=Shell_eject
    bRandomPitchFireSound=true
}