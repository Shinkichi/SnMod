class DamTypeSPSniper extends KFMod.KFProjectileWeaponDamageType
	abstract;

static function ScoredHeadshot(KFSteamStatsAndAchievements KFStatsAndAchievements, class<KFMonster> MonsterClass, bool bLaserSightedM14EBRKill)
{
	super.ScoredHeadshot( KFStatsAndAchievements, MonsterClass, bLaserSightedM14EBRKill );

	if ( KFStatsAndAchievements != none )
	{
     	KFStatsAndAchievements.AddHeadshotsWithSPSOrM14( MonsterClass );
	}
}

defaultproperties
{
    WeaponClass=Class'SnMod.SPSniperRifle'
    DeathString="%k killed %o (S.P. Musket)."
    FemaleSuicide="%o shot herself in the foot."
    MaleSuicide="%o shot himself in the foot."

	// Make this bullet move the ragdoll when its shot
	bRagdollBullet=true
    KDeathVel=175.000000
    KDamageImpulse=7500
    KDeathUpKick=25
	bSniperWeapon=True
    HeadShotDamageMult=1.25
}
