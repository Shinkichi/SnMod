class DamTypeDual44Magnum extends KFMod.DamTypeMagnum44Pistol
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
	WeaponClass=Class'SnMod.Dual44Magnum'
	DeathString="ÿ%k killed %o (Dual 44 Magnum)."
}
