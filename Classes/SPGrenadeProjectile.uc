class SPGrenadeProjectile extends KFMod.SPGrenadeProjectile;

defaultproperties
{
    ArmDistSquared=90000 // 6 meters
    Speed=1000
    MaxSpeed=1500
    Damage=225//325
    DamageRadius=350
    MyDamageType=Class'SnMod.DamTypeSPGrenade'
    StaticMesh=StaticMesh'KF_IJC_Summer_Weps.SPGrenade_proj'
    ExplosionSound=Sound'KF_GrenadeSnd.Nade_Explode_1'
    DisintegrateSound=Sound'Inf_Weapons.faust_explode_distant02'
    ImpactDamageType=Class'SnMod.DamTypeSPGrenadeImpact'
    ImpactDamage=150//200
    ImpactSound=Sound'KF_GrenadeSnd.Nade_HitSurf'
    AmbientSound=Sound'KF_IJC_HalloweenSnd.KF_FlarePistol_Projectile_Loop'
}
