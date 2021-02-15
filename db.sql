-- MariaDB dump 10.18  Distrib 10.4.17-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: jspCommunity
-- ------------------------------------------------------
-- Server version	10.4.17-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `jspCommunity`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `jspCommunity` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `jspCommunity`;

--
-- Table structure for table `article`
--

DROP TABLE IF EXISTS `article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `article` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `memberId` int(10) unsigned NOT NULL,
  `boardId` int(10) unsigned NOT NULL,
  `title` char(100) NOT NULL,
  `body` longtext NOT NULL,
  `hitCount` int(10) unsigned NOT NULL DEFAULT 0,
  `replyCount` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article`
--

LOCK TABLES `article` WRITE;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` VALUES (1,'2021-01-30 15:52:56','2021-01-30 15:56:31',1,3,'2월 4일 출시 신작 - 웨어울프: 디 아포칼립스 - 어스블러드 (Werewolf: The Apocalypse - Earthblood)','▶ 2/4 웨어울프: 디 아포칼립스 - 어스블러드 (Werewolf: The Apocalypse - Earthblood)\r\nPC / PS4, 5 / XBO, XSX',9,0),(2,'2021-01-30 15:56:22','2021-01-30 15:56:22',1,3,'2월 4일 출시 신작 - 버디크러시 (Birdie Crush)','▶ 2/4 버디크러시 (Birdie Crush)\r\niOS / And',1,0),(3,'2021-01-30 15:56:48','2021-01-30 15:59:31',1,3,'2월 5일 출시 신작 - 인왕 2 - 컴플리트 에디션 (Nioh 2 - The Complete Edition)','▶ 2/5 인왕 2 - 컴플리트 에디션 (Nioh 2 – The Complete Edition)\r\n스팀 / PS5 (2/4)',7,0),(4,'2021-01-30 15:57:05','2021-01-30 15:57:05',1,3,'2월 10일 출시 신작 - 리틀 나이트메어 2 (Little Nightmares II)','▶ 2/10 리틀 나이트메어 2 (Little Nightmares II)\r\n스팀 / PS4 / XBO / NSW',3,0),(5,'2021-01-30 15:57:22','2021-01-30 15:57:22',1,3,'2월 10일 출시 신작 - 몽키 배럴 (Monkey Barrels)','▶ 2/10 몽키 배럴 (Monkey Barrels)\r\n에픽 / NSW 선출시',3,0),(6,'2021-01-30 15:57:40','2021-01-30 15:57:40',1,3,'2월 11일 출시 신작 - 더 룸 4: 오래된 죄 (The Room 4: Old Sins)','▶ 2/11 더 룸 4: 오래된 죄 (The Room 4: Old Sins)\r\n스팀',3,0),(7,'2021-01-30 15:57:54','2021-01-30 15:57:54',1,3,'2월 12일 출시 신작 - 슈퍼 마리오 3D 월드 + 퓨리 월드 (Super Mario 3D World + Bowser\'s Fury)','▶ 2/12 슈퍼 마리오 3D 월드 + 퓨리 월드 (Super Mario 3D World + Bowser\'s Fury)\r\nNSW',17,1),(8,'2021-01-30 16:02:43','2021-01-30 16:03:54',1,4,'인투 더 브리치 팁!','1. 연막 캔슬\r\n연막캔슬\r\n뒤에 생기게 되는 연막을 활용해서 뒤에 있는 벡의 공격을 취소시킴과 동시에 전방에 목표한 다른 적을 밀치거나 죽일 수 있다.\r\n굳이 전방에 목표 대상이 없다고 하더라도 공격을 하면 뒤에 연막이 생긴다는 것을 활용해서 뒤의 적을 무력화시킬 수 있다.\r\n\r\n2. 후진 타격\r\n공격 시에 뒤로 한칸 이동하게 되는 무기들을 활용하여 바로 뒤에 있는 체력이 1남은 적[21]을 충돌피해 1데미지를 교환해서 처리함과 동시에 앞에 있는 적을 처치하는 테크닉이다. 배치를 잘해서 거미나 거품벌레(블롭퍼)의 공격위치를 잘 유도한다면 이 기술을 활용해서 본체와 소환물을 한번에 처리하는 것도 가능하다.\r\n해당하는 무기는 프라임 클래스의 Rocket Fist\\, 브루트 클래스의 Unstable Cannon이 있다.\r\n또한 레인지 무기의 Rocket Artillery(+Storm Generator),Vulkan Artillery(Backburn 업그레이드시)도 각각 전기, 화염 피해를 통해서 뒤에 있는 체력이 1남은 적을 처리하는데 사용할 수 있다.',15,0),(10,'2021-01-30 16:10:22','2021-01-30 16:15:28',1,4,'하데스(Hades) 무기 정보','스티기우스, 명계의 검 (Stygius, the Blade of the Underworld) - 제일 처음 해금되는 무기이다. 일반 공격은 베기 이후 찌르기 공격을 가한다. 대쉬 공격은 좁은 범위를 찌른다. 특수 공격은 땅을 내려찍어 주변 원형에 범위 충격파를 날린다.\r\n자그레우스 양상 - 공격 속도와 이동 속도를 늘린다. 게임에서 가장 먼저 사용하는 무기이다.\r\n네메시스 양상 - 특수 공격 사용 후 3초간 일반 공격의 치명타 확률을 늘린다. 이 치명타 역시 아르테미스의 보정을 받으므로 아르테미스를 일부나마 채용하는 것이 좋다.\r\n포세이돈 양상 - 혈석이 명중한 적에게 특수 공격시 혈석을 강제로 배출. 주로 마법 빌드에서 혈석의 사이클 속도를 높이기 위해 사용된다.\r\n아서 양상 - 공격 속도 크게 감소, 공격 범위와 공격력 크게 증가, 최대 체력 증가. 특수 공격시 충격파와 함께 적의 피해와 투사체 속도를 줄이고 함정을 봉인하는 성역이 생성된다. 일반적인 검과는 반대로 대검을 묵직하게 휘두른다는 느낌으로 변한다. 모티브대로 작중 인물들이 엑스칼리버라고 부르는 대사가 있다.\r\n\r\n바라타, 영원의 창 (Baratha, the Eternal Spear) - 찌르기와 대쉬 공격의 사거리가 길다. 일반 공격을 충전하면 360도 범위로 광역 공격을 가하는 회전 공격을 사용할 수 있다. 특수 공격으로 창을 직선으로 던진 후 되돌아오게 할 수 있다.\r\n자그레우스 양상 - 특수 공격의 공격력, 사거리, 이동 속도를 늘린다.\r\n아킬레우스 양상 - 특수 공격 후 창을 되돌아오게 하는 대신, 창이 있는 위치로 돌진한다.[50] 돌진 후 일반 공격과 마법의 공격력이 증가한다.\r\n하데스 양상 - 회전 공격 범위 증가. 회전 공격에 적중한 적이 일반 공격에 추가 피해를 입는다. 설정상 하데스는 이 창의 원래 주인이었다.\r\n관우 양상 - 공격 속도 크게 감소, 공격력 증가. 최대 체력 감소. 특수 공격이 단발성 범위 공격으로 바뀐다. 회전 공격이 전방으로 회전 투사체를 발사한다. 회전 투사체는 흡혈 속성이 있어서 적중하면 자그레우스의 체력이 회복된다.\r\n완전한 하이리스크 하이리턴형 무기. 강력한 공격력과 회전 투사체로 일반 적들은 쉬워지지만 보스전이 어려워진다. 아킬레우스를 통해 해금할수있다.\r\n\r\n아이기스, 카오스의 방패 (Aegis, the Shield of Chaos) - 일반 공격으로 넉백이 가능하다. 일반 공격을 충천하면 방어 태세에 돌입하여 전면의 공격과 투사체를 막을 수 있다. 충전을 풀면 긴 거리를 돌진한다. 특수 공격으로 방패를 던진 뒤 되돌아오게 한다. 방어 태세 덕분에 운영이 매우 안정적이다.\r\n자그레우스 양상 - 일반 공격력과 돌진 공격력 증가.\r\n카오스 양상 - 돌진 후 다음 특수 공격시 던지는 방패의 갯수가 증가한다. 1레벨 기준 2개이고 최대 5개까지 증가한다. 제우스 특수공격 조합은 앞서 해보기 시절부터 내려져온 전통적인 1티어 조합이다. 설정상 카오스는 이 방패의 원래 주인이었다.\r\n제우스 양상 - 특수 공격시 방패를 띄워 천천히 움직이게 하며 전면에 지속 피해를 가한다. 일정 거리 이후에는 멈춰서있으므로 이 곳에 적을 두고 공격과 중첩시키는 운용이 가능하다. 다시 특수 공격을 하면 방패가 자그레우스의 위치로 되돌아온다.\r\n베오울프 양상 - 평타, 대쉬 공격과 특수 공격의 공격 속도가 감소하는 대신 피해량이 증가하고, 마법 공격은 방패에 실려서 다음 돌진의 공격력과 범위를 강화하는 데 쓰인다. 마법은 기존의 투사체 형태 대신 착지 지점 주변으로 퍼지는 범위 공격으로 변한다. 페널티로 적으로부터 10%의 피해를 추가로 입는다. 착지 지점에서 캔슬 형식으로 마법을 시전할 수 있다. 카오스를 통해 해금할수있다.\r\n\r\n코로나크트, 심장을 노리는 활(Coronacht, the Heart-Seeking Bow) - 일반 공격으로 좁은 범위를 관통하는 투사체를 발사한다. 충전시 공격력과 사거리가 증가하고, 사거리가 최대일 때 특정 시점[51]에서 놓으면 추가 피해를 입힌다. 돌진 공격시 일반 공격의 공격력이 일부 감소하는 대신 충전 속도가 2배로 증가한다. 특수 공격으로 전방에 다수의 화살을 난사한다.\r\n자그레우스 양상 - 일반 공격시 치명타 확률 증가.\r\n케이론 양상 - 일반 공격이 명중한 적에게 특수 공격시 특수 공격 화살이 유도되어 명중한다. 일반 공격은 특수 공격을 유도하는 역할을 하므로 일반적으로 충전 공격을 없애는 망치 업그레이드와 조합하게 된다.\r\n헤라 양상 - 마법 시전시 일반 공격에 마법을 실을 수 있다. 설정상 헤라는 이 활의 원래 주인이었다.\r\n라마 양상 - 평타가 반월형의 범위공격으로 변한다. 특수공격은 주변으로 튀는 세발의 화살로 변하며, 이 화살에 맞은 적은 표식이 생겨 다른 적이 입는 피해의 일부를 함께 입는다. 직접 공격해도 추가 피해가 적용된다. 이 형상의 명칭은 샤랑가.[52] 아르테미스를 통해 해금할수있다.\r\n\r\n말폰, 쌍둥이 철권(Malphon, the Twin Fists) - 일반 공격으로 좁은 범위에 주먹으로 빠른 속도로 잽을 날린다. 돌진 공격으로는 공격력이 강한 훅을 날린다. 특수 공격은 어퍼컷으로, 발동이 느리지만 연타를 가하는 일반 어퍼컷과 발동이 빠른 단타형 돌진 어퍼컷을 쓸 수 있다.\r\n공격 속도가 빠르다는 점을 이용해서 디오니소스의 독을 빠르게 묻히거나, 아레스 공격 + 아테나 특공 + 아테나 돌진으로 자비로운 최후 듀오를 연속적으로 발동시켜서 DPS를 극대화할 수 있다.\r\n자그레우스 양상 - 공격 속도와 회피 확률 증가.\r\n탈로스 양상 - 특수 공격시 먼저 적을 끌어당김. 당겨진 적은 추가 피해를 입는다.\r\n데메테르 양상 - 공격 12회 적중 이후 특수 공격시 연타. 설정상 데메테르는 이 철권의 원래 주인이었다.\r\n길가메쉬 양상 - 공격 범위와 공격력 크게 증가. 돌진 횟수 증가. 공격 속도 감소. 특수공격 적중시 적에게 \'절단\'이라는 특수한 디버프를 부여한다. 절단당한 적은 일시적으로 공격력이 증가하지만 곧 아레스의 파멸효과처럼 큰 데미지를 입힌다.[53] 설정상 엔키두의 발톱달린 주먹이다. 아스테리오스를 통해 해금가능\r\n\r\n엑자그리프, 굳건한 레일건 (Exagryph, the Adamant Rail) - 그리스 신화에 뜬금없이 등장한 돌격소총. 일반 공격은 단일 대상을 타격하는 투사체를 빠른 속도로 발사하고, 탄창 장탄수 제한이 있어서 재장전을 해줘야 한다. 특수 공격은 포물선으로 유탄을 발사한다. 돌진 공격시 일반 공격을 추가로 빠르게 1회 발사한다.\r\n강화되지 않은 형태는 화력이 모든 무기 중에서 가장 빈약하므로, 축복과 다이달로스의 권능으로 강화시켜줘야 후반을 도모할 수 있다.\r\n자그레우스 양상 - 탄창 장탄수 증가.\r\n에리스 양상 - 특수 공격의 폭심지에 있을 경우 해당 유탄 및 이후 일반 공격과 특수 공격의 공격력 증가.\r\n헤스티아 양상 - 재장전 후 첫번째 공격이 강력한 광선 공격으로 변한다. 이 광선 공격은 공격력과 사거리가 늘어난다. 발사와 수동 재장전을 반복하므로 볼트액션 저격소총과 비슷한 느낌으로 사용하게 된다. 설정상 헤스티아는 이 소총의 원래 주인이었다.\r\n루시퍼 양상 - 일반 공격이 점점 피해량이 증폭되는 레이저 공격으로 변한다. 특수공격은 불덩어리를 쏘는 것으로 변경되며, 불덩어리는 주변에 지속적으로 피해와 경직을 주고 공격당하거나 4개가 중첩되면 폭발하며 큰 피해를 입힌다. 이 상태의 명칭은 이나우스 에덴. 제우스를 통해 해금가능',15,0),(11,'2021-01-30 16:16:44','2021-01-30 16:16:44',1,4,'킹덤 러쉬 플레이 팁','플레이 화면 인터페이스. 현재는 추가 맵이 6개 더 있다. 게임을 최초로 시작하면 진행하는 동안 기본적인 전략과 팁은 자동적으로 그때그때 알려준다.\r\n\r\n병사들로 길을 막은 뒤 포병으로 광역 공격, 궁병으로 마법 저항력 높은 적, 마법사로 방어력 높은 적을 잡는 것이 기본이다. 이 시리즈의 경우 마법사 타워 업그레이드 중 공격 시 방어력을 낮춰주는 특성을 찍은 후 마법사 타워를 전진 배치해 방어력을 낮추고 병영 타워로 길을 막은 후 포병 타워로 딜을 하고 궁수 타워로 나머지를 마무리 하는 것이 보편적이다. 마법 저항력이 높은 적이 상대적으로 적기 때문에 마법 타워의 중요성이 굉장히 높은 편이다.\r\n\r\n\r\n공격 유형에는 크게 3종류가 있으며, 각각 물리/마법/특수형의 대미지를 준다.\r\n\r\n\r\n아군 병사나 적들에게는 방어력과 저항력이 설정되어 있다. 방어력은 물리 대미지, 저항력은 마법 대미지를 일정 비율로 줄여주며, 특수 대미지의 경우 방어력과 저항력에 상관없이 항상 100% 대미지를 준다. 드워프 포탑의 광역 데미지, 독 등의 일부 타워들이 이러한 특수 대미지[5]를 입힌다.\r\nNone(없음) : 대미지 감소 없음\r\nLow(낮음) : 1-30% 대미지 감소\r\nMedium(보통) : 31-60% 대미지 감소\r\nHigh(높음) : 61-90% 대미지 감소\r\nGreat(매우 높음) : 91-100% 대미지 감소\r\n\r\n\r\n대비가 잘 갖춰져 있다면 적의 등장을 예고하는 해골 모양 원형을 클릭하여 적이 바로 나오게 할 수 있다. 이 경우 약간의 돈을 얻고 스펠 재사용 대기시간을 단축할 수 있다. 보다 일찍 나오게 할수록 더 많은 돈을 받고 스펠 쿨타임도 짧아진다. 하지만 돈 조금 더 얻겠다고 이전 웨이브의 병력을 어느정도 처리하지도 않은 상태에서 이 기능을 남발하다가는 되려 화력이 분산되어 적을 처리하기 더 힘들어질 수도 있으므로 주의해야한다.\r\n\r\n\r\n근접 공격형 적의 경우 병사 하나를 여럿이서 공격하지 않는다. 따라서 아군 병사들이 먼저 길막하지 않은 적들은 전투 중인 병사들을 그냥 무시하고 지나간다. 탱커+어그로 역할을 하는 병사들인데 그 수가 적으면 상대적으로 훨씬 많은 적들이 그냥 지나가버리기에 주의해야 한다. 원거리 공격형의 적들은 사정거리 내에 들어올 경우 무조건 공격하기 때문에 컨트롤 해주지 않을 경우 아군 병사들이 집중 공격받고 순삭당하는 것을 볼 수 있다. 따라서 원거리 공격형 적이 접근할 경우 메테오를 내려주거나 증원군을 바로 옆에 소환해서 원거리 공격을 봉쇄해주자. 정 안되면 병사들을 약간 후방으로 이동시켜서 유인한 뒤에 적 근처로 다시 이동시켜서 근접전을 유도하는 것도 효과적이다. 병사와 영웅은 이동명령에 의해 이동하는 동안에는 적에게 공격받지 않는다. 이를 응용해 병영 컨트롤을 해야하는 장면이 꽤 나올 수 있다.\r\n\r\n\r\n병사 계열 타워의 경우, 업그레이드하는 순간 죽은 병사가 바로 보충되고 남은 병사들의 체력이 꽉차게 된다. 바로 업그레이드하지 말고 아군 병사들이 전멸했을 때 해주면 약간의 이득을 볼 수 있다. 마법사가 소환하는 땅의 정령에도 일부 적용되는데, 죽은 경우 바로 보충되진 않지만 살아있는 경우 체력이 최대치로 회복되긴 한다. 조금 경우가 다르지만, Sunray타워의 경우도 타워에 소서러를 보충해주면 재사용 대기시간이 초기화된다. 따라서 한명 채워두고 발사한 뒤 바로 한명 더 채운 후 발사하는 식으로 4발을 순식간에 연사할 수 있다.\r\n\r\n\r\n다수의 적을 잡는 데에는 포병이 가장 좋지만 포병을 사용할 수 없는 경우에는 레인저의 Wrath of the Forest가 광역기로 쓸만하다. 궁병마저 사용할 수 없다면 마법사의 텔레포트가 나름 한번에 3~5마리씩 적용된다는 걸 이용해보자.\r\n\r\n\r\n초반에 병영을 짓기 보다는 증원군과 영웅으로 길막을 하며 초반에 주어진 돈으로 빠르게 고급 공격타워를 올려주는 것도 좋은 선택일 수 있다.\r\n\r\n\r\n단축키를 사용하면 좀 더 편하다.\r\n1 키 : Rain of Fire 사용\r\n2 키 : Call Reinforcements 사용\r\n3 키 : Lightning Bolt 사용\r\n4 키 : Sunray 발사\r\n` 키 : 영웅 선택\r\nspace 키 : 현재 선택한 기능 취소\r\np 키 : 일시정지\r\nw 키 : 적군 바로 부르기\r\nEsc : 옵션, 화면취소',17,0),(12,'2021-01-30 16:17:33','2021-01-30 16:17:33',1,4,'림월드 킬 존 만들기','초반부터 쓸 수 있는 가시 함정의 경우 상당히 강력한 피해를 주기 때문에 생각보다 유용한 도구이다. 장비가 좋지 않은 일반 인간형 적은 두어 개 밟으면 사망한다. 초반에는 이런 함정들을 여러 개 만들어놓는 것만으로도 꽤 유용하고 후반에도 수십 개쯤 만들어놓고 상당한 피해를 줄 수도 있다.\r\n\r\n\r\n재료가 좋으면 그만큼 피해도 더 강력해지지만, 과거에는 한 번 사용해도 재장전만 하면 계속 쓸 수 있었으나 너프되어 한 번 쓰면 부서지고 새로 재료를 들어 만들어야 하므로 많이 만들기는 힘들어졌다. 나무가 흔한 온난 지대에서는 나무 수급이 매우 쉬우니 다수를 쉽게 운용할 수 있으나 나무 함정은 피해가 제일 낮은 편에 속하는 게 문제. 그래도 가시 함정을 만들 자원만 충분하다면 인간부터 식인동물 무리, 랜서와 사이더까지 잘 통한다.\r\n\r\n\r\n주의점으로는 한 칸씩 띄워서만 설치할 수 있고, 함정을 정확히 밟아야 해당 적에게만 피해를 주기 때문에 아무 데나 설치하면 곤란하고 벽으로 적들이 통과해야만 하는 긴 통로를 만든 다음 그 안에 설치하는 게 좋다는 것다. 1칸으로 만들고 줄줄이 배치할 경우 주민이 그 위로 지나가다 일정 확률로 밟고 피해를 입을 수도 있어서 곤란하다. 옆에 별도의 주민용 통로를 만든 다음에 문을 일정 간격으로 달아서 문으로 나와 장전하는 식의 복잡한 구조를 만들 수도 있기는 한데 보통은 2칸 통로를 만들고 함정 바로 옆마다 모래주머니를 한 칸씩 설치하는 방법이 많이 쓰인다. 모래주머니 위로 가면 이동속도가 느려지므로 적의 AI상 모래주머니가 없는 경로를 우선시하고 아군은 모래주머니 쪽으로 함정을 피해 가기 때문. 다만 전투시 살아남아 퇴각한 적은 함정 위치를 기억해서 다음 습격에는 함정을 피한다. 생존자가 없을 경우는 무관.\r\n\r\n\r\n또한 재빠름 특성을 가진 적은 가시함정을 지나갈 때 밟아서 피해를 입을 확률이 10분의 1로 줄어들기에, 고주스를 빨고 선두로 달려오는 경우 함정을 그대로 지나친 채 돌격해서 정착지가 터져버리는 대참사가 일어날 수 있다. 때문에 정신충격 창 같은 유물을 확보해두는 등 대책을 세워두자.',11,0),(13,'2021-01-30 16:18:28','2021-01-30 16:18:28',1,4,'새티스팩토리 유체 관련','## 파이프\r\n\r\n* 파이프는 액체 상태의 자원을 운송한다.\r\n* 유체 공급원으로부터 약 432m[2] 후에 유속이 감소되므로 펌프를 설치해야한다.\r\n* 일정 파이프 후에 유속이 감소하므로 되도록이면 직선으로 건설하는 것이 좋다.\r\n* 되도록 길게 설치해야한다. 짧게 조각난 파이프는 유속감소, 오류 등을 일으킬수 있다.\r\n\r\n## 펌프\r\n\r\n* 펌프는 방향이 있고, 역방향으로 유체가 흐르는 것을 방지하므로 일종의 벨브 역할을 할수 있다.\r\n* 파이프의 유속을 증가시키는게 아니라 유지시킨다.\r\n* 펌프를 설치하고 바로 앞이나 뒤에 펌프를 붙혀서 설치할 경우 오작동 할수 있다.\r\n* 파이프에 유체가 있어야만 작동한다. 즉, 빈파이프에 펌프를 설치하면 작동하지 않는다.\r\n* 유체를 당기지 않으며 밀어낸다.\r\n* 상당히 많은 전기를 소모함으로 최대한 적게 설치하는 쪽으로 신경써야한다.\r\n* 유체를 고지대로 상승시킬 경우, 파이프를 직각으로 설치하라. 파이프가 사선인것과 관계없이, 펌프는 설치된 위치에서 수직으로 20미터 상승시키기 때문에 사선으로 된 파이프는 불리하다.',15,0),(14,'2021-01-30 16:23:32','2021-01-30 16:24:07',1,5,'Death\'s Gambit 한글 패치','[Death\'s Gambit 한글 패치 배포 블로그](https://blog.naver.com/bleach1491/222217129044)',9,0),(15,'2021-01-30 16:25:19','2021-01-30 16:25:19',1,5,'aseprite 한글 패치','[aseprite 한글 패치 배포 블로그](https://eternalworld.tistory.com/531)',4,0),(16,'2021-01-30 16:26:05','2021-01-30 16:26:05',1,5,'Bardbarian 한글 패치','[Bardbarian 한글 패치 배포 사이트](https://minipol.tistory.com/entry/Bardbarian-%EB%B0%94%EB%93%9C%EB%B0%94%EB%A6%AC%EC%95%88-%ED%95%9C%EA%B8%80-%ED%8C%A8%EC%B9%98 )',10,0),(17,'2021-01-30 16:26:43','2021-01-30 16:26:43',1,5,'Bendy and the Ink Machine 한글 패치','[Bendy and the Ink Machine 한글 패치 배포 사이트](https://blog.naver.com/jjin3826/221477129949 )',6,0),(18,'2021-01-30 16:27:21','2021-01-30 16:27:21',1,5,'Cat Quest 한글 패치','[Cat Quest 한글 패치 배포 사이트](https://blog.naver.com/jjin3826/221329379848)',3,0),(19,'2021-01-30 16:29:21','2021-01-30 16:29:21',1,1,'사이트 이용 시 안내 사항','인디 게임에 관한 주제에 맞는 글을 작성해 주세요.\r\n\r\n회원들 간 분쟁이 일어날 수 있는 민감한 주제에 대해 작성된 글은 삭제될 수 있습니다.',15,0),(20,'2021-01-30 16:29:40','2021-01-30 16:29:40',1,2,'안녕하세요.','안녕하세요.',686,6);
/*!40000 ALTER TABLE `article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attr`
--

DROP TABLE IF EXISTS `attr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `expireDate` datetime DEFAULT NULL,
  `relTypeCode` char(50) NOT NULL,
  `relId` int(10) unsigned NOT NULL,
  `typeCode` char(50) NOT NULL,
  `type2Code` char(50) NOT NULL,
  `value` char(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attr`
--

LOCK TABLES `attr` WRITE;
/*!40000 ALTER TABLE `attr` DISABLE KEYS */;
INSERT INTO `attr` VALUES (1,'2021-02-01 11:34:32','2021-02-01 11:34:32','2021-05-02 11:34:32','member',1,'extra','loginPwUsing90day','0'),(2,'2021-02-02 18:25:54','2021-02-02 18:25:54','2021-05-03 18:25:54','member',2,'extra','loginPwUsing90day','0'),(3,'2021-02-05 11:16:02','2021-02-05 11:16:02','2021-05-06 11:16:02','member',3,'extra','loginPwUsing90day','0'),(4,'2021-02-05 11:23:08','2021-02-05 11:23:08','2021-05-06 11:23:08','member',4,'extra','loginPwUsing90day','0'),(5,'2021-02-09 09:22:44','2021-02-09 09:22:44','2021-05-10 09:22:44','member',5,'extra','loginPwUsing90day','0'),(7,'2021-02-09 09:51:35','2021-02-09 09:51:35','2021-05-10 09:51:35','member',5,'extra','loginPwUsing90day','0'),(8,'2021-02-09 10:17:42','2021-02-09 10:17:42','2021-05-10 10:17:42','member',6,'extra','loginPwUsing90day','0');
/*!40000 ALTER TABLE `attr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board`
--

DROP TABLE IF EXISTS `board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `board` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `code` char(10) NOT NULL,
  `name` char(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` VALUES (1,'2021-01-21 09:02:35','2021-01-21 09:02:37','notice','공지사항'),(2,'2021-01-21 09:02:43','2021-01-21 09:02:45','free','자유'),(3,'2021-01-29 22:45:20','2021-01-29 22:45:22','news','새소식'),(4,'2021-01-29 22:50:45','2021-01-29 22:50:46','tip','공략'),(5,'2021-01-29 22:50:56','2021-01-29 22:50:57','data','자료실');
/*!40000 ALTER TABLE `board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `like`
--

DROP TABLE IF EXISTS `like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `like` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `relTypeCode` char(30) NOT NULL,
  `relId` int(10) unsigned NOT NULL,
  `memberId` int(10) unsigned NOT NULL,
  `point` smallint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `relTypeCode` (`relTypeCode`,`relId`,`memberId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `like`
--

LOCK TABLES `like` WRITE;
/*!40000 ALTER TABLE `like` DISABLE KEYS */;
/*!40000 ALTER TABLE `like` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `loginId` char(50) NOT NULL,
  `loginPw` varchar(200) NOT NULL,
  `name` char(50) NOT NULL,
  `nickName` char(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phoneNo` char(20) NOT NULL,
  `authLevel` tinyint(1) unsigned NOT NULL DEFAULT 2 COMMENT '0=탈퇴/1=로그인정지/2=일반/3=인증된,4=관리자',
  PRIMARY KEY (`id`),
  UNIQUE KEY `loginId` (`loginId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (1,'2021-02-01 11:34:32','2021-02-01 11:34:32','user1','0a041b9462caa4a31bac3567e0b6e6fd9100787db2ab433d96f6d178cabfce90','유저1','유저1','cdbitmana@gmail.com','01012345678',1),(2,'2021-02-02 18:25:54','2021-02-02 18:25:54','user2','6025d18fe48abd45168528f18a82e265dd98d421a7084aa09f61b341703901a3','유저2','유저2','cdbitmana@gmail.com','01012345678',1),(3,'2021-02-05 11:16:02','2021-02-05 11:16:02','user3','5860faf02b6bc6222ba5aca523560f0e364ccd8b67bee486fe8bf7c01d492ccb','유저3','유저3','cdbitmana@gmail.com','01012345678',1),(4,'2021-02-05 11:23:08','2021-02-05 11:23:08','user4','5269ef980de47819ba3d14340f4665262c41e933dc92c1a27dd5d01b047ac80e','유저4','유저4','cdbitmana@gmail.com','01012345678',1),(5,'2021-02-09 09:22:44','2021-02-09 09:51:35','user5','5a39bead318f306939acb1d016647be2e38c6501c58367fdb3e9f52542aa2442','유저5','유저5','cdbitmana@gmail.com','01012345678',1),(6,'2021-02-09 10:17:42','2021-02-09 10:17:42','user6','ecb48a1cc94f951252ec462fe9ecc55c3ef123fadfe935661396c26a45a5809d','유저6','유저6','cdbitmana@gmail.com','01012345678',1);
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recommend`
--

DROP TABLE IF EXISTS `recommend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recommend` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `relType` char(100) NOT NULL,
  `point` smallint(1) NOT NULL,
  `relId` int(10) unsigned NOT NULL,
  `memberId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recommend`
--

LOCK TABLES `recommend` WRITE;
/*!40000 ALTER TABLE `recommend` DISABLE KEYS */;
INSERT INTO `recommend` VALUES (54,'reply',-1,4,1),(55,'reply',1,4,1),(56,'article',1,21,1),(115,'reply',1,5,1),(116,'reply',-1,5,1),(117,'reply',1,6,1),(118,'reply',-1,6,1),(119,'reply',-1,3,1),(120,'reply',1,3,1),(121,'reply',-1,2,1),(122,'reply',1,2,1),(123,'reply',-1,7,1),(124,'reply',1,7,1);
/*!40000 ALTER TABLE `recommend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reply`
--

DROP TABLE IF EXISTS `reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reply` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `relType` char(100) NOT NULL,
  `relId` int(10) unsigned NOT NULL,
  `body` text NOT NULL,
  `memberId` int(10) unsigned NOT NULL,
  `status` smallint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `relType` (`relType`,`relId`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reply`
--

LOCK TABLES `reply` WRITE;
/*!40000 ALTER TABLE `reply` DISABLE KEYS */;
INSERT INTO `reply` VALUES (1,'2021-02-03 19:40:30','2021-02-09 09:40:38','article',20,'안녕하세요',1,-1),(2,'2021-02-05 08:54:48','2021-02-15 08:56:05','article',20,'댓',1,1),(3,'2021-02-08 08:57:23','2021-02-08 18:52:18','article',20,'댓글',1,1),(5,'2021-02-09 09:22:15','2021-02-09 09:22:15','article',20,'ㅎㅎ',2,1),(6,'2021-02-09 09:43:48','2021-02-09 09:44:05','article',20,'댓글수정',1,1),(7,'2021-02-10 23:28:34','2021-02-15 08:56:12','reply',2,'대댓',1,1),(8,'2021-02-15 08:56:21','2021-02-15 08:56:21','reply',2,'댓댓',1,1),(9,'2021-02-15 10:03:09','2021-02-15 10:03:09','article',7,'아아',1,1);
/*!40000 ALTER TABLE `reply` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-02-15 10:32:48
