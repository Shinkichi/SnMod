class DamTypeFlareProjectileImpact extends KFMod.KFProjectileWeaponDamageType;

static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictimHealth)
{
	HitEffects[0] = class'HitSmoke';
	if( VictimHealth <= 0 )
		HitEffects[1] = class'KFHitFlame';
	else if ( FRand() < 0.8 )
		HitEffects[1] = class'KFHitFlame';
}

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount)
{
	KFStatsAndAchievements.AddFlameThrowerDamage(Amount);
}

defaultproperties
{
    WeaponClass=Class'SnMod.FlareRevolver'
    DeathString="%k killed %o (Flare Revolver)."
    FemaleSuicide="%o blew up."
    MaleSuicide="%o blew up."
    bRagdollBullet=True
    bBulletHit=True

    KDamageImpulse=6000.000000
    KDeathVel=250.000000
    KDeathUpKick=75.000000

    bIsPowerWeapon=false

    DeathOverlayMaterial=Combiner'Effects_Tex.GoreDecals.PlayerDeathOverlay'
    DeathOverlayTime=999.000000

    HumanObliterationThreshhold=200
    HeadShotDamageMult=1.500000
}
