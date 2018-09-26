class DamTypeSCARMK17AssaultRifle extends KFMod.KFProjectileWeaponDamageType
	abstract;

static function AwardKill(KFSteamStatsAndAchievements KFStatsAndAchievements, KFPlayerController Killer, KFMonster Killed )
{
	if( Killed.IsA('ZombieStalker') )
		KFStatsAndAchievements.AddStalkerKill();
}

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount)
{
	KFStatsAndAchievements.AddBullpupDamage(Amount);
}

defaultproperties
{
	HeadShotDamageMult=1.25
    WeaponClass=Class'SnMod.SCARMK17AssaultRifle'
    DeathString="%k killed %o (SCARMK17)."
    FemaleSuicide="%o shot herself in the foot."
    MaleSuicide="%o shot himself in the foot."

	// Make this bullet move the ragdoll when its shot
	bRagdollBullet=true
    KDeathVel=175.000000
    KDamageImpulse=6500
    KDeathUpKick=20
}
