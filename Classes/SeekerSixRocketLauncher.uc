class SeekerSixRocketLauncher extends KFMod.SeekerSixRocketLauncher;

function Projectile SpawnProjectile(Vector Start, Rotator Dir)
{
    local SeekerSixRocketProjectile Rocket;
    local SeekerSixSeekingRocketProjectile SeekingRocket;

    bBreakLock = true;

    if (bLockedOn && SeekTarget != None)
    {
        SeekingRocket = Spawn(class'SnMod.SeekerSixSeekingRocketProjectile',,, Start, Dir);
        SeekingRocket.Seeking = SeekTarget;
        return SeekingRocket;
    }
    else
    {
        Rocket = Spawn(class'SnMod.SeekerSixRocketProjectile',,, Start, Dir);
        return Rocket;
    }
}

defaultproperties
{
    Weight=7.000000
    FireModeClass(0)=Class'SnMod.SeekerSixFire'
    FireModeClass(1)=Class'SnMod.SeekerSixMultiFire'
    //FireModeClass(1)=Class'KFMod.NoFire'
    PickupClass=Class'SnMod.SeekerSixPickup'
    ItemName="SeekerSix Rocket Launcher SN"


    AppID=0//258751
}
