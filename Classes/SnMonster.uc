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

defaultproperties
{
}
