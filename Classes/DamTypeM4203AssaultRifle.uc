class DamTypeM4203AssaultRifle extends KFMod.KFProjectileWeaponDamageType
	abstract;

defaultproperties
{
	HeadShotDamageMult=1.25
    WeaponClass=Class'SnMod.M4203AssaultRifle'
    DeathString="%k killed %o (M4 203)."
    FemaleSuicide="%o shot herself in the foot."
    MaleSuicide="%o shot himself in the foot."

	// Make this bullet move the ragdoll when its shot
	bRagdollBullet=true
    KDeathVel=110.000000
    KDamageImpulse=1500
    KDeathUpKick=2
}
