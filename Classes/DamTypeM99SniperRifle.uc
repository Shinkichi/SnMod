
class DamTypeM99SniperRifle extends KFMod.KFProjectileWeaponDamageType;

static function AwardKill(KFSteamStatsAndAchievements KFStatsAndAchievements, KFPlayerController Killer, KFMonster Killed )
{
	if ( KFStatsAndAchievements != none )
	{
		if ( Killed.IsA('ZombieScrake'))
		{
			KFStatsAndAchievements.AddM99Kill();
		}
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

defaultproperties
{
    WeaponClass=Class'SnMod.M99SniperRifle'
    DeathString="%k put a bullet in %o's head."
    FemaleSuicide="%o shot herself in the head."
    MaleSuicide="%o shot himself in the head."

    HeadShotDamageMult=1.25
    bKUseOwnDeathVel=True
    bThrowRagdoll=True
    bFlaming=False
    DamageThreshold=1
    KDamageImpulse=10000.000000
    bSniperWeapon=True

    // Make this bullet move the ragdoll when its shot
    bRagdollBullet=True
    KDeathVel=300.000000
    KDeathUpKick=100.000000
}
