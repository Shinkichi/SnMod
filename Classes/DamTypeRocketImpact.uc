class DamTypeRocketImpact extends KFMod.DamTypeKFSnipe
	abstract;

defaultproperties
{
    HeadShotDamageMult=1.5
    WeaponClass=Class'SnMod.Law'
    DeathString="%k killed %o (LAW Impact)."
    FemaleSuicide="%o shot herself in the foot."
    MaleSuicide="%o shot himself in the foot."

    KDeathVel=200.000000
    KDamageImpulse=5000
	KDeathUpKick=50
}
