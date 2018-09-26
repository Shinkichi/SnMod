class DamTypeFlamethrower extends KFMod.KFWeaponDamageType
	abstract;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount)
{
	KFStatsAndAchievements.AddFlameThrowerDamage(Amount);
}

defaultproperties
{
	HeadShotDamageMult=1.0
    WeaponClass=Class'SnMod.Flamethrower'
    DeathString="%k incinerated %o (Flamethrower)."
    FemaleSuicide="%o roasted herself alive."
    MaleSuicide="%o roasted himself alive."
    bCheckForHeadShots=false
    bDealBurningDamage=true
}
