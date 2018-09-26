class DamTypeCrossbuzzsaw extends KFMod.KFProjectileWeaponDamageType;

static function AwardKill(KFSteamStatsAndAchievements KFStatsAndAchievements, KFPlayerController Killer, KFMonster Killed )
{
    local SRStatsBase stats;
    
    // do not count kills of decapitated specimens - those are counted in ScoredHeadshot()
    if ( Killed != none && Killed.bDecapitated )
        return;

    stats = SRStatsBase(KFStatsAndAchievements);
    if( stats !=None && stats.Rep!=None )
        stats.Rep.ProgressCustomValue(Class'SnMod.Progress_Kill_Survivalist',1);

	if ( KFStatsAndAchievements != none )
	{
		if (Killed.IsA('ZombieHusk'))
		{
			KFStatsAndAchievements.AddHuskAndZedOneShotKill(true, false);
		}
		else
		{
        	KFStatsAndAchievements.AddHuskAndZedOneShotKill(false, true);
		}
	}
}

static function ScoredHeadshot(KFSteamStatsAndAchievements KFStatsAndAchievements, class<KFMonster> MonsterClass, bool bLaserSightedM14EBRKill)
{
    local SRStatsBase stats;

	stats = SRStatsBase(KFStatsAndAchievements);
	if( stats !=None && stats.Rep!=None )
		stats.Rep.ProgressCustomValue(Class'SnMod.Progress_Kill_Survivalist',1);

}

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount)
{
    local SRStatsBase stats;
    
    stats = SRStatsBase(KFStatsAndAchievements);
    if( stats !=None && stats.Rep!=None )
        stats.Rep.ProgressCustomValue(Class'SnMod.Progress_Damage_Survivalist',Amount);
}

defaultproperties
{
    WeaponClass=Class'SnMod.Crossbuzzsaw'

    HeadShotDamageMult=2.000000
    bKUseOwnDeathVel=True
    bThrowRagdoll=True
    bFlaming=False
    DamageThreshold=1
    KDamageImpulse=7500.000000
	bSniperWeapon=False

    // Make this bullet move the ragdoll when its shot
    bRagdollBullet=true
    KDeathVel=250.000000
    KDeathUpKick=25
}
