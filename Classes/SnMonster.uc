class SnMonster extends KFMod.KFMonster;

simulated function PostBeginPlay()
{
	local float RandomGroundSpeedScale;
	local float MovementSpeedDifficultyScale;
	local vector AttachPos;

	if(ROLE==ROLE_Authority)
	{
		if ( (ControllerClass != None) && (Controller == None) )
			Controller = spawn(ControllerClass);

		if ( Controller != None )
			Controller.Possess(self);

		SplashTime = 0;
		SpawnTime = Level.TimeSeconds;
		EyeHeight = BaseEyeHeight;
		OldRotYaw = Rotation.Yaw;
		if( HealthModifer!=0 )
			Health = HealthModifer;

		if ( bUseExtendedCollision && MyExtCollision == none )
		{
			MyExtCollision = Spawn(class 'ExtendedZCollision',self);
			MyExtCollision.SetCollisionSize(ColRadius,ColHeight);

			MyExtCollision.bHardAttach = true;
			AttachPos = Location + (ColOffset >> Rotation);
			MyExtCollision.SetLocation( AttachPos );
			MyExtCollision.SetPhysics( PHYS_None );
			MyExtCollision.SetBase( self );
			SavedExtCollision = MyExtCollision.bCollideActors;
		}

	}


	AssignInitialPose();
	// Let's randomly alter the position of our zombies' spines, to give their animations
	// the appearance of being somewhat unique.
	SetTimer(1.0, false);

	//Set Karma Ragdoll skeleton for this character.
	if (KFRagdollName != "")
		RagdollOverride = KFRagdollName; //ClotKarma
	//Log("Ragdoll Skeleton name is :"$RagdollOverride);

	if (bActorShadows && bPlayerShadows && (Level.NetMode != NM_DedicatedServer))
	{
		// decide which type of shadow to spawn
		if (!bRealtimeShadows)
		{
			PlayerShadow = Spawn(class'ShadowProjector',Self,'',Location);
			PlayerShadow.ShadowActor = self;
			PlayerShadow.bBlobShadow = bBlobShadow;
			PlayerShadow.LightDirection = Normal(vect(1,1,3));
			PlayerShadow.LightDistance = 320;
			PlayerShadow.MaxTraceDistance = 350;
			PlayerShadow.InitShadow();
		}
		else
		{
			RealtimeShadow = Spawn(class'Effect_ShadowController',self,'',Location);
			RealtimeShadow.Instigator = self;
			RealtimeShadow.Initialize();
		}
	}

	bSTUNNED = false;
	DECAP = false;

	// Difficulty Scaling
	if (Level.Game != none && !bDiffAdjusted)
	{
		//log(self$" Beginning ground speed "$default.GroundSpeed);

		if( Level.Game.NumPlayers <= 3 )
		{
			HiddenGroundSpeed = default.HiddenGroundSpeed;
		}
		else if( Level.Game.NumPlayers <= 5 )
		{
			HiddenGroundSpeed = default.HiddenGroundSpeed * 1.3;
		}
		else if( Level.Game.NumPlayers >= 6 )
		{
			HiddenGroundSpeed = default.HiddenGroundSpeed * 1.65;
		}

		// Some randomization to their walk speeds.
		RandomGroundSpeedScale = 1.0 + ((1.0 - (FRand() * 2.0)) * 0.1); // +/- 10%
		SetGroundSpeed(default.GroundSpeed * RandomGroundSpeedScale);
		//log(self$" Randomized ground speed "$GroundSpeed$" RandomGroundSpeedScale "$RandomGroundSpeedScale);

		if( Level.Game.GameDifficulty < 2.0 )
		{
			MovementSpeedDifficultyScale = 0.95;
		}
		else if( Level.Game.GameDifficulty < 4.0 )
		{
			MovementSpeedDifficultyScale = 1.0;
		}
		else if( Level.Game.GameDifficulty < 5.0 )
		{
			MovementSpeedDifficultyScale = 1.15;
		}
		else if( Level.Game.GameDifficulty < 7.0 )
		{
			MovementSpeedDifficultyScale = 1.3;//1.22;
		}
		else // Hardest difficulty
		{
			MovementSpeedDifficultyScale = 1.45;//1.3;
		}

		GroundSpeed *= MovementSpeedDifficultyScale;
		AirSpeed *= MovementSpeedDifficultyScale;
		WaterSpeed *= MovementSpeedDifficultyScale;
		// Store the difficulty adjusted ground speed to restore if we change it elsewhere
		OriginalGroundSpeed = GroundSpeed;

		//log(self$" Scaled ground speed "$GroundSpeed$" Difficulty "$Level.Game.GameDifficulty$" MovementSpeedDifficultyScale "$MovementSpeedDifficultyScale);

		// Scale health by difficulty
		Health *= DifficultyHealthModifer();
		HealthMax *= DifficultyHealthModifer();
		HeadHealth *= DifficultyHeadHealthModifer();

		// Scale health by number of players
		Health *= NumPlayersHealthModifer();
		HealthMax *= NumPlayersHealthModifer();
		HeadHealth *= NumPlayersHeadHealthModifer();

		MeleeDamage = Max((DifficultyDamageModifer() * MeleeDamage),1);

		SpinDamConst = Max((DifficultyDamageModifer() * SpinDamConst),1);
		SpinDamRand = Max((DifficultyDamageModifer() * SpinDamRand),1);

		ScreamDamage = Max((DifficultyDamageModifer() * ScreamDamage),1);

		bDiffAdjusted = true;
	}

	if( Level.NetMode!=NM_DedicatedServer )
	{
		AdditionalWalkAnims[AdditionalWalkAnims.length] = default.MovementAnims[0];
		MovementAnims[0] = AdditionalWalkAnims[Rand(AdditionalWalkAnims.length)];
	}
}

function TakeDamage(int Damage, Pawn instigatedBy, Vector hitlocation, Vector momentum, class<DamageType> damageType, optional int HitIndex )
{
	local bool bIsHeadshot;
	local KFPlayerReplicationInfo KFPRI;
	local float HeadShotCheckScale;

	LastDamagedBy = instigatedBy;
	LastDamagedByType = damageType;
	HitMomentum = VSize(momentum);
	LastHitLocation = hitlocation;
	LastMomentum = momentum;

	if ( KFPawn(instigatedBy) != none && instigatedBy.PlayerReplicationInfo != none )
	{
		KFPRI = KFPlayerReplicationInfo(instigatedBy.PlayerReplicationInfo);
	}

	// Scale damage if the Zed has been zapped
    if( bZapped )
    {
        Damage *= ZappedDamageMod;
    }

	// Zeds and fire dont mix.
	if ( class<KFWeaponDamageType>(damageType) != none && class<KFWeaponDamageType>(damageType).default.bDealBurningDamage )
    {
        if( BurnDown<=0 || Damage > LastBurnDamage )
        {
			 // LastBurnDamage variable is storing last burn damage (unperked) received,
			// which will be used to make additional damage per every burn tick (second).
			LastBurnDamage = Damage;

			// FireDamageClass variable stores damage type, which started zed's burning
			// and will be passed to this function again every next burn tick (as damageType argument)
			if ( class<DamTypeTrenchgun>(damageType) != none ||
				 class<DamTypeFlareRevolver>(damageType) != none ||
				 class<DamTypeMAC10MPInc>(damageType) != none)
			{
				 FireDamageClass = damageType;
			}
			else
			{
				FireDamageClass = class'DamTypeFlamethrower';
			}
        }

		if ( class<DamTypeMAC10MPInc>(damageType) == none )
        {
            Damage *= 1.0;
        }

        // BurnDown variable indicates how many ticks are remaining for zed to burn.
        // It is 0, when zed isn't burning (or stopped burning).
        // So all the code below will be executed only, if zed isn't already burning
        if( BurnDown<=0 )
        {
            if( HeatAmount>4 || Damage >= 15 )
            {
                bBurnified = true;
                BurnDown = 10; // Inits burn tick count to 10
                SetGroundSpeed(GroundSpeed *= 0.80); // Lowers movement speed by 20%
                BurnInstigator = instigatedBy;
                SetTimer(1.0,false); // Sets timer function to be executed each second
            }
            else HeatAmount++;
        }
    }

	if ( !bDecapitated && class<KFWeaponDamageType>(damageType)!=none &&
		class<KFWeaponDamageType>(damageType).default.bCheckForHeadShots )
	{
		HeadShotCheckScale = 1.0;

		// Do larger headshot checks if it is a melee attach
		if( class<DamTypeMelee>(damageType) != none )
		{
			HeadShotCheckScale *= 1.25;
		}

		bIsHeadShot = IsHeadShot(hitlocation, normal(momentum), HeadShotCheckScale);
		bLaserSightedEBRM14Headshotted = bIsHeadshot && M14EBRBattleRifle(instigatedBy.Weapon) != none && M14EBRBattleRifle(instigatedBy.Weapon).bLaserActive;
	}
	else
	{
		bLaserSightedEBRM14Headshotted = bLaserSightedEBRM14Headshotted && bDecapitated;
	}

	if ( KFPRI != none  )
	{
		if ( KFPRI.ClientVeteranSkill != none )
		{
			Damage = KFPRI.ClientVeteranSkill.Static.AddDamage(KFPRI, self, KFPawn(instigatedBy), Damage, DamageType);
		}
	}

	if ( damageType != none && LastDamagedBy.IsPlayerPawn() && LastDamagedBy.Controller != none )
	{
		if ( KFMonsterController(Controller) != none )
		{
			KFMonsterController(Controller).AddKillAssistant(LastDamagedBy.Controller, FMin(Health, Damage));
		}
	}

	if ( (bDecapitated || bIsHeadShot) && class<DamTypeBurned>(DamageType) == none && class<DamTypeFlamethrower>(DamageType) == none )
	{
		if(class<KFWeaponDamageType>(damageType)!=none)
			Damage = Damage * class<KFWeaponDamageType>(damageType).default.HeadShotDamageMult;

		if ( class<DamTypeMelee>(damageType) == none && KFPRI != none &&
			 KFPRI.ClientVeteranSkill != none )
		{
            Damage = float(Damage) * KFPRI.ClientVeteranSkill.Static.GetHeadShotDamMulti(KFPRI, KFPawn(instigatedBy), DamageType);
		}

		LastDamageAmount = Damage;

		if( !bDecapitated )
		{
			if( bIsHeadShot )
			{
			    // Play a sound when someone gets a headshot TODO: Put in the real sound here
			    if( bIsHeadShot )
			    {
					PlaySound(sound'KF_EnemyGlobalSndTwo.Impact_Skull', SLOT_None,2.0,true,500);
				}
				HeadHealth -= LastDamageAmount;
				if( HeadHealth <= 0 || Damage > Health )
				{
				   RemoveHead();
				}
			}

			// Award headshot here, not when zombie died.
			if( bDecapitated && Class<KFWeaponDamageType>(damageType) != none && instigatedBy != none && KFPlayerController(instigatedBy.Controller) != none )
			{
				bLaserSightedEBRM14Headshotted = M14EBRBattleRifle(instigatedBy.Weapon) != none && M14EBRBattleRifle(instigatedBy.Weapon).bLaserActive;
				Class<KFWeaponDamageType>(damageType).Static.ScoredHeadshot(KFSteamStatsAndAchievements(PlayerController(instigatedBy.Controller).SteamStatsAndAchievements), self.Class, bLaserSightedEBRM14Headshotted);
			}
		}
	}

	// Client check for Gore FX
	//BodyPartRemoval(Damage,instigatedBy,hitlocation,momentum,damageType);

	if( Health-Damage > 0 && DamageType!=class'DamTypeFrag' && DamageType!=class'DamTypePipeBomb'
		&& DamageType!=class'DamTypeM79Grenade' && DamageType!=class'DamTypeM32Grenade'
        && DamageType!=class'DamTypeM203Grenade' && DamageType!=class'DamTypeDwarfAxe'
        && DamageType!=class'DamTypeSPGrenade' && DamageType!=class'DamTypeSealSquealExplosion'
        && DamageType!=class'DamTypeSeekerSixRocket')
	{
		Momentum = vect(0,0,0);
	}

	if(class<DamTypeVomit>(DamageType)!=none) // Same rules apply to zombies as players.
	{
		BileCount=7;
		BileInstigator = instigatedBy;
		LastBileDamagedByType=class<DamTypeVomit>(DamageType);
		if(NextBileTime< Level.TimeSeconds )
			NextBileTime = Level.TimeSeconds+BileFrequency;
	}

	if ( KFPRI != none && Health-Damage <= 0 && KFPRI.ClientVeteranSkill != none && KFPRI.ClientVeteranSkill.static.KilledShouldExplode(KFPRI, KFPawn(instigatedBy)) )
	{
		Super.takeDamage(Damage + 600, instigatedBy, hitLocation, momentum, damageType);
		HurtRadius(500, 1000, class'DamTypeFrag', 100000, Location);
	}
	else
	{
		Super.takeDamage(Damage, instigatedBy, hitLocation, momentum, damageType);
	}

	if( bIsHeadShot && Health <= 0 )
	{
	   KFGameType(Level.Game).DramaticEvent(0.03);
	}

	bBackstabbed = false;
}

defaultproperties
{
}
