class DamTypeCrossbowHeadShot extends SnMod.DamTypeCrossbow
	abstract;

defaultproperties
{
    WeaponClass=Class'SnMod.Crossbow'

    DeathString="%k put an arrow %o's head."
    FemaleSuicide="%o shot herself in the head."
    MaleSuicide="%o shot himself in the head."

    bBulletHit=True
    FlashFog=(X=600.000000)
    KDamageImpulse=3000.000000
    VehicleDamageScaling=0.700000

    KDeathVel=115.000000
    KDeathUpKick=10
}
