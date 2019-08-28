/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50018
Source Host           : localhost:3306
Source Database       : webdiary4

Target Server Type    : MYSQL
Target Server Version : 50018
File Encoding         : 65001

Date: 2019-05-20 19:59:04
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL auto_increment,
  `userName` varchar(255) default NULL,
  `power` varchar(255) default NULL,
  `describe_` varchar(255) default NULL,
  `telphone` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `time` varchar(255) default NULL,
  `passwd` varchar(255) default NULL,
  `state` int(11) NOT NULL default '1' COMMENT '1是正常，2是冻结',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('2', 'admin', '超级管理员', '拥有至高无上的权利', '13566669999', '13566669999@qq.com', '2018-11-26 23:46:27', '123123', '1');

-- ----------------------------
-- Table structure for comment_
-- ----------------------------
DROP TABLE IF EXISTS `comment_`;
CREATE TABLE `comment_` (
  `id` int(11) NOT NULL auto_increment,
  `content` longtext,
  `did` int(11) default NULL,
  `time` varchar(200) default NULL,
  `reply` varchar(255) default NULL,
  `uid` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK9BDE863F6EA4BFCA` (`did`),
  KEY `FKDC17DDE0C18AC793` (`uid`),
  CONSTRAINT `FKDC17DDE0C18AC793` FOREIGN KEY (`uid`) REFERENCES `user` (`id`),
  CONSTRAINT `FK9BDE863F6EA4BFCA` FOREIGN KEY (`did`) REFERENCES `diary` (`Did`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of comment_
-- ----------------------------
INSERT INTO `comment_` VALUES ('131', 'haha', '21', '2018-09-10 03:16:40', null, '12');
INSERT INTO `comment_` VALUES ('132', 'yoyoyoyo', '21', '2018-09-10 03:16:54', null, '12');
INSERT INTO `comment_` VALUES ('148', 'wo shi ', '19', '2018-09-19 11:09:35', '阿斯蒂芬啊', '16');
INSERT INTO `comment_` VALUES ('150', 'yiyang的', '143', '2018-09-19 11:12:21', null, '16');
INSERT INTO `comment_` VALUES ('151', '99999', '168', '2018-09-10 20:25:09', '测试', '12');
INSERT INTO `comment_` VALUES ('152', '999', '168', '2019-01-20 23:02:33', '测试', '24');
INSERT INTO `comment_` VALUES ('153', 'g\'g\'g', '33', '2019-04-04 12:17:14', null, '12');
INSERT INTO `comment_` VALUES ('158', 'gg', '33', '2019-04-04 12:30:23', null, '12');
INSERT INTO `comment_` VALUES ('163', '撒旦法', '20', '2019-05-17 08:48:04', null, '12');
INSERT INTO `comment_` VALUES ('164', 'test comment', '21', '2019-05-17 09:03:39', null, '12');
INSERT INTO `comment_` VALUES ('165', '大师傅', '20', '2019-05-17 14:24:10', null, '12');
INSERT INTO `comment_` VALUES ('166', '呵呵哈哈哈', '21', '2019-05-20 16:48:46', null, '12');

-- ----------------------------
-- Table structure for ddiary
-- ----------------------------
DROP TABLE IF EXISTS `ddiary`;
CREATE TABLE `ddiary` (
  `Did` int(11) NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `content` longtext,
  `classify` varchar(255) default NULL,
  `dTime` varchar(255) default NULL,
  `image` varchar(255) default NULL,
  `Uid` int(11) default NULL,
  `content2` longtext,
  `province` varchar(100) default NULL,
  `city` varchar(100) default NULL,
  `countryRegion` varchar(100) default NULL,
  `monthTime` int(11) default NULL,
  `totalTime` int(11) default NULL,
  `keyLandscape` varchar(100) default NULL,
  PRIMARY KEY  (`Did`),
  KEY `FK77F8FDDFC18AC793` (`Uid`),
  CONSTRAINT `FK77F8FDDFC18AC793` FOREIGN KEY (`Uid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ddiary
-- ----------------------------
INSERT INTO `ddiary` VALUES ('2', '测试标题', 'safasdf', '自驾游-跟团游-自由行', '2019-05-20 19:40:56', 'upload/317b22d5-59f4-4f5c-b489-dc3f0d08cdc0.png', '20', null, '湖北', '神农架', '中国', '2', '3', '自然景观');
INSERT INTO `ddiary` VALUES ('3', '测试标题', 'dsaf sdaf&nbsp;', '自驾游-自由行', '2019-05-20 19:45:59', 'upload/8d738387-9223-40b3-9fdc-290b091e4d72.png', '20', null, '湖北', '神农架', '中国', '1', '1', '自然景观');
INSERT INTO `ddiary` VALUES ('4', '测试标题', 'sadfsadf', '自驾游-海边游', '2019-05-20 19:48:22', 'upload/32b66fc1-7895-43c4-b4d7-b240909d4dab.png', '20', '<p></p><p>sadfsadf<img src=\"/006/upload/32b66fc1-7895-43c4-b4d7-b240909d4dab.png\" style=\"max-width: 100%;\"></p>', '湖北', '天门', '中国', '1', '3', '自然景观');

-- ----------------------------
-- Table structure for diary
-- ----------------------------
DROP TABLE IF EXISTS `diary`;
CREATE TABLE `diary` (
  `Did` int(11) NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `content` longtext,
  `classify` varchar(255) default NULL,
  `dTime` varchar(255) default NULL,
  `Uid` int(11) default NULL,
  `image` varchar(255) default NULL,
  `likenum` int(255) default '0',
  `content2` longtext,
  `province` varchar(100) default NULL,
  `city` varchar(100) default NULL,
  `countryRegion` varchar(100) default NULL,
  `monthTime` int(11) default '0',
  `totalTime` int(11) default '1',
  `keyLandscape` varchar(100) default NULL,
  PRIMARY KEY  (`Did`),
  KEY `FK3EF73A3C18AC793` (`Uid`),
  CONSTRAINT `FK3EF73A3C18AC793` FOREIGN KEY (`Uid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of diary
-- ----------------------------
INSERT INTO `diary` VALUES ('19', '我在雨季的尾巴来到路易港', '下午五点刚过，路易港骤然冷清下来，一股来自海洋的潮气弥漫街头。野狗在路上游走，低垂着无精打采的头，晃荡着悠闲的步子。曲折的街道上，小卖部和餐馆都关了大门，就连城市最繁华的科当水门商业街也早早散了，留下海浪卷着油污与垃圾，轰轰作响。在毛里求斯，不敢奢望迷醉的夜生活，朝气蓬勃的度假天堂仅存在于旅游宣传单上，散发着自由与金钱的芬芳。\r\n\r\n\r\n（路易港科当水门）\r\n\r\n \r\n\r\nPatricia此时正从公司出门，双手拎满了菜和水果，后背隆起，自从搬来了毛里求斯，腰板就再也没有直起来过。Patricia快步走到港口边不远的汽车站，正巧赶上一辆即将开走的汽车，但是今天运气不好，车上没有座位，这意味着她要站一个半小时，在两个儿子饿得呼喊妈妈之前，赶回位于另一个城市的家。\r\n\r\n \r\n\r\n破旧的汽车上挤满了人，一只蟑螂匆忙从Patricia眼前的椅背上爬过，在座椅的一个缝隙中神奇消失。Patricia已经习惯了毛里求斯湿热环境下生物们的蓬勃生命力，拳头大的金色蟑螂偶尔飞到家中觅食，运气好的话，房子外墙上会有一只半米长的蜥蜴过路休息，厨房天花板上的四只壁虎是长居客，Patricia时常竖起耳朵听它们是不是连叫了七声，预示着财运将至。\r\n\r\n \r\n\r\nPatricia三十多年的人生中，多数时间都在想怎么赚钱。身为波兰人的她，早在大学时期，就赶上了赴英国打工的潮流，每天只睡三四个小时，来负担波兰大学的学费。好不容易熬到毕业，在伦敦过上了稳定的生活，却又爱上一个毛里求斯人，跟随爱情与责任定居在这热烘烘的岛上，干着旅行社的工作。为了挣更多的钱，她常常凌晨到机场接客人，一遍遍穿梭在毛里求斯的景点之间，从圆润丰满熬到了骨瘦如柴。Patricia在欧洲的时候，只知道毛里求斯是中产阶级推崇的度假天堂，而现在，她在天堂里被生活榨干了精神，在近乎绝望的疲惫中思索着种种发财之道，开美容院、销售抹茶、合伙开店……却又一次次被岛上原始的商业环境和拖沓固执的克里奥尔人打破梦想，只能偶尔怀念伦敦的繁华和华沙的冷风。Patricia随汽车颠簸摇晃着身体，小心避让身边乘客汗水黏腻的胳膊，呆望着窗外老旧的街景，不敢再对生活有更多设想。', '自驾游', '2018-08-26 23:46:07', '12', 'diaryImage\\3.jpg', '11', null, '河北', '秦皇岛', '中国', '1', '1', '自然景观');
INSERT INTO `diary` VALUES ('20', '海边的日记——厦门', '2018年的最后一周，我背起行囊，坐上火车，开始旅行。火车前方的目的地是 厦门 。\r\n说起 厦门 ，人们第一个想到的词语就是大海。从地理位置上看， 厦门 位于 福建 省的东南端，身后是富饶美丽的大陆，眼前是一望无际的太平洋，属于典型的沿海港口城市。\r\n令人向往的大海，成为日常的陪伴。人们迎着海上升起的太阳，开始一天的生活。累了，走一走最美丽的沙滩，饿了，吃一口最鲜美的海鲜。日落时分，霓光初上，海风轻抚，海浪慢拍，身体得到舒展，心灵获得放松。\r\n作为一名旅行者，或许没有足够的时间去体验一座城市每一天的日常生活。但旅行者有天生敏感的触觉：在短暂的相逢里，遇见最美。\r\n我倚在火车的座椅上，闭上双眼。 ', '自驾游', '2018-08-26 23:46:27', '12', 'diaryImage\\4.jpg', '10', null, '河北', '秦皇岛', '外国', '1', '1', '自然景观');
INSERT INTO `diary` VALUES ('21', '拖延症患者半年前在九州看樱花的十天', '这是一篇再不写，就忘了的游记。\r\n大概是各种阴错阳差与机缘巧合，造就了这场近乎完美的 九州 之行。\r\n\r\n三月中下旬，办好离职手续，又顺利拿到新营生的offer时，距离出发只剩两天，这种一切都在自己计划中的感受，让我们倍感愉悦，连 北京 出发要浪费大半天来转机的奔忙也不在话下。\r\n这次出行之前我完全迷茫，对“ 九州 ”的认知为零（也因此处处惊喜），全靠鹿妹儿一人做出的严谨攻略，才能在“错过一班车，全程被打乱”的 日本 乡村间来去自如', '自驾游', '2018-08-26 23:46:42', '13', 'diaryImage\\5.jpg', '9', null, '河北', '秦皇岛', '中国', '11', '1', '文化资源');
INSERT INTO `diary` VALUES ('22', '冬日西北环线自驾游8日游', '有时就为了一句狠话，像心头一口毒钉，永远麻痺着亲密感情交流。恶言，真要慎出，平日多誠心爱语，乃最简易之佈施。', '海边游', '2018-08-26 23:46:56', '12', 'diaryImage\\6.jpg', '3', null, '江西', '景德镇', '中国', '1', '1', '文化资源');
INSERT INTO `diary` VALUES ('23', '再见仙本那', ' 记：有的人说人生至少要有两次冲动，一次奋不顾身的爱情和一次说走就走的旅行。\r\n我叫萧寒，80后，一个爱穷游的摄影爱好者。\r\n仙本那 ，一个听名字就觉得很梦幻的一个地方。\r\n仙本那 （Semporna）是 沙巴 州 斗湖 省的一个县，位于 马来西亚 沙巴 州的 东海 岸。 仙本那 原本只是 马来西亚 一座小渔村，甚至在地图上都寻不到它。可是 仙本那 有着幻化的海洋，洁白的拖尾沙滩，浪漫的水上木屋，富有传奇色彩的水上吉普赛人——巴瑶族，和一群热情好客的原住民。\r\n物品准备：\r\n\r\n1，水下相机，这是去 仙本那 必不可少的东西。飞猪上直接租了2套，一个GoPro6，一个 奥林巴斯 ，前者超大广角，用于拍高清广角视频，后者像素较高用于拍水下世界的照片。（如果芝麻信用分在750分以上可以免租押金的，水下相机的租赁费用大概每个8-10元/天，）\r\n2，潜水服装，去 仙本那 这个潜水世界潜水服是必备的。更重要的防晒啊，不穿衣服浮潜得把你晒成 非洲 鸡。淘宝上选购的两套下来200多。\r\n3，浮潜套装，去 仙本那 大多行程都会有浮潜，所以浮潜套装是必备的。这里千万要注意，下水之前，一定要把镜面处理一下，上一些除雾剂。当你浮潜的时候发现镜面起雾是一个非常烦人的事。\r\n4，沙滩鞋，依然淘宝29元一双。这东西很有用。\r\n5，防水袋，还是淘宝上选购吧，36元一个10升的差不多了。主要放一个不能进水的东西，如手机，相机等。\r\n6，防晒霜，需要大量大量防晒霜。\r\n7，墨镜，这里紫外线真的很强。\r\n8，各种漂亮的衣服帽子泳衣泳裤等等装备。\r\n行程准备\r\n\r\n1，航班选择，首先就是看往返特价机票，7月份看到马航上的特价机票往返1025，立马下手。从 长沙 出发只能飞 亚庇 ，需要 亚庇 转机到 斗湖 5。转机机票飞猪上预订100多，提前一点订这机票折扣随时都在浮动。\r\n2，签证， 马来西亚 可以电子签证，强大的淘宝上就可以搞定。\r\n3，度假村的选定，度假村一定要提前订，特别是像卡帕莱，马达京这些很抢手的。当然度假村分水屋和沙屋，我们选择了沙屋（邦邦岛的白珍珠度假村，打折后1998元/晚，我选择了3天两晚）。其实个人也建议选择沙屋，第一相对实惠一些，第二沙屋还是有沙滩可以玩的，水屋就只能待在架子上了。\r\n4，酒店预订，当返回 仙本那 小镇时选择预订酒店。推荐 海丰 大酒店。\r\n5，行程单打印，过海关的时候工作人员可能会看你的行程单，最好是准备好。\r\n准备好了，那就开始行程吧\r\nDay 1\r\n\r\n\r\n长沙 — 亚庇 — 斗湖 — 仙本那 —邦邦岛\r\n真的是最累最累的一天，而且没有之一。9月15日凌晨1点的飞机，带个兴奋与激动我们两人9月14日晚9点半就出发前往机场了。办理登机牌，托运行李，过海关，上飞机。机场遇到了一对小两口，很是恩爱，然后我们开始组队等飞机啦。\r\n让人欲哭无泪的是，在飞机上根本睡不着。\r\n经过3个半小时的飞行，9月15日早上4点半的样子飞机终于着陆了，我们四人一同下飞机，在机场找了一个自动取款机取了1000马币（ps：国内的银联卡基本上都能用）。旁边有一家肯德基，我们用一系列肢体语言点了一些简单的早餐。简单休息了一会儿，取票进候机室等待飞往 斗湖 航班。这还不到6点，距离飞机起飞8:50还有接近3个小时。。。。。。面对着这个空旷的候机室又是漫长的等待。\r\n候机室的门没有锁，可以直接走到机场空港，看着面前停着的飞机与不断起飞降落的飞机。\r\n\r\n飞机终于起飞，看着窗下的朵朵白云，期待着。。。期待着。。。。\r\n飞机着陆， 斗湖 机场是一个非常小的机场，出机场，和前面认识的那对小情侣分手后（因为他们订了马达京，而我们订的是邦邦岛）发现酒店安排接我们的小哥哥已经在机场出口等我们了。 斗湖 到 仙本那 是一条狭窄的公路，而这些接送人的小哥哥们却个个都是赛车手。看着路边是这一片片棕油树一个半小时的车程，我们终于到 仙本那 镇了。\r\n\r\n司机直接把我们送到码头，上船，终于看到了 仙本那 的海，快艇溅起浪花，海风扑面而来，海水越来越清澈，泛起玻璃似的粼光，对，40分钟我们终于到了邦邦岛。简单的吃了点东西，到了酒店房间，看了一下时间，已经下午2:30，从14日21:30出发——15日14:30分，足足17个小时的旅程，真的是最累最累的一天，没有之一。\r\n风尘仆仆的我们，洗了个澡休息了2个小时。拿起相机，换上衣服开始狂拍。沙滩，阳光，海洋，太美太美\r\n\r\n无边的海洋，还有那传说中的玻璃海，还是看照片吧。\r\n\r\n根本没人和你抢镜 、\r\n\r\n日落时分，海与天泛起五彩斑斓的色彩。\r\n\r\n晚饭过后，休息为第二天的出海做准备\r\nDay 2\r\n\r\n邦邦岛——汀巴汀巴岛——海龟岛——邦邦岛\r\n本来想着在早前看日出的，但是昨天玩得太累了，起不来呀\r\n眼睛一睁，祈祷啊，千万不要下雨呀。。。还好老天眷顾，早上的乌云一下子不见了，一会儿就万里碧空啦。\r\n洗漱后，到餐厅早餐（说到这里，得提一下度假村的伙食，确实不怎么样，建议国内的朋友过去玩，带点老干妈 ），然后就是期待已久的跳岛游啦。\r\n出发。。。。\r\n第一个目的地就是汀巴汀巴岛，长长的拖尾沙滩，真的好美。美中不足的就是这里基本上没人来管理，沙滩上漂了很多树枝，看起来不是那么干净。\r\n\r\n第二站，海龟岛\r\n快靠岸的时候， 水里 好多好多大海龟，以前一直以为它们的动作很慢，这才发现，海龟在 水里 游动的速度超快的。\r\n距离海龟岛不远的地方，这里风浪比较小。我们的船停了下来。开始我们期待已久的浮潜。面对五彩斑斓的大海，当然少不了来一次跳海， （这里千万要注意，下水之前，一定要把镜面处理一下，上一些除雾剂。千万千万注意）】\r\n这里得万分感谢这里的一个小哥哥，人真的好好，带着我们在 水里 漂了1个多小时。给我们各种拍照。\r\n第一跳真的没准备好啊！！！被推的\r\n\r\n来，下图就是那个帅气的小哥哥\r\n本篇游记共含5527个文字，75张图片。帮助了325名仙本那游客。\r\n举报\r\n相关目的地：    马来西亚    沙巴\r\n仙本那\r\n仙本那\r\n有182747张照片\r\n相关攻略\r\n\r\n    4086\r\n    仙本那镇上那些可以“逛吃逛吃”的当地市场\r\n    4143\r\n    探秘仙本那之旅，寻访最后的海上吉普赛人巴瑶族\r\n    392\r\n    仙本那5大浮潜胜地，水清沙幼美到没朋友\r\n\r\n相关目的地：仙本那\r\n相关游记\r\n\r\n    10022\r\n    仙本那｜相约蓝色的蜜月 再遇夏日的热浪\r\n    20907\r\n    仙本那 | 坐船摇摆，上山下海，浸入一片蓝（详细行程规划）\r\n    275\r\n    面朝大海 春暖花开 遇见潜水 遇见仙本那\r\n\r\n游记目录\r\n\r\n    01/默认段落\r\n    02/物品准备：\r\n    03/行程准备\r\n    04/准备好了，那就开始行程吧\r\n    05/Day 1\r\n    06/Day 2\r\n    07/Day 3\r\n    08/Day 4\r\n    09/Day 5\r\n    10/费用\r\n\r\n', '海边游', '2018-08-26 23:47:16', '14', 'diaryImage\\7.jpg', '2', null, '江西', '景德镇', '中国', '1', '1', '风俗民情');
INSERT INTO `diary` VALUES ('31', '三月，醉一场青春的流年', '三月，醉一场青春的流年。慢步在三月的春光里，走走停停，看花开嫣然，看春雨绵绵，感受春风拂面，春天，就是青春的流年。青春，是人生中最美的风景。青春，是一场花开的遇见；青春，是一场痛并快乐着的旅行；青春，是一场轰轰烈烈的比赛；青春，是一场鲜衣奴马的争荣岁月；青春，是一场风花雪月的光阴。\r\n \r\n　　青春往事，多么甜蜜；青春岁月，多么靓丽；青春流年，如火如荼。青春里，我们向着梦想前进。跌倒过，伤心过，快乐过，痛苦过，孤独过，彷徨过，迷茫过。总是，在悠悠的岁月中徘徊；总是，在如春的生命中成长；总是，在季节的交替中感悟人生四季的美妙与韵律；总是，在多愁善感中体悟青春的美好与无奈。\r\n \r\n　　三月的鲜花，一树树，一束束，一簇簇，而青春，就是像三月的鲜花一样美丽迷人，生机盎然，姹紫嫣红，生机勃勃。三月，是青春里最美最温暖的风景。三月的美，就像青春的美，充满活力，充满生机，充满昂扬的斗志。三月的美，就像青春的花季，在那里我们可以感受青春的跳动与感动，感受青春的曼妙与奇妙；感受青春的悸动与心跳。\r\n \r\n　　青春，如三月的春光，安暖向阳。在美丽的青春年华，我们手牵手，肩并肩，跨过岁月山河，跨过锦瑟流年，跨过天涯海角，在三月的春光里沐浴金色的光泽。三月的春光，让青春的我们看到希望，看到自己有一颗年轻跳动的心，看到蓝天白云，看到明媚的灿烂。三月的春光，温暖无比，就像我们的青春，有着长辈的呵护，有着老师的循循教导，它们就像春光，照耀着我们年轻的心。', '海边游', '2018-08-27 18:28:05', '12', 'diaryImage\\9.jpg', '0', null, '江西', '景德镇', '中国', '1', '1', '自然景观');
INSERT INTO `diary` VALUES ('32', '一路向西——2018年夏天新疆自驾行', '这个时候是旅游淡季，租车的价格比旺季低了一半多，约着同学坐看云起时两家合租一辆科帕奇SUV。到了 乌鲁木齐 ，先到机场旁的神州租车提预订的科帕奇，告知没有，能否用昂科威替代？这哪行，此行地形复杂，没有四驱可能会出问题，一再要求下，还是弄到了四驱的科帕奇。趁着领队河鱼没来，先奔一百公里外的 天山 天池。\r\n一路都是搓板样的高速公路，各种检查，打火机也没收，到景点一问，215一张门票，真贵啊[捂脸][捂脸]！！咬牙放血上 天山 ，半路上还要到一个圈起来的哈萨克风情园转一圈，不转就上不了车。车爬到山顶，一看屁大点的天池，还不如 北京 延庆 八道河边上的燕山天池，如果不是远处的雪山，碧蓝的湖水，这趟路有点怨！这真是，来了不看后悔，来了看更后悔！朋友说， 中国 旅游有四大坑： 天山 天池、 西双版纳 、 少林寺 、黄帝陵。感情天池排四大坑之首。 ', '海边游', '2018-08-27 23:18:24', '13', 'diaryImage\\6.jpg', '0', null, '江西', '景德镇', '中国', '1', '1', '人文景观');
INSERT INTO `diary` VALUES ('33', '小记', '你好，九月', '海边游', '2018-08-28 00:40:03', '13', 'diaryImage\\1.jpg', '2', null, '江西', '景德镇', '中国', '1', '1', '人文景观');
INSERT INTO `diary` VALUES ('80', '周末，走进陌生城市', '春雨来了，世间万物也经历了一次彻头彻尾的洗涤，走在清晨的街上，异常凉爽，人也精神了很多。这个周末，闲暇的自己走出家门，忙碌了一周的感觉好累，终于可以就此放松一下紧皱的心情。\r\n\r\n再次踏上这个城市的街头，突然感觉忙碌的自己竟然与这个忙碌的城市格格不入，所到之处都是匆匆赶路的人群，或者站牌前等公交，或者挤进站台等地铁，亦或者开车混进车流，一直以為自己很忙碌，也好累，可是看看这高消费的城市人群，每一个人都在为了自己的生活忙碌着，而奔波的结果，除了些许的收获，就只剩下了一天的劳累。\r\n\r\n漫步商场，眼睛所到之处都是花花绿绿的换季服饰，服务小姐热情的打着招呼，走进每一个格子间居然让不喜欢逛商场的我羞于抬头看那些服饰，不是不喜欢，而是那琳琅满目的标价限制了我的思维，想起来，这么多年的教书生涯不知道送出去了多少老板，或许那一个个生意人的生命里都曾有过我的足迹，而我们，昔日的教书匠却依然面对着昂贵的物价而羞于启齿。岁月的镌刻只在意了满头的白发和脸上深深地沟壑，而唯一能填平内心的，就只有内心的那点精神享受，昂起头颅，走出商场，跟奢侈的购物生活告别！', '海边游', '2018-09-04 15:39:32', '15', 'diaryImage\\2.jpg', '0', null, '天津', '河西区', '中国', '1', '1', '传统饮食');
INSERT INTO `diary` VALUES ('139', '雨游天平山：青峰如笏　江枫似火', '雨中游天 平山 倒是头回。风是轻软，雨是微寒。去时少不了作“雨过天平翠作堆，净无尘土有苍苔”的遐想，也希望看到“ 屏山 雾气山开画，书重檐声雨满堂”的美景。正值天 平山 红枫节，朋友要去赏红枫，而这次我的第一愿望却是再登天 平山 。第一次登天 平山 是很久以前的事了，记忆中除了如飞来石、一线 天等 一些名谓之外，山上的情形已想不起来。\r\n最近的一次到天 平山 是四年前的11月15日，只赏枫、没登山；这次竟然又是11月15日，机缘巧合，赏枫、登山、寻幽、访古，自然一个不能少', '出境游', '2018-09-10 00:19:29', '12', 'diaryImage\\ChMkJlaYn4iIa-rvAAnzSvEECAsAAHUlAEGjwAACfNi365.jpg', '6', null, '天津', '河西区', '中国', '1', '1', '特种专项');
INSERT INTO `diary` VALUES ('141', '你的世界我最美', '人们通常会说大爱无言，的确，在母亲的心里也许是不愿表达，更甚是爱的深沉，无法用语言来形容。\r\n \r\n\r\n对她，我平日里都是叫妈妈，母亲是我心里的称呼。她哺育婴儿时的我，养育童年时的我，教育青年时的我……\r\n \r\n\r\n如果非得用一种“非人类”来抽象的形容那份伟大的爱，我会选择槐花，为什么？也许它没有玫瑰花的艳丽，没有牡丹的高贵，但它充满我对妈妈的记忆。每当家乡槐花盛开的时候，我总会闻到独特的芳香，它平日可见却不令人疲劳，总会给我一种清新脱俗的感觉。\r\n \r\n\r\n家门前有一棵槐树，是我出生那年，母亲栽上的，后来也时不时拿我的身高跟这棵树比较。儿时的夏天，蝉声鸣鸣，树上浓绿的叶子渲染着童年的活力，闷热的空气中却总是会有一股清凉，那时的自己，喜欢跟小朋友，在树下阴凉地、房屋墙影下玩耍，槐花的香气充满儿时的记忆。小孩子嘛，不知哪里来的一股劲，玩耍起来就不知疲倦，夸张一点，可以嗨三天三夜不停歇。', '出境游', '2018-09-10 00:28:05', '12', 'diaryImage\\ChMkJ1diS1iId7DNAAqYUHeMHIAAASqZgOtA3oACpho409.jpg', '0', null, '湖南', '长沙', '中国', '1', '1', '风俗民情');
INSERT INTO `diary` VALUES ('143', '厦门初探•慵懒短暂的鹭岛时光', '一定要做个见过世面的女生。\r\n利益面前可以荣辱不惊，爱情面前可以自信昂扬。\r\n女孩子只有看过了世界，才不会收到几朵玫瑰花就以为遇到了真爱。\r\n不会轻易被套路，也不会随便被诱惑。\r\n女孩子那种坦荡淡定的模样，真的很美。', '出境游', '2018-09-10 00:32:25', '18', 'diaryImage\\8726f936d337ef1623cf868202ee713e.jpg', '8', null, '天津', '河西区', '中国', '1', '1', '传统饮食');
INSERT INTO `diary` VALUES ('144', '阳春三月', '二月如奔驰的马驹，一晃而过。三月带着一股兴盛的动态，强势入住。三月是有力量的，它不容忽视。\r\n\r\n春天在三月里已经丰富饱满，那些生长出来的绿意，在一夜间，就多了许多。\r\n\r\n“阳春百日风在香”，三月的微风带着俏皮吹拂在脸颊，温和的如少女的发丝，飘动着春天里特有的气息。走在三月的风中，有股特别渴望奔跑的想法。我们都经历过逆风飞翔的困难，我们也经过过迎风奔跑的快意。你在风中的样子，最美。\r\n\r\n三月的雨是带着丝线的细，穿透心底的清幽，滋润着大地。小草，野花，树叶，绿枝，还有撑着雨伞的的人。在三月的雨中，是适合思念一个人的。“人间三月雨和尘”，三月的雨带着清凉缠绵，一来就会润了心田。一场雨后，更多春生。\r\n\r\n三月的花，是迷人的。在花海里，抬头间，鼻尖就会触碰着花朵的温柔。颔首处，扑鼻而来的香氛，流动在身边。忍不住的想去，与花共眠。写不尽的花意，流水也在等待着花的垂爱。花期到了，满树的花蕊，把春天装扮的格外美丽。', '出境游', '2018-09-10 00:33:46', '12', 'diaryImage\\0b2e39658a42b8f984cc3f46bb08f3a6.jpg', '0', null, '天津', '河西区', '中国', '1', '1', '风俗民情');
INSERT INTO `diary` VALUES ('146', '红尘陌上雪，散落随花开', ' 红尘陌上的花开。似比相见又恨晚的聚散，相遇过早前方的路人，便会成为身后的过客。相识过晚倾城清风的颜美。便会与你擦肩，来不及仰望。说不出再见，从此山隔一河。却天涯此岸，回眸仰望已是曾经沧海，百花残月之冬。相遇有缘，离花漂过。景色的相遇正如那份。一直落在思念里的寒冬，无论冰川怎样刺骨。雪花怎样漂过，一颗执着的心。一直苦苦寻找。天暗未明微落的天空却被大雪覆盖，热血的少年。曾经的意志，却从未止步。从春天到寒冬。从寒冬到天荒，一直守护着这份。从未揭开的思念。  \r\n                                                                                    \r\n\r\n——题记\r\n \r\n\r\n红尘相遇，年华已老。岁月花开多少不在，古往今来相遇是一件既微妙。而又神圣的事情，红尘的情网中。有前者因聚散而离开，后者才因前者的离开。而深深的相遇，曾经有人说过。有缘份相遇的人。无论彼此绕开多大个圈，也会在某个不经意间。彼此依然可以重逢相遇，其实这种故事。只是说说而已。故此，却有很多人相信。从而走进缘分的刹那。', '自由行', '2018-09-10 00:36:42', '12', 'diaryImage\\summer_wind_4-wallpaper-1920x1080.jpg', '10', null, '河北', '秦皇岛', '中国', '1', '1', '田园风光');
INSERT INTO `diary` VALUES ('148', '告别，起航——云南初探', '世界上只有一种真正的英雄主义，那就是在认清生活的实质后还依旧热爱生活。2018的年末，30岁，去了 云南 ，跨年。在最混乱的时候操办这一场旅游，让它成为最没有规划、功课做得最差的一次。告别之旅，告别那个让我一直自欺欺人，糟心的人；起航之旅，把原先的蜜月旅游改成单身旅游，换个目的地，重新开始。 ', '自由行', '2018-09-10 00:36:42', '23', 'diaryImage\\Maserati-GT-supercar-front-view_1920x1080.jpg', '1', null, '河北', '秦皇岛', '中国', '1', '1', '田园风光');
INSERT INTO `diary` VALUES ('149', '周末，走进陌生城市', '春雨来了，世间万物也经历了一次彻头彻尾的洗涤，走在清晨的街上，异常凉爽，人也精神了很多。这个周末，闲暇的自己走出家门，忙碌了一周的感觉好累，终于可以就此放松一下紧皱的心情。\r\n\r\n再次踏上这个城市的街头，突然感觉忙碌的自己竟然与这个忙碌的城市格格不入，所到之处都是匆匆赶路的人群，或者站牌前等公交，或者挤进站台等地铁，亦或者开车混进车流，一直以為自己很忙碌，也好累，可是看看这高消费的城市人群，每一个人都在为了自己的生活忙碌着，而奔波的结果，除了些许的收获，就只剩下了一天的劳累。\r\n\r\n漫步商场，眼睛所到之处都是花花绿绿的换季服饰，服务小姐热情的打着招呼，走进每一个格子间居然让不喜欢逛商场的我羞于抬头看那些服饰，不是不喜欢，而是那琳琅满目的标价限制了我的思维，想起来，这么多年的教书生涯不知道送出去了多少老板，或许那一个个生意人的生命里都曾有过我的足迹，而我们，昔日的教书匠却依然面对着昂贵的物价而羞于启齿。岁月的镌刻只在意了满头的白发和脸上深深地沟壑，而唯一能填平内心的，就只有内心的那点精神享受，昂起头颅，走出商场，跟奢侈的购物生活告别！', '自由行', '2018-09-10 00:36:42', '12', 'diaryImage\\legs_barefoot_Wallpaper_1920x1080_www.wall321.com.jpg', '2', null, '河北', '秦皇岛', '中国', '1', '1', '传统饮食');
INSERT INTO `diary` VALUES ('150', '大江大湖大武汉，黄鹤一去不复返', '这次要补一篇早在2016年的游记了：一座个性鲜明的城市—— 武汉 。\r\n\r\n每一座城市，无论大小，都有自己的特质，只是在“千城一面”的大背景下，很多城市迷失了自己。 武汉 则不然，无论好坏，即使是我这样的匆匆过客，也会印象深刻。\r\n\r\n网坛巨星李娜，曾经这样调侃自己的家乡：“ 武汉 是一个只有1000多万人的小城镇。” 此话可见 武汉 的两大特质：一是大不咧咧不修边幅的城市性格，有“江湖气”；二就是“大”，是一座从地盘到人口都算巨无霸的超 大城 市', '自由行', '2018-09-10 00:36:42', '20', 'diaryImage\\Greece_Santorini_Notio_Aigaio_Oia_sunset_house_szeke_photography_1920x1280.jpg', '1', null, '湖北', '武汉', '中国', '1', '1', '特种专项');
INSERT INTO `diary` VALUES ('151', '国庆半深度游大理洱海', '国庆节去的，因为各种原因本来想放弃不写游记的，最后又看了看自己拍的美照，还是写吧。\r\n放国庆前约基友去浪，但要么是要回老家，要么是去过了，要么…………???? …\r\n反正各种原因自己一个人去了。 ', '自由行', '2018-09-10 00:36:42', '12', 'diaryImage\\freedom_2-wallpaper-1920x1080.jpg', '1', null, '河北', '秦皇岛', '中国', '1', '1', '特种专项');
INSERT INTO `diary` VALUES ('166', '一个人旅行的好处，全身感官被迫张开与感觉相伴', '“在相当长的一段时间里，我都完全不知道应该如何进行一场孤身一人的旅行。从不知所措，到后来慢慢地被迫习惯，慢慢地学会接受，直到最后懂得喜爱。”&nbsp;&nbsp;这是蔻蔻梁，在《如果你在就好了》序言里写的话。《如果你在就好了》最近一直在读的一本书，很别致独特的一本旅行随笔。很喜欢书封面上的那段话：一个人旅行最大的好处，是因为孤独所以被迫张开全身感官，与自己的感觉相伴，所以格外渴求地探索周围的世界。所有的神经末梢都膨胀得更为巨大。每一种情绪都自带了膨胀系数。这是一个对外界开放的状态，你想所有的陌生人和陌生事奉献出自己，以求获取某些神秘的共振这是和自己较劲的过程，赢了，就轻盈了。&nbsp;&nbsp;', '自由行', '2019-01-14 03:17:55', '12', 'diaryImage\\Greece_Santorini_Notio_Aigaio_Oia_sunset_house_szeke_photography_1920x1280.jpg', '7', '<p></p><p>“在相当长的一段时间里，我都完全不知道应该如何进行一场孤身一人的旅行。从不知所措，到后来慢慢地被迫习惯，慢慢地学会接受，直到最后懂得喜爱。”&nbsp;</p><img src=\"/006/upload/e34e44a6-d826-46f0-aa60-8308343b6eeb.jpg\" style=\"max-width:100%;\"><p>&nbsp;这是蔻蔻梁，在《如果你在就好了》序言里写的话。《如果你在就好了》最近一直在读的一本书，很别致独特的一本旅行随笔。<br></p><p>很喜欢书封面上的那段话：一个人旅行最大的好处，是因为孤独所以被迫张开全身感官，与自己的感觉相伴，所以格外渴求地探索周围的世界。所有的神经末梢都膨胀得更为巨大。每一种情绪都自带了膨胀系数。这是一个对外界开放的状态，你想所有的陌生人和陌生事奉献出自己，以求获取某些神秘的共振这是和自己较劲的过程，赢了，就轻盈了。&nbsp;&nbsp;<br></p>', '河北', '廊坊', '中国', '1', '1', '特种专项');
INSERT INTO `diary` VALUES ('168', '广州周边好去处，摄影师超爱的郴州东江湖', '如果有人说郴州不美的，那他一定是没去过，因为他没有看到过初秋云雾缭绕中的小东江、没有看到过大珠小珠落玉盘般的猴古山瀑布、没有到过“美的一塌糊涂的”丹霞地貌处女地的高椅岭、更没有到过“地球的一滴眼泪”——仰天湖......高椅岭 by 朱小涵郴州位于湖南省东南部，地处南岭山脉中段与罗霄山脉南段交汇地带，东界江西省赣州市，南邻广东省韶关市、清远市，西接永州市，北交衡阳市及株州市，因此是无论是本省还是江西和广州，来这里都比较方便。这里的自然景观甚多，如：中国原始生态第一山——莽山、让世界呼吸的东江湖、苏仙岭等，这都是国家级风景名胜区。你更不能错过的是这里的温泉，郴州地热资源丰富，温泉的矿物质多，对人体十分有益。游历郴州最美景区——东江湖如果说，古有陶渊明的桃花源般的世外之境，那么东江湖就是中国不可多得的人间天堂。一长蒿、一蓑衣、一盏明火、一叶扁舟，清澈之湖面，稍有习习微风，漾起层层涟漪，九月初秋，云雾缭绕着的小东江，置身画卷当中，却又真实的存在于山水间.......图为：东江湖（来源于网络）东江湖融山的隽秀、水的神韵于一体，挟南国秀色、禀历史文明于一身，被誉为“人间天上一湖水，万千景象在其中”。东江湖风景旅游区内的风景旅游资源主要集中分布于东江湖、天鹅山国家森林公园、程江口等三大区域内，以山、水、湖、坝、雾、岛、庙、洞、庄、瀑、漂而取胜。图为：东江湖风景区（来源于网络） 开放时间：1、4月15日-10月15日 周一~周日    06:00-18:002、10月16日-次年4月14日 周一~周日   08:30-18:00 门票：东江湖风景旅游区的各景点门票实行联票制，统一由东江门楼售票中心（东江湖风景旅游区入口处，距东江湖12公里）售出。各景点门票价格虽与门楼相同，但在景点购票无优惠，游客可根据需要选择不同线路：A线：大景区雾漫小东江、猴古山瀑布、东江大坝外景、龙景峡谷、观东江湖100元/人图为：A线路图B线：兜率灵岩、雾漫小东江、猴古山瀑布、东江大坝外景、龙景峡谷、游东江湖、兜率灵岩171元/人图为：B线路图C线环岛游：东江漂流、雾漫小东江、猴古山瀑布、东江大坝外景、龙景峡谷、游东江湖、东江漂流338元图为：C线路图出行小贴士： 地址：湖南省郴州市资兴市东江镇 交通路线：1、郴州火车站出口乘的士直达东江湖景区门楼综合服务区，车费约150元。2、郴州火车站下车后乘坐101路、18路、26路公交车至郴州市天龙站，换乘201路城际公交至资兴市城区（罗围站），换乘资兴市1路、2路、3路公交车均可到达东江湖景区。', '自由行-自驾游-出境游-海边游', '2019-01-17 20:52:22', '12', 'diaryImage\\angel_18-wallpaper-1920x1080.jpg', '5', '<p></p><p>如果有人说郴州不美的，那他一定是没去过，因为他没有看到过初秋云雾缭绕中的小东江、没有看到过大珠小珠落玉盘般的猴古山瀑布、没有到过“美的一塌糊涂的”丹霞地貌处女地的高椅岭、更没有到过“地球的一滴眼泪”——仰天湖......<br>高椅岭 by 朱小涵<br>郴州位于湖南省东南部，地处南岭山脉中段与罗霄山脉南段交汇地带，东界江西省赣州市，南邻广东省韶关市、清远市，西接永州市，北交衡阳市及株州市，因此是无论是本省还是江西和广州，来这里都比较方便。这里的自然景观甚多，如：中国原始生态第一山——莽山、让世界呼吸的东江湖、苏仙岭等，这都是国家级风景名胜区。你更不能错过的是这里的温泉，郴州地热资源丰富，温泉的矿物质多，对人体十分有益。<br>游历郴州最美景区——东江湖<br>如果说，古有陶渊明的桃花源般的世外之境，那么东江湖就是中国不可多得的人间天堂。一长蒿、一蓑衣、一盏明火、一叶扁舟，清澈之湖面，稍有习习微风，漾起层层涟漪，九月初秋，云雾缭绕着的小东江，置身画卷当中，却又真实的存在于山水间.......<br>图为：东江湖（来源于网络）<br>东江湖融山的隽秀、水的神韵于一体，挟南国秀色、禀历史文明于一身，被誉为“人间天上一湖水，万千景象在其中”。东江湖风景旅游区内的风景旅游资源主要集中分布于东江湖、天鹅山国家森林公园、程江口等三大区域内，以山、水、湖、坝、雾、岛、庙、洞、庄、瀑、漂而取胜。<br>图为：东江湖风景区（来源于网络）<br> 开放时间：<br>1、4月15日-10月15日 周一~周日    06:00-18:00<br>2、10月16日-次年4月14日 周一~周日   08:30-18:00<br> 门票：东江湖风景旅游区的各景点门票实行联票制，统一由东江门楼售票中心（东江湖风景旅游区入口处，距东江湖12公里）售出。各景点门票价格虽与门楼相同，但在景点购票无优惠，游客可根据需要选择不同线路：<br><br>A线：大景区雾漫小东江、猴古山瀑布、东江大坝外景、龙景峡谷、观东江湖100元/人<br>图为：A线路图<br>B线：兜率灵岩、雾漫小东江、猴古山瀑布、东江大坝外景、龙景峡谷、游东江湖、兜率灵岩171元/人<br>图为：B线路图<br>C线环岛游：东江漂流、雾漫小东江、猴古山瀑布、东江大坝外景、龙景峡谷、游东江湖、东江漂流338元<br>图为：C线路图<br>出行小贴士：<br> 地址：湖南省郴州市资兴市东江镇<br> 交通路线：<br>1、郴州火车站出口乘的士直达东江湖景区门楼综合服务区，车费约150元。<br>2、郴州火车站下车后乘坐101路、18路、26路公交车至郴州市天龙站，换乘201路城际公交至资兴市城区（罗围站），换乘资兴市1路、2路、3路公交车均可到达东江湖景区。<img src=\"/006/upload/d0c3aff4-5ba4-4227-a4ad-919d022dd565.jpeg\" style=\"max-width:100%;\"><img src=\"/006/upload/a8cf6d0a-c9ba-4929-9800-e4e99fa5ccd1.jpg\" style=\"max-width:100%;\"></p>', '广东', '广州', '中国', '1', '1', '传统饮食');

-- ----------------------------
-- Table structure for dphoto
-- ----------------------------
DROP TABLE IF EXISTS `dphoto`;
CREATE TABLE `dphoto` (
  `id` int(255) NOT NULL auto_increment,
  `image` varchar(255) default NULL,
  `did` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK78A1D84E63BFAFB6` (`did`),
  CONSTRAINT `FK78A1D84E63BFAFB6` FOREIGN KEY (`did`) REFERENCES `ddiary` (`Did`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dphoto
-- ----------------------------
INSERT INTO `dphoto` VALUES ('2', 'upload/317b22d5-59f4-4f5c-b489-dc3f0d08cdc0.png', '2');
INSERT INTO `dphoto` VALUES ('3', 'upload/8d738387-9223-40b3-9fdc-290b091e4d72.png', '3');
INSERT INTO `dphoto` VALUES ('4', 'upload/32b66fc1-7895-43c4-b4d7-b240909d4dab.png', '4');

-- ----------------------------
-- Table structure for like_diary
-- ----------------------------
DROP TABLE IF EXISTS `like_diary`;
CREATE TABLE `like_diary` (
  `id` int(11) NOT NULL auto_increment,
  `diary_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `diary_id` (`diary_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `diary_id` FOREIGN KEY (`diary_id`) REFERENCES `diary` (`Did`),
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of like_diary
-- ----------------------------
INSERT INTO `like_diary` VALUES ('13', '166', '12');
INSERT INTO `like_diary` VALUES ('14', '166', '12');
INSERT INTO `like_diary` VALUES ('15', '166', '12');
INSERT INTO `like_diary` VALUES ('16', '19', '12');
INSERT INTO `like_diary` VALUES ('17', '20', '12');
INSERT INTO `like_diary` VALUES ('18', '20', '12');
INSERT INTO `like_diary` VALUES ('19', '21', '12');
INSERT INTO `like_diary` VALUES ('20', '21', '12');
INSERT INTO `like_diary` VALUES ('21', '21', '12');
INSERT INTO `like_diary` VALUES ('22', '22', '12');
INSERT INTO `like_diary` VALUES ('23', '22', '12');
INSERT INTO `like_diary` VALUES ('24', '23', '12');
INSERT INTO `like_diary` VALUES ('25', '168', '12');
INSERT INTO `like_diary` VALUES ('26', '146', '12');
INSERT INTO `like_diary` VALUES ('27', '33', '12');
INSERT INTO `like_diary` VALUES ('28', '148', '12');
INSERT INTO `like_diary` VALUES ('31', '21', '26');
INSERT INTO `like_diary` VALUES ('32', '166', '20');
INSERT INTO `like_diary` VALUES ('33', '168', '20');
INSERT INTO `like_diary` VALUES ('34', '146', '20');
INSERT INTO `like_diary` VALUES ('35', '149', '20');

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` int(11) NOT NULL auto_increment,
  `content` varchar(255) default NULL,
  `reply` varchar(255) default NULL,
  `dTime` varchar(255) default NULL,
  `Uid` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK9C2397E7C18AC793` (`Uid`),
  CONSTRAINT `FK9C2397E7C18AC793` FOREIGN KEY (`Uid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES ('2', '我觉得我也是个弟弟', '好的', '2018-08-30', '12');
INSERT INTO `message` VALUES ('38', 'dsa', '8989898989', '2018-09-10 20:06:00', '12');
INSERT INTO `message` VALUES ('39', 'dsa', 'dd', '2018-09-10 20:06:01', '12');
INSERT INTO `message` VALUES ('41', 'dd', '232332323232', '2018-09-12 21:17:24', '12');
INSERT INTO `message` VALUES ('42', 'sadsaasdas', 'sad', '2018-09-19 10:38:54', '12');
INSERT INTO `message` VALUES ('43', '我是谁', 'zxz', '2018-09-19 11:13:13', '12');
INSERT INTO `message` VALUES ('44', '333', null, '2019-01-20 23:15:39', '12');
INSERT INTO `message` VALUES ('45', '乱', 'sadf', '2019-03-08 19:58:15', '12');
INSERT INTO `message` VALUES ('47', '测试反馈社区2', null, '2019-04-02 20:18:00', '12');
INSERT INTO `message` VALUES ('48', '123123', null, '2019-04-04 12:08:05', '12');
INSERT INTO `message` VALUES ('49', 'dddddddddddddddddddd', null, '2019-04-04 12:51:36', '12');
INSERT INTO `message` VALUES ('50', '测试修改', null, '2019-05-17 14:16:18', '12');
INSERT INTO `message` VALUES ('51', '测试修改字段', null, '2019-05-17 14:19:23', '12');
INSERT INTO `message` VALUES ('52', '大师傅', null, '2019-05-20 16:47:38', '12');

-- ----------------------------
-- Table structure for photo
-- ----------------------------
DROP TABLE IF EXISTS `photo`;
CREATE TABLE `photo` (
  `id` int(255) NOT NULL auto_increment,
  `image` varchar(255) default NULL,
  `did` int(11) default NULL,
  UNIQUE KEY `id` (`id`),
  KEY `FK4984E126EA4BFCA` (`did`),
  CONSTRAINT `FK4984E126EA4BFCA` FOREIGN KEY (`did`) REFERENCES `diary` (`Did`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of photo
-- ----------------------------
INSERT INTO `photo` VALUES ('1', 'diaryImage\\0b2e39658a42b8f984cc3f46bb08f3a6.jpg', '139');
INSERT INTO `photo` VALUES ('2', 'diaryImage\\1-130913102A9.jpg', '141');
INSERT INTO `photo` VALUES ('3', 'diaryImage\\22fb10ee1169541ff7047948f300e7f4.jpg', '143');
INSERT INTO `photo` VALUES ('4', 'diaryImage\\8726f936d337ef1623cf868202ee713e.jpg', '144');
INSERT INTO `photo` VALUES ('6', 'diaryImage\\1324518036811.jpg', '146');
INSERT INTO `photo` VALUES ('8', 'diaryImage\\3.jpg', '19');
INSERT INTO `photo` VALUES ('9', 'diaryImage\\4.jpg', '19');
INSERT INTO `photo` VALUES ('10', 'diaryImage\\5.jpg', '19');
INSERT INTO `photo` VALUES ('11', 'diaryImage\\6.jpg', '19');
INSERT INTO `photo` VALUES ('12', 'diaryImage\\7.jpg', '19');
INSERT INTO `photo` VALUES ('13', 'diaryImage\\8.jpg', '19');
INSERT INTO `photo` VALUES ('14', 'diaryImage\\9.jpg', '19');
INSERT INTO `photo` VALUES ('15', 'diaryImage\\10.jpg', '19');
INSERT INTO `photo` VALUES ('16', 'diaryImage\\1.jpg', '19');
INSERT INTO `photo` VALUES ('17', 'diaryImage\\3.jpg', '19');
INSERT INTO `photo` VALUES ('18', 'diaryImage\\6.jpg', '19');
INSERT INTO `photo` VALUES ('20', 'diaryImage\\1324518036811.jpg', '143');
INSERT INTO `photo` VALUES ('21', 'diaryImage\\angel_18-wallpaper-1920x1080.jpg', '143');
INSERT INTO `photo` VALUES ('22', 'diaryImage\\ballet-wallpaper-1920x1080.jpg', '143');
INSERT INTO `photo` VALUES ('23', 'diaryImage\\beautiful_girl_4-wallpaper-1920x1080.jpg', '143');
INSERT INTO `photo` VALUES ('24', 'diaryImage\\blonde_girl_on_the_beach-wallpaper-1920x1080.jpg', '143');
INSERT INTO `photo` VALUES ('25', 'diaryImage\\3.jpg', '143');
INSERT INTO `photo` VALUES ('26', 'diaryImage\\1.jpg', '21');
INSERT INTO `photo` VALUES ('27', 'diaryImage\\6.jpg', '20');
INSERT INTO `photo` VALUES ('28', 'diaryImage\\ChMkJ1diS1iId7DNAAqYUHeMHIAAASqZgOtA3oACpho409.jpg', '23');
INSERT INTO `photo` VALUES ('29', 'diaryImage\\ChMkJlaYn4iIa-rvAAnzSvEECAsAAHUlAEGjwAACfNi365.jpg', '22');
INSERT INTO `photo` VALUES ('30', 'diaryImage\\ChMkJlXeeBWIEReWAAQWp73uscUAABazAEZb6gABBa_974.jpg', '31');
INSERT INTO `photo` VALUES ('31', 'diaryImage\\freedom_2-wallpaper-1920x1080.jpg', '32');
INSERT INTO `photo` VALUES ('32', 'diaryImage\\4.jpg', '33');
INSERT INTO `photo` VALUES ('33', 'diaryImage\\Greece_Santorini_Notio_Aigaio_Oia_sunset_house_szeke_photography_1920x1280.jpg', '80');
INSERT INTO `photo` VALUES ('35', 'diaryImage\\4.jpg', '148');
INSERT INTO `photo` VALUES ('36', 'diaryImage\\legs_barefoot_Wallpaper_1920x1080_www.wall321.com.jpg', '149');
INSERT INTO `photo` VALUES ('37', 'diaryImage\\8.jpg', '150');
INSERT INTO `photo` VALUES ('38', 'diaryImage\\Maserati-GT-supercar-front-view_1920x1080.jpg', '151');
INSERT INTO `photo` VALUES ('48', 'diaryImage\\8.jpg', '168');
INSERT INTO `photo` VALUES ('49', 'img/1.jpg', '166');
INSERT INTO `photo` VALUES ('50', 'diaryImage\\Maserati-GT-supercar-front-view_1920x1080.jpg', '168');
INSERT INTO `photo` VALUES ('51', 'diaryImage\\4.jpg', '168');

-- ----------------------------
-- Table structure for recommend
-- ----------------------------
DROP TABLE IF EXISTS `recommend`;
CREATE TABLE `recommend` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `local` varchar(200) NOT NULL,
  `content` text NOT NULL,
  `type_` int(11) NOT NULL COMMENT '1是景点\r\n2是食物\r\n3是商业街',
  `image` varchar(999) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of recommend
-- ----------------------------
INSERT INTO `recommend` VALUES ('1', '从化温泉', '广东广州', '从化区位于广东省广州市东北面，东与龙门县、增城区接壤，南跟白云区毗邻，西和清远市、花都区交界，北面同佛冈、新丰县相连。北回归线横跨境内南端的太平镇，气候温和，雨量充沛。\r\n从化区以珍稀温泉闻名于世，有“中国温泉之都”之美称，且素有“北回归线上的明珠”和“广州后花园”之誉。境内有100多个湖泊水库，12万公顷青山，森林覆盖率67.2%。有旅游景区近20处，包括碧水湾温泉度假村、广州抽水蓄能电厂旅游度假区等国家4A级和3A旅游景区，流溪河国家森林公园、石门国家森林公园、流溪温泉旅游度假区和抽水蓄能电厂旅游区等4个广州重点生态旅游区以及广裕祠、五岳殿等国家、省级重点文物保护单位，以及新石器时代的吕田狮象岩人居遗迹、明朝时期的众多古村落文物古迹、世界最高的北回归线标志塔等一批文化景观。\r\n从化区先后获得“省文明城市”、“省教育强市”、“省林业生态县”、“全国农村中医工作先进市”、“中国文化生态旅游示范地”、“中国最佳旅游度假胜地”、“中国优秀生态旅游城市”和“广东省国民旅游休闲计划示范市”等称号。', '1', 'diaryImage\\5.jpg');
INSERT INTO `recommend` VALUES ('2', '丽江千古情景区', '云南丽江', '丽江千古情景区距丽江古城6公里，毗邻文笔海自然景观，与玉龙雪山遥相呼应，地理环境优越。\r\n·旅游区深度挖掘丽江独特的本土文化元素，打造了以《丽江千古情》、《丽江恋歌》等为代表的十大演艺秀与二十大项目。\r\n·景区内随处可见展示丽江千年文化历史风情的歌舞演出，是一座穿越时空、活着的茶马古城，是丽江旅游的理想目的地。', '1', 'diaryImage\\5.jpg');
INSERT INTO `recommend` VALUES ('3', '西安城墙', '陕西西安', '又称西安明城墙，全长13.7千米，是中国现存规模最大，保存最完整的古代城垣。\r\n与平遥城墙、荆州城墙、兴城城墙等并列为中国现存最完好的四座古城墙。\r\n主城门东、南、西、北依次为长乐门、永宁门、安定门、安远门。民国开始为方便出入，先后建设了多座城门，至今西安城墙已有城门18座。\r\n城墙周围有护城河环绕，著名的西安钟鼓楼就位于城墙中心。', '1', 'diaryImage\\5.jpg');
INSERT INTO `recommend` VALUES ('4', '总统府', '江苏南京', '南京总统府迄今已有600多年历史，这里不仅是国民政府中央所在地，也见证着太平天国与两江总督衙门的兴衰。\r\n在这里，中西结合的院落，西式的办公楼，中式的花园，保留了江南古典园林一样的格局，亭台楼阁，小桥流水。\r\n总统府分三个区域，中区（中轴线）主要是国民政府总统府及所属机构。\r\n西区是孙中山的临时大总统办公室、秘书处和西花园，以及参谋本部等。\r\n东区主要是行政院旧址、马厩和东花园。一系列展馆和史料陈列，分布在这三个区域中。 ', '1', 'images\\zong.jpg');
INSERT INTO `recommend` VALUES ('5', '鸭血粉丝汤', '江苏南京', '在南京，卖鸭血粉丝汤的摊子星罗棋布，从路边的小吃摊，到成规模的连锁店。可以毫不夸张的说，没吃过南京的鸭血粉丝就等于没来过南京，最有名的要算是回味鸭血粉丝，除此之外，石记鸭血粉丝汤、金源鸭血粉丝、永和园鸭血粉丝汤、鸭得堡鸭血粉丝和金源鸭血粉丝都算是南京鸭血粉丝汤的名店。\r\n精明的摊主预先将鸭血煮熟，切成小块放在锅中，见有游客来，便捞出鸭血装在白瓷碗里，然后浇上一勺滚烫的鲜汤，滴上数滴香油，撒上一撮虾米和鸭肝鸭肠衣等，再点上一撮香菜。爱吃辣的客人，还可以再加上些辣椒油或胡椒，又香、又辣、可口的味。\r\n鸭血粉丝名店：\r\n回味鸭血粉丝（湖南路店）、石记鸭血粉丝汤、永和园、鸭得堡\r\n金源鸭血粉丝：玄武区锁金村医院东，近南师大紫金校区，另有多家分店。', '2', 'images\\ya.jpg');
INSERT INTO `recommend` VALUES ('6', '苏州博物馆', '江苏苏州', '传统的苏州园林风格，高低错落，深灰色屋面与白墙相衬，整个博物馆宛若一座小园林。\r\n由新馆和忠王府(旧馆)两部分组成，新馆内可看到远古到近代的陶器、玉器、书画等文物；忠王府内，能看到秀丽典雅的苏式彩绘。\r\n馆内设有吴地遗珍、吴塔国宝、吴中风雅、吴门书画四个富有苏州特色的常设展览。\r\n此外还有民俗展览供游客了解苏州一带风俗习惯，还可以参观太平天国时古建筑，感受当时的场景。 ', '1', 'images\\su.jpg');
INSERT INTO `recommend` VALUES ('7', '鼋头渚', '江苏无锡', '鼋头渚是太湖北部的一处半岛，形似浮鼋翘首而得名，有“太湖第一名胜”之称。\r\n岛上有道教仙宫和道、佛两教石窟塑像，还有诸多古迹和旧时名流显贵所建的私家园林。\r\n可以游览园林群、泛舟太湖、品赏樱花，体会郭沫若所赞“太湖佳绝处、毕竟鼋头渚”的意境。\r\n景区主要由鼋头渚半岛、太湖仙岛、中犊山组成。充山大门（正大门，景区东南部）可进可出，犊山大门（景区北部）只出不进。\r\n推荐精华游法：游船码头-太湖仙岛-太湖佳绝处-横云山庄-鼋渚春涛-广福寺-鹿顶山。另外，万浪桥是观赏太湖落日的好地方噢。\r\n每年3月中旬至5月初举办鼋头渚国际樱花节，推荐樱花谷、充山隐秀、长春桥一带踏青赏樱。 ', '1', 'images\\gui.jpg');
INSERT INTO `recommend` VALUES ('8', '灵山胜境风景区', '江苏无锡', '灵山胜境位于江苏省无锡市的太湖之滨，是国家AAAAA级旅游景区。\r\n这里由小灵山、祥符禅寺、灵山大佛及分布于其间的其他景点所组成，可简单概括为一山、一寺、一佛。\r\n灵山胜境集湖光山色、园林广场、佛教文化、历史知识于一体，是中国最为完整、也是唯一集中展示释迦牟尼成就的佛教文化主题园', '1', 'images\\ling.jpg');
INSERT INTO `recommend` VALUES ('9', '拈花湾', '江苏无锡', '灵山小镇拈花湾与灵山胜境毗邻，小镇风格仿古，以禅意为主题。\r\n一幢幢米色、白色的建筑覆盖着青色的大坡顶，门窗和柱子多用木头制成，镇中点缀着小桥流水和园林小景，特别适合来此度假放松，修身养性。\r\n白天可以看看禅乐馆、百花堂、妙音台、拈花堂、拈花塔等建筑，逛逛工艺品小店，逛累了可以坐下来吃吃喝喝。晚上可以拍摄拈花湾寂静的夜景，看看拈花湖上奇特的3D水幕电影。', '1', 'images\\nie.jpg');
INSERT INTO `recommend` VALUES ('10', '惠山古镇', '江苏无锡', '惠山古镇位于无锡锡惠公园北边，由大片古祠堂组成。祠堂建筑群始建于唐，盛于明清，现在看到的多是清代祠堂。\r\n由南北走向的横街和东西走向的直街围成，街上布满了各色店铺和一些小景点。\r\n祠堂主要集中在龙头河沿岸和直街上，其中杨藕芳祠比较特别，融入西式建筑风格。\r\n推荐参观中国泥人博物馆，还能亲自动手，别有一番情趣。\r\n古镇的美食也不容错过，惠山豆腐花经常排队；还有上过《舌尖上的中国》的忆秦园小笼包，蟹粉小笼是招牌。\r\n进入古镇免费，只有参观一些小景点才需要门票。 ', '1', 'images\\hui.jpg');
INSERT INTO `recommend` VALUES ('11', '牛肉锅贴', '江苏南京', '外脆里嫩、馅足汁多、咸中带甜是南京牛肉锅贴的最大特色。因为汁多，老主顾都把吃汤包的用到了这锅贴上。第一口咬大了汁会漏；咬猛了汁会喷；咬太小又不过瘾。 一说锅贴，老南京都会脱口而出“七家湾”！上百年的经营，七家湾地区的几十家清真店老板已经将这个普通地名打造成了清真食品共有的大品牌。由于区划调整和拆迁，不少老字号的清真饮食店陆续搬离了原址，在其他地方“另起炉灶”。', '2', 'images\\niu.jpg');
INSERT INTO `recommend` VALUES ('12', '盐水鸭', '江苏南京', '\r\n\r\n要问到南京最值得吃的是什么，十个南京人中十个会告诉你是盐水鸭，而一讲到南京菜，就必讲鸭，其实全国各地都会制作盐水鸭，为何南京的盐水鸭最好吃?鸭子质优是一个原因，另一个原因是南京的盐水鸭有着与众不同的制作过程。生活在山清水秀里的南京鸭子宰杀过以后，重量一般控制在三斤八两到四斤重，并且要求没有破损，没有瘀血，没有斑疖。之后制作步骤要求也很高，把热盐填入鸭腹并用热盐擦遍鸭身。\r\n\r\n制作过程必须遵守规定的时间，腌制两个小时然后要在百年的老卤中浸泡两小时，之后再经过挂，吹，卤等一系列工序。\r\n板鸭和盐水鸭的区别\r\n\r\n很早以前的南京人吃的大多其实是板鸭，始于六朝的板鸭经过老卤腌制过以后做熟，吃起来紧密咸香，余味回甜。后人因条件限制，有的腌制复卤期变得更短，卤出来的鸭子肉质更细嫩一些，皮白肉嫩，而且现做现卖，现买现吃，这便成就了南京盐水鸭。所以买盐水鸭的时候要看日期，越新鲜的自然越好。\r\n鸭子的无数种吃法\r\n\r\n南京人的制鸭技术由来已久，除了盐水鸭之外，还有板鸭、金陵叉烤鸭、黄焖鸭、烧鸭、酱鸭、香酥鸭、茄汁鸭、松子鸭卷、八宝珍珠鸭等，再加上精心炮制的内脏、爪翅与鸭血，餐馆里推出全鸭席一点也不难。\r\n\r\n代表店铺：可以毫不夸张地说，几乎南京每家餐厅都能吃到盐水鸭，其中以梅苑餐厅和清真韩复兴板鸭店（外卖）的最为有名。\r\n', '2', 'images\\yan.jpg');
INSERT INTO `recommend` VALUES ('13', '赤豆元宵', '江苏南京', '赤豆元宵虽然哪里都有，但是南京土著却对这碗平常的赤豆元宵格外有感情，最有名的莫过于莲湖糕团店，这家店虽然名字叫糕团店，但最受欢迎的却是这莲子赤豆元宵，浓浓稠稠的一大碗，用红豆沙煮小元宵和莲子，再用藕粉勾芡，用“软糯香甜”形容真是当之无愧！所有进店的人，几乎都会先来碗赤豆元宵，然后再点些汤面，或者锅贴糕团。', '2', 'images\\chi.jpg');
INSERT INTO `recommend` VALUES ('14', '桂花糖芋苗', '江苏南京', '\r\n\r\n桂花糖芋苗是南京一道出名的甜点，和\"桂花蜜汁藕、梅花糕、赤豆酒酿小圆子”一同被誉为金陵南京四大最有人情味街头小食。光洁的芋苗口感润滑爽口、香甜酥软，汤汁呈酱红色鲜亮诱人，散发着浓郁的桂花香，吃后唇齿留香。\r\n在旧时的老南京城中，常见小贩挑担走街穿巷叫卖于街头巷尾，每听到叫卖声，大人们便会拿个碗或小铝锅，馋嘴的小孩子跟着大人后面，看小贩如何娴熟地接锅（碗）、掀盖、取勺、下舀、入锅、接钱、找零，一丝不乱、一步不错，有时会看呆了。\r\n\r\n推荐品尝地：桂花糖芋苗现在仍是南京大街小巷内的美食，一些甜食店甚至是路边小摊都可以看到他，南京的餐饮名店如南京大牌档、芳婆糕团店、莲湖糕团店内也少不了它。\r\n', '2', 'images\\gui.jpg');
INSERT INTO `recommend` VALUES ('15', '南京西路恒隆广场', '江苏南京', '南京西路恒隆广场位于静安区南京西路北侧的1266号，陕西北路与西康路之间。有5层楼面，面积为5.5万平方米，集中了一批世界知名时尚品牌的旗舰店，包括Hermes，LouisVuitton，Cartier，Chanel，Dior，Celine，Escada，Bvlgari，Fendi，Loewe，Prada，Versace，Lanvin等。匠匠认为它是上海最大，也是中国的奢侈品购物地！', '3', 'images\\nan.jpg');
INSERT INTO `recommend` VALUES ('16', '北京新光天地百货', '中国北京', '北京新光天地百货由台湾新光三越百货公司与北京华联集团合资成立的第一家百货店，双方各占50%股份，总资本额7.5亿元人民币，现台湾方面已全面撤资，由北京华联集团独立经营。坐落在长安街东沿线大望桥东北角的新光天地，紧临四环路，与京通快速路、地铁主干线相连，交通非常便利。', '3', 'images\\bei.jpg');
INSERT INTO `recommend` VALUES ('17', '香港太古广场', '中国香港', '香港太古广场是一个地产项目，位于香港香港岛金钟金钟道85-87号，由香港英资地产商太古地产兴建，是香港一个综合性商业物业。太古广场共分3期，有3座办公大楼、3间五星级酒店、一间精致豪华酒店、服务式住宅、商场及停车场等。', '3', 'images\\xiang.jpg');
INSERT INTO `recommend` VALUES ('18', '丽柏广场', '广东广州', '丽柏广场坐落于广州环市东路黄金商圈，以LaPerle的法语译音命名，致力于营造华南地区超凡高雅的购物环境，构筑世界顶级品牌的T台，打造精英荟萃之所，以出尘品位和顶级服务吸引高端消费群体，成为城中时尚潮人追捧的典雅殿堂。', '3', 'images\\li.jpg');
INSERT INTO `recommend` VALUES ('19', '深圳华润中心', '广东深圳', '华润集团在深圳投资开发的“深圳华润中心”，于 2004 年 12 月竣工开业。是集零售、餐饮、娱乐、办公、酒店、居住等诸多功能于一体的大规模、综合性、现代化、高品质的标志性商业建筑群。它整合了百货公司、国际品牌旗舰店、时尚精品店、美食广场、奥运标准室内溜冰场、大型动感游乐天地、多厅电影院等元素，为深圳居民及游客提供一站式购物、休闲、餐饮、娱乐服务。', '3', 'images\\shen.jpg');
INSERT INTO `recommend` VALUES ('20', '德基广场', '江苏南京', '德基广场位于南京市玄武区中山路18号，坐落在“中华第一商圈”新街口东北角，是一个定位于高端商业的综合购物中心。其地下部分与“亚洲第一大地铁站”新街口站相连通。2015年中国购物中心销售额排名，南京德基广场2015年以总业绩70.2亿位居第一，是2015年中国最赚钱的购物中心。', '3', 'images\\de.jpg');
INSERT INTO `recommend` VALUES ('21', '杭州大厦', '江苏杭州', '杭州大厦位于杭城繁华的商贸、文化、交通中心的武林广场，集购物、酒店、商务、娱乐等多功能于一体的购物城，拥有齐全的商品品类、高档的国际国内品牌、优雅的购物环境、优质的高端特色服务，配套设施也非常完善，是一座真正意义上的全方位、多元化、多业态的大型Shopping Mall。匠匠的奢侈品维修店就在杭州大厦哦！', '3', 'images\\hang.jpg');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(20) NOT NULL auto_increment,
  `UserName` varchar(20) default NULL,
  `passwd` varchar(20) default NULL,
  `sex` varchar(20) default NULL,
  `Email` varchar(20) default NULL,
  `IndividualResume` varchar(255) default NULL,
  `image` varchar(255) default NULL,
  `site` varchar(255) default NULL,
  `state` int(11) NOT NULL default '1' COMMENT '1是正常，2是被禁用',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('12', 'yht', '123123', 'girl', '1376261775@qq.com', '一个网络工程专业的学生，热爱编程，专攻于网络应用开发方向，好好学习。', 'head/12.jpg', '湖南郴州', '1');
INSERT INTO `user` VALUES ('13', 'zhougong', '123123', 'men', 'test@qq.com', '一个网络工程专业的学生，热爱编程，专攻于网络应用开发方向，好好学习。努力向上123', 'head/13.jpg', '地址', '1');
INSERT INTO `user` VALUES ('14', '355', '123123', 'men', '1', 'GG', 'head/14.jpg', null, '2');
INSERT INTO `user` VALUES ('15', '13', '13', 'men', '14', 'wo shi xuesheng', 'images/4.jpg', null, '1');
INSERT INTO `user` VALUES ('16', '14', '14', 'men', 'aa@qq.com', 'woshixuesheng', 'images/4.jpg', null, '1');
INSERT INTO `user` VALUES ('17', '16', '16', 'men', 'dd@qq.com', 'woshixuesheng', 'images/4.jpg', null, '1');
INSERT INTO `user` VALUES ('18', 'cece', '123123', 'men', '123@qq.com', '123', 'images/4.jpg', null, '1');
INSERT INTO `user` VALUES ('19', 'ccccc', '123123', 'men', '1376261775@qq.com', 'sdf', 'images/4.jpg', null, '1');
INSERT INTO `user` VALUES ('20', 'wuzhuhao', '123123', 'men', '1376261775@qq.com', 'sdf', 'images/4.jpg', null, '1');
INSERT INTO `user` VALUES ('21', 'cds', '123123', 'men', '123@qq.com', '123', 'images/4.jpg', null, '1');
INSERT INTO `user` VALUES ('22', '1231ec', '123123', 'men', '1376261775@qq.com', '123', 'images/4.jpg', null, '1');
INSERT INTO `user` VALUES ('23', 'ye1', '1123123', 'girl', '1376261775@qq.com', 'ceshi', 'images/4.jpg', null, '1');
INSERT INTO `user` VALUES ('24', 'wzh', '123123', 'girl', '1376261775@qq.com', '123123', 'images/4.jpg', null, '1');
INSERT INTO `user` VALUES ('25', 'ye11', '123123', 'men', '1376261775@qq.com', '123', 'images/4.jpg', null, '2');
INSERT INTO `user` VALUES ('26', 'test123', '123123', 'men', '1376261775@qq.com', '123', 'images/4.jpg', null, '1');
INSERT INTO `user` VALUES ('27', 'wuzhuhao123', '123123', 'girl', '1376261775@qq.com', '', 'images/4.jpg', '测试地址123', '1');
INSERT INTO `user` VALUES ('28', 'wuzhuhao1211', '123123', 'men', '1376261775@qq.com', '', 'images/4.jpg', null, '1');

-- ----------------------------
-- Table structure for usermessage
-- ----------------------------
DROP TABLE IF EXISTS `usermessage`;
CREATE TABLE `usermessage` (
  `id` int(11) NOT NULL auto_increment,
  `content` varchar(999) default NULL,
  `replyContent` varchar(999) default NULL,
  `sendId` int(11) NOT NULL,
  `sendeeId` int(11) NOT NULL,
  `sendTime` varchar(100) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FKC3B449DCBEB4086` (`sendeeId`),
  KEY `FKC3B449DC8B891DE6` (`sendId`),
  CONSTRAINT `FKC3B449DC8B891DE6` FOREIGN KEY (`sendId`) REFERENCES `user` (`id`),
  CONSTRAINT `FKC3B449DCBEB4086` FOREIGN KEY (`sendeeId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of usermessage
-- ----------------------------
INSERT INTO `usermessage` VALUES ('10', '阿斯蒂芬', '撒地方', '15', '13', '2019-03-20 00:53:35');
INSERT INTO `usermessage` VALUES ('18', '测试留言', null, '12', '15', '2019-03-24 00:53:35');
INSERT INTO `usermessage` VALUES ('27', '测试留言', null, '17', '19', '2019-03-25 17:20:05');
INSERT INTO `usermessage` VALUES ('28', '测试留言1', null, '18', '20', '2019-03-25 17:20:11');
INSERT INTO `usermessage` VALUES ('29', '测试留言2', null, '12', '21', '2019-03-25 17:20:16');
INSERT INTO `usermessage` VALUES ('33', '测试留言', null, '12', '22', '2019-04-02 23:46:26');
INSERT INTO `usermessage` VALUES ('34', '爱吃的撒', null, '12', '13', '2019-05-20 16:47:57');
DROP TRIGGER IF EXISTS `delDPhoto`;
DELIMITER ;;
CREATE TRIGGER `delDPhoto` BEFORE DELETE ON `ddiary` FOR EACH ROW  DELETE FROM dphoto where did = OLD.did
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `delDAll`;
DELIMITER ;;
CREATE TRIGGER `delDAll` BEFORE DELETE ON `diary` FOR EACH ROW    BEGIN  
DELETE FROM comment_ where did = OLD.did;
DELETE FROM photo where did = OLD.did;
DELETE FROM like_diary where diary_id = OLD.did;
end
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `add`;
DELIMITER ;;
CREATE TRIGGER `add` AFTER INSERT ON `like_diary` FOR EACH ROW   update diary set likenum = likenum+1 where did = NEW.diary_id
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `delUAll`;
DELIMITER ;;
CREATE TRIGGER `delUAll` BEFORE DELETE ON `user` FOR EACH ROW    BEGIN  
DELETE FROM diary where Uid = OLD.id;
DELETE FROM ddiary where Uid = OLD.id;
DELETE FROM comment_ where Uid = OLD.id;
DELETE FROM message where Uid = OLD.id;
DELETE FROM usermessage where sendId = OLD.id or sendeeId = OLD.id;
DELETE FROM like_diary where user_id = OLD.id;
end
;;
DELIMITER ;
