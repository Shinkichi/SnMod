class HuskGunProjectile extends KFMod.HuskGunProjectile;

defaultproperties
{
    Speed=1800.000000
    MaxSpeed=2200.000000
    Damage=25
    DamageRadius=150.0
    ArmDistSquared=0
    StaticMesh=StaticMesh'EffectsSM.Ger_Tracer'
    ImpactDamage=100
    ImpactDamageType=class'SnMod.DamTypeHuskGunProjectileImpact'
    HeadShotDamageMult=1.0//1.5

    MyDamageType=class'SnMod.DamTypeHuskGun'
    ExplosionSound=Sound'KF_EnemiesFinalSnd.Husk.Husk_FireImpact'
    AmbientSound=Sound'KF_BaseHusk.husk_fireball_loop'
}
