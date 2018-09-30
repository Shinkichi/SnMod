class Trenchgun extends KFMod.Trenchgun;

simulated function AddReloadedAmmo()
{
	local KFPlayerReplicationInfo KFPRI;
	KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);

    if(AmmoAmount(0) > 0)
        ++MagAmmoRemaining;

	if (KFPRI.ClientVeteranSkill.default.PerkIndex==5 )
	{
		if(MagAmmoRemaining < 12 )
		{
			if( AmmoAmount(0) > 0 )
			{
				++MagAmmoRemaining;
			}
		}
	}

    // Don't do this on a "Hold to reload" weapon, as it can update too quick actually and cause issues maybe - Ramm
    if( !bHoldToReload )
    {
        ClientForceKFAmmoUpdate(MagAmmoRemaining,AmmoAmount(0));
    }

	if ( PlayerController(Instigator.Controller) != none && KFSteamStatsAndAchievements(PlayerController(Instigator.Controller).SteamStatsAndAchievements) != none )
	{
		KFSteamStatsAndAchievements(PlayerController(Instigator.Controller).SteamStatsAndAchievements).OnWeaponReloaded();
	}
}

defaultproperties
{
    MagCapacity=6
    Weight=6.000000//8.000000
    FireModeClass(0)=Class'SnMod.TrenchgunFire'
    PickupClass=Class'SnMod.TrenchgunPickup'
    ItemName="Dragon's Breath Trenchgun SN"
}
