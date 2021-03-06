//Custom Killing Floor M79 HE Grenade Damage Type
class DamTypeM79Grenade extends KFMod.KFWeaponDamageType;

static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictimHealth)
{
	HitEffects[0] = class'HitSmoke';
	if( VictimHealth <= 0 )
		HitEffects[1] = class'KFHitFlame';
	else if ( FRand() < 0.8 )
		HitEffects[1] = class'KFHitFlame';
}

defaultproperties
{
	HeadShotDamageMult=1.0
    WeaponClass=Class'SnMod.M79GrenadeLauncher'
    DeathString="%o filled %k's body with shrapnel."
    FemaleSuicide="%o blew up."
    MaleSuicide="%o blew up."
    bKUseOwnDeathVel=True
    DamageThreshold=1
//    KDamageImpulse=15000.000000
//    KDeathVel=800.000000
//    KDeathUpKick=800.000000
    bIsPowerWeapon=false
    bCheckForHeadShots=false
    bLocationalHit=false
	KDamageImpulse=3000
    KDeathVel=300
	KDeathUpKick=250
	bExtraMomentumZ=true
    bThrowRagdoll=True
    bIsExplosive=True

	HumanObliterationThreshhold=150

	DeathOverlayMaterial=Material'Effects_Tex.PlayerDeathOverlay'
	DeathOverlayTime=999
}

