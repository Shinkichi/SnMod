class FlareRevolverProjectile extends KFMod.FlareRevolverProjectile;


defaultproperties
{
    Speed=1500.000000
    MaxSpeed=1700.000000
    Damage=25.000000
    DamageRadius=100.000000
    StaticMesh=StaticMesh'EffectsSM.Ger_Tracer'
    ImpactDamage=80//100
    ImpactDamageType=Class'SnMod.DamTypeFlareProjectileImpact'
    HeadShotDamageMult=1.000000//1.500000

    MyDamageType=Class'SnMod.DamTypeFlareRevolver'
    ExplosionSound=Sound'KF_IJC_HalloweenSnd.KF_FlarePistol_Projectile_Hit'
    AmbientSound=Sound'KF_IJC_HalloweenSnd.KF_FlarePistol_Projectile_Loop'
}
