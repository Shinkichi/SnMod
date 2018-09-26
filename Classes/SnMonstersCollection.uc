class SnMonstersCollection extends KFMonstersCollection;

defaultproperties
{
	MonsterClasses(0)=(MClassName="SnChar.ZombieClot_STANDARD",MID="A")
	MonsterClasses(1)=(MClassName="SnChar.ZombieCrawler_STANDARD",MID="B")
	MonsterClasses(2)=(MClassName="SnChar.ZombieGoreFast_STANDARD",MID="C")
	MonsterClasses(3)=(MClassName="SnChar.ZombieStalker_STANDARD",MID="D")
	MonsterClasses(4)=(MClassName="SnChar.ZombieScrake_STANDARD",MID="E")
	MonsterClasses(5)=(MClassName="SnChar.ZombieFleshpound_STANDARD",MID="F")
	MonsterClasses(6)=(MClassName="SnChar.ZombieBloat_STANDARD",MID="G")
	MonsterClasses(7)=(MClassName="SnChar.ZombieSiren_STANDARD",MID="H")
	MonsterClasses(8)=(MClassName="SnChar.ZombieHusk_STANDARD",MID="I")

	StandardMonsterClasses(0)=(MClassName="SnChar.ZombieClot_STANDARD",MID="A")
	StandardMonsterClasses(1)=(MClassName="SnChar.ZombieCrawler_STANDARD",MID="B")
	StandardMonsterClasses(2)=(MClassName="SnChar.ZombieGoreFast_STANDARD",MID="C")
	StandardMonsterClasses(3)=(MClassName="SnChar.ZombieStalker_STANDARD",MID="D")
	StandardMonsterClasses(4)=(MClassName="SnChar.ZombieScrake_STANDARD",MID="E")
	StandardMonsterClasses(5)=(MClassName="SnChar.ZombieFleshpound_STANDARD",MID="F")
	StandardMonsterClasses(6)=(MClassName="SnChar.ZombieBloat_STANDARD",MID="G")
	StandardMonsterClasses(7)=(MClassName="SnChar.ZombieSiren_STANDARD",MID="H")
	StandardMonsterClasses(8)=(MClassName="SnChar.ZombieHusk_STANDARD",MID="I")


    FinalSquads(0)=(ZedClass=("SnChar.ZombieClot_STANDARD"),NumZeds=(4))
    FinalSquads(1)=(ZedClass=("SnChar.ZombieClot_STANDARD","SnChar.ZombieCrawler_STANDARD"),NumZeds=(3,1))
    FinalSquads(2)=(ZedClass=("SnChar.ZombieClot_STANDARD","SnChar.ZombieStalker_STANDARD","SnChar.ZombieCrawler_STANDARD"),NumZeds=(3,1,1))

	ShortSpecialSquads(2)=(ZedClass=("SnChar.ZombieCrawler_STANDARD","SnChar.ZombieGorefast_STANDARD","SnChar.ZombieStalker_STANDARD","SnChar.ZombieScrake_STANDARD"),NumZeds=(2,2,1,1))
	ShortSpecialSquads(3)=(ZedClass=("SnChar.ZombieBloat_STANDARD","SnChar.ZombieSiren_STANDARD","SnChar.ZombieFleshPound_STANDARD"),NumZeds=(1,2,1))

	NormalSpecialSquads(3)=(ZedClass=("SnChar.ZombieCrawler_STANDARD","SnChar.ZombieGorefast_STANDARD","SnChar.ZombieStalker_STANDARD","SnChar.ZombieScrake_STANDARD"),NumZeds=(2,2,1,1))
	NormalSpecialSquads(4)=(ZedClass=("SnChar.ZombieFleshPound_STANDARD"),NumZeds=(1))
	NormalSpecialSquads(5)=(ZedClass=("SnChar.ZombieBloat_STANDARD","SnChar.ZombieSiren_STANDARD","SnChar.ZombieFleshPound_STANDARD"),NumZeds=(1,1,1))
	NormalSpecialSquads(6)=(ZedClass=("SnChar.ZombieBloat_STANDARD","SnChar.ZombieSiren_STANDARD","SnChar.ZombieFleshPound_STANDARD"),NumZeds=(1,1,2))

	LongSpecialSquads(4)=(ZedClass=("SnChar.ZombieCrawler_STANDARD","SnChar.ZombieGorefast_STANDARD","SnChar.ZombieStalker_STANDARD","SnChar.ZombieScrake_STANDARD"),NumZeds=(2,2,1,1))
	LongSpecialSquads(6)=(ZedClass=("SnChar.ZombieFleshPound_STANDARD"),NumZeds=(1))
	LongSpecialSquads(7)=(ZedClass=("SnChar.ZombieBloat_STANDARD","SnChar.ZombieSiren_STANDARD","SnChar.ZombieFleshPound_STANDARD"),NumZeds=(1,1,1))
	LongSpecialSquads(8)=(ZedClass=("SnChar.ZombieBloat_STANDARD","SnChar.ZombieSiren_STANDARD","SnChar.ZombieScrake_STANDARD","SnChar.ZombieFleshPound_STANDARD"),NumZeds=(1,2,1,1))
    LongSpecialSquads(9)=(ZedClass=("SnChar.ZombieBloat_STANDARD","SnChar.ZombieSiren_STANDARD","SnChar.ZombieScrake_STANDARD","SnChar.ZombieFleshPound_STANDARD"),NumZeds=(1,2,1,2))

    FallbackMonsterClass="SnChar.ZombieStalker_STANDARD"
    EndGameBossClass="SnChar.ZombieBoss_STANDARD"
}
