
class DamTypeMP5M extends KFMod.KFProjectileWeaponDamageType
	abstract;

defaultproperties
{
	HeadShotDamageMult=1.0
    WeaponClass=Class'SnMod.MP5MMedicGun'
    DeathString="%k killed %o (MP5M)."
    FemaleSuicide="%o shot herself in the foot."
    MaleSuicide="%o shot himself in the foot."

	// Make this bullet move the ragdoll when its shot
	bRagdollBullet=true
    KDeathVel=100.000000
    KDamageImpulse=750
    KDeathUpKick=1
}
