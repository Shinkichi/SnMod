class SealSquealProjectile extends KFMod.SealSquealProjectile;

defaultproperties
{
    Speed=3000.000000
    MaxSpeed=3000.000000
    Damage=275//350
    DamageRadius=400
    MyDamageType=Class'SnMod.DamTypeSealSquealExplosion'
    ImpactSound=Sound'KF_FY_SealSquealSND.WEP_Harpoon_Hit_Wall'
    ImpactPawnSound=Sound'KF_FY_SealSquealSND.WEP_Harpoon_Hit_Flesh'
    ImpactDamageType=Class'SnMod.DamTypeRocketImpact'
    ImpactDamage=150//200
    AmbientSound=Sound'KF_IJC_HalloweenSnd.KF_FlarePistol_Projectile_Loop'
    StaticMesh=StaticMesh'KF_IJC_Halloween_Weps2.Harpoon_Projectile'
    ExplosionSound=Sound'KF_FY_SealSquealSND.WEP_Harpoon_Explode'
    DisintegrateSound=Sound'Inf_Weapons.faust_explode_distant02'
}
