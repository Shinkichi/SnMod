class DamTypeMAC10MPInc extends KFMod.KFProjectileWeaponDamageType
	abstract;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount)
{
	KFStatsAndAchievements.AddFlameThrowerDamage(Amount);
	KFStatsAndAchievements.AddMac10BurnDamage(Amount);
}

defaultproperties
{
	HeadShotDamageMult=1.0
    WeaponClass=Class'SnMod.MAC10MP'
    DeathString="%k killed %o (MAC-10)."
    FemaleSuicide="%o shot herself in the foot."
    MaleSuicide="%o shot himself in the foot."

    bDealBurningDamage=true

	// Make this bullet move the ragdoll when its shot
	bRagdollBullet=true
    KDeathVel=150.000000
    KDamageImpulse=1850
    KDeathUpKick=5
}
