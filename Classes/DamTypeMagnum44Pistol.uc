class DamTypeMagnum44Pistol extends KFMod.KFProjectileWeaponDamageType
	abstract;

static function AwardKill(KFSteamStatsAndAchievements KFStatsAndAchievements, KFPlayerController Killer, KFMonster Killed )
{
    local SRStatsBase stats;
    
    // do not count kills of decapitated specimens - those are counted in ScoredHeadshot()
    if ( Killed != none && Killed.bDecapitated )
        return;

    stats = SRStatsBase(KFStatsAndAchievements);
    if( stats !=None && stats.Rep!=None )
        stats.Rep.ProgressCustomValue(Class'SnMod.Progress_Kill_Gunslinger',1);
}

static function ScoredHeadshot(KFSteamStatsAndAchievements KFStatsAndAchievements, class<KFMonster> MonsterClass, bool bLaserSightedM14EBRKill)
{
    local SRStatsBase stats;

	stats = SRStatsBase(KFStatsAndAchievements);
	if( stats !=None && stats.Rep!=None )
		stats.Rep.ProgressCustomValue(Class'SnMod.Progress_Kill_Gunslinger',1);
	if( stats !=None && stats.Rep!=None )
		stats.Rep.ProgressCustomValue(Class'SnMod.Progress_Headshot_Gunslinger',1);
}

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount)
{
    local SRStatsBase stats;
    
    stats = SRStatsBase(KFStatsAndAchievements);
    if( stats !=None && stats.Rep!=None )
        stats.Rep.ProgressCustomValue(Class'SnMod.Progress_Damage_Gunslinger',Amount);
}

defaultproperties
{
	HeadShotDamageMult=1.0
    WeaponClass=Class'SnMod.Magnum44Pistol'
    DeathString="%k killed %o (44 Magnum)."
    FemaleSuicide="%o shot herself in the foot."
    MaleSuicide="%o shot himself in the foot."
    bBulletHit=True
    FlashFog=(X=600.000000)
    //KDamageImpulse=9500.000000
    VehicleDamageScaling=0.800000
    bIsPowerWeapon=false
    bSniperWeapon=true // Used to track Sharpshooter Headshot Kills

	// Make this bullet move the ragdoll when its shot
	bRagdollBullet=true
	KDamageImpulse=3500
	KDeathVel=175.000000
	KDeathUpKick=15
}
