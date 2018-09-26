//class FNFALFire extends BaseWeaponFire;
class FNFALFire extends KFMod.KFFire;

defaultproperties
{
    //ProjectileClass=Class'SnMod.FNFALBullet'
    //ProjPerFire=1
    FireAimedAnim=Fire_Iron
    FireSound=Sound'KF_FNFALSnd.FNFAL_Fire_Single_M'
    StereoFireSoundRef="KF_FNFALSnd.FNFAL_Fire_Single_S"
	NoAmmoSoundRef="KF_SCARSnd.SCAR_DryFire"
	DamageType=Class'SnMod.DamTypeFNFALAssaultRifle'
	DamageMin=70//60
	DamageMax=80//65
	Momentum=8500.000000
    bPawnRapidFireAnim=True
    TransientSoundVolume=1.8
    FireLoopAnim="Fire"//"Fire_Loop"
    FireForce="AssaultRifleFire"
    FireRate=0.15//0.075
	RecoilRate=0.08
	maxVerticalRecoilAngle=300//150
	maxHorizontalRecoilAngle=115
    TweenTime=0.025
    //bAccuracyBonusForSemiAuto=true
	//bWaitForRelease=true

    AmmoClass=Class'SnMod.FNFALAmmo'
    AmmoPerFire=1
    BotRefireRate=0.990000
	FlashEmitterClass=Class'ROEffects.MuzzleFlash1stSTG'
	aimerror=42.000000
	Spread=0.0085
	SpreadStyle=SS_Random

	//** View shake **//
	ShakeOffsetMag=(X=6.0,Y=3.0,Z=8.5)
	ShakeOffsetRate=(X=1000.0,Y=1000.0,Z=1000.0)
	ShakeOffsetTime=1.15
	ShakeRotMag=(X=80.0,Y=80.0,Z=450.0)
	ShakeRotRate=(X=7500.0,Y=7500.0,Z=7500.0)
	ShakeRotTime=0.65

	ShellEjectClass=class'KFMod.KFShellEjectFAL'
	ShellEjectBoneName=Shell_eject
	bRandomPitchFireSound=false
}