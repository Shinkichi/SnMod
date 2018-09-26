class SRVetBaseClass extends SRVeterancyTypes
	abstract;

// Display enemy health bars
static function SpecialHUDInfo(KFPlayerReplicationInfo KFPRI, Canvas C)
{
	local KFMonster KFEnemy;
	local HUDKillingFloor HKF;
	local float MaxDistanceSquared;

	if ( KFPRI.ClientVeteranSkillLevel > 0 )
	{
		HKF = HUDKillingFloor(C.ViewPort.Actor.myHUD);

		if ( HKF == none || C.ViewPort.Actor.Pawn == none )
		{
			return;
		}

		MaxDistanceSquared = 800000; // 20 ?

		foreach C.ViewPort.Actor.DynamicActors(class'KFMonster',KFEnemy)
		{
			if ( KFEnemy.Health > 0 && !KFEnemy.Cloaked() && VSizeSquared(KFEnemy.Location - C.ViewPort.Actor.Pawn.Location) < MaxDistanceSquared )
			{
				HKF.DrawHealthBar(C, KFEnemy, KFEnemy.Health, KFEnemy.HealthMax , 50.0);
			}
		}
	}
}

defaultproperties
{
	OnHUDIcon=none
	OnHUDGoldIcon=none
	VeterancyName="SnMod Base Class"
}