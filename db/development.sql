SQLite format 3   @    f            á                                                f -æ	   ö    ûöñ ©                    )= 	WtablePoli)= indexsqlite_autoindex_Users_1Users`	tableSessionsSes WtablePoliciesPoliciesCREATE TABLE `Policies` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` VARCHAR(255) NOT NULL, `description` TEXT NOT NULL, `createdAt` DATETIME NOT NULL, `updatedAt` DATETIME NOT NULL)m-tableContactsContactsCREATE TABLE `Contacts` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` VARCHAR(255), `email` VARCHAR(255) NOT NULL, `body` VARCHAR(255) NOT NULL, `createdAt` DATETIME NOT NULL, `updatedAt` DATETIME NOT NULL)P++Ytablesqlite_sequencesqlite_sequenceCREATE TABLE sqlite_sequence(name,seq)o9tablePeoplePeopleCREATE TABLE `People` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` VARCHAR(255), `email` VARCHAR(255), `password` VARCHAR(255), `image` VARCHAR(255), `createdAt` DATETIME NOT NULL, `updatedAt` DAT   	w   	x   t   
 4 ºTî"¼V ð  4                        \
 3 IIYuujiyuuji@aimerthyst.co2015-07-03 15:13:51.357 +00:002015-07-03 15:13:51.357 +00:00\	 3 IIYuujiyuuji@aimerthyst.co2015-07-03 14:47:08.540 +00:002015-07-03 14:47:08.540 +00:00d 3 IIYuujiyuuji@aimerthyst.copassword2015-07-03 14:46:57.131 +00:002015-07-03 14:46:57.131 +00:00d 3 IIYuujiyuuji@aimerthyst.copassword2015-07-03 14:46:55.406 +00:002015-07-03 14:46:55.406 +00:00d 3 IIYuujiyuuji@aimerthyst.copassword2015-07-03 14:38:32.312 +00:002015-07-03 14:38:32.312 +00:00d 3 IIYuujiyuuji@aimerthyst.copassword2015-07-03 14:37:39.795 +00:002015-07-03 14:37:39.795 +00:00d 3 IIYuujiyuuji@aimerthyst.copassword2015-07-03 14:37:20.336 +00:002015-07-03 14:37:20.336 +00:00d 3 IIYuujiyuuji@aimerthyst.copassword2015-07-03 14:36:56.150 +00:002015-07-03 14:36:56.150 +00:00d 3 IIYuujiyuuji@aimerthyst.copassword2015-07-03 14:36:00.364 +00:002015-07-03 14:36:00.364 +00:00D     II2015-07-03 14:33:39.035 +00:002015-07-03 14:33:39.035 +00:00   Þ ôÞéÒ                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     	Comme		Users	Users	Posts
People
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
      
                  
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            +ug@aimethyst.co3	yuuji@aimerthyst.co                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ¼±  0ttableUsersUsers
CREATE TABLE `Users` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` VARCHAR(255) NOT NULL, `email` VARCHAR(255) UNIQUE, `password` VARCHAR(255) NOT NULL, `image` VARCHAR(255), `uniq_session_id` VARCHAR(255) NOT NULL, `last_login` DATETIME DEFAULT '2015-07-09 11:11:04.375 +00:00', `description` TEXT, `created_at` DATETIME NOT NULL, `updated_at` DATETIME NOT NULL, `deleted_at` DATETIME)s%%StableDescriptionsDescriptionsCREATE TABLE `Descriptions` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `body` TEXT, `created_at` DATETIME NOT NULL, `updated_at` DATETIME NOT NULL, `user_id` INTEGER REFERENCES `Users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE)P++Ytablesqlite_sequencesqlite_sequenceCREATE TABLE sqlite_sequence(name,seq)o9tablePeoplePeopleCREATE TABLE `People` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` VARCHAR(255), `email` VARCHAR(255), `password` VARCHAR(255), `image` VARCHAR(255), `createdAt` DATETIME NOT NULL, `updatedAt` DATETIME NOT NULL)    N Õ> N -m& <;m;mo-tableContactsContactsCREATE TABLE `Comx-tableContactsContactsCREATE TABLE `Contacts` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` VARCHAR(255), `email` VARCHAR(255) NOT NULL, `body` VARCHAR(255) NOT NULL, `createdAt` DATETIME NOT NULL, `updatedAt` DATETIME NOT NULL)WwtableCommentsCommentsCREATE TABLE `Comments` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `body` TEXT NOT NULL, `created_at` DATETIME NOT NULL, `updated_at` DATETIME NOT NULL, `user_id` INTEGER REFERENCES `Users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE, `post_id` INTEGER REFERENCES `Posts` (`id`) ON DELETE SET NULL ON UPDATE CASCADE):vStablePostsPostsCREATE TABLE `Posts` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `body` TEXT NOT NULL, `user_name` VARCHAR(255) NOT NULL, `user_image` VARCHAR(255), `created_at` DATETIME NOT NULL, `updated_at` DATETIME NOT NULL, `user_id` INTEGER REFERENCES `Users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE))u= indexsqlite_autoindex_Users_1Users   û    û                                                                                                                               -QI II UGug@aimerthyst.cocd642f5372e93f00332719baa21e94bf3e4e022841d804b3d69a06c3c37e85ee0deca5c5cff7e5843ef743b5ca3a2f7021333d4559e7c19a420554be48ace7a0/uploads/images/25856173878120.jpge7c45ec965dbb0a02dea68a92691103ee043c31b59eca612f1ba9f00dbd23f9886b082393fbc64876b7163319ad0a3b5515230ab7f73d1b5cc27b6d62cecdcc32015-07-09 14:58:10.980 +00:002015-07-09 15:00:59.559 +00:002015-07-09 15:01:44.352 +00:00R %1QIaII å¢å°¾è£å¸info@aimerthyst.cocd642f5372e93f00332719baa21e94bf3e4e022841d804b3d69a06c3c37e85ee0deca5c5cff7e5843ef743b5ca3a2f7021333d4559e7c19a420554be48ace7a0/uploads/images/25856139178134.jpg41637335c1e866a8c5794ad508f9b703e0a1b3db298a1ac84fc3a51bd4a9fa49080bfd35607a65d2f0dad393511b3ca0bcbd68fe4213dfbf0a971c17ab6b40b32015-07-09 11:07:48.165 +00:00ãã­ãã£ã¼ã«æ©è½ãè¿½å ããï¼2015-07-09 11:11:26.837 +00:002015-07-09 14:29:36.603 +   
   § ¾ê§Õ                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       1name@aimerhtyst.co1aimer@aimrthyst.co-ug@aimerthyst.co1	info@aimerthyst.co   û    ûm Ø T                                                               +%QII	ããããï¼å¢å°¾è£å¸/uploads/images/25856139178134.jpg2015-07-09 15:00:12.205 +00:002015-07-09 15:00:12.205 +00:00 M%QII	æ¸ãè¾¼ã¿ã¼(ã»âã»)ï¼ï¼å¢å°¾è£å¸/uploads/images/25856139178134.jpg2015-07-09 14:59:41.211 +00:002015-07-09 14:59:41.211 +00:00 S%QII	æ¬¡ãæ¸ãè¾¼ã¿(ã»âã»)ï¼ï¼å¢å°¾è£å¸/uploads/images/25856139178134.jpg2015-07-09 14:58:21.559 +00:002015-07-09 14:58:21.559 +00:00 M%QII	ãããã¼ã¿(ã»âã»)ï¼ï¼å¢å°¾è£å¸/uploads/images/25856139178134.jpg2015-07-09 14:41:49.924 +00:002015-07-09 14:41:49.924 +00:00 +%QII	write new imageå¢å°¾è£å¸/uploads/images/25856139178134.jpg2015-07-09 14:41:00.283 +00:002015-07-09 14:41:00.283 +00:00h =% II	ãããããã¼ãï¼å¢å°¾è£å¸2015-07-09 11:11:48.098 +00:002015-07-09 11:11:48.098 +00:00v Y% II	ãªã«ãæ¸ãè¾¼ããã§(ã»âã»)å¢å°¾è£å¸2015-07-09 11:11:38.028 +00:002015-07-09 11:11:38.028 +                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 T m Ø T                                                               +%QII	ããããï¼å¢å°¾è£å¸/uploads/images/25856139178134.jpg2015-07-09 15:00:12.205 +00:002015-07-09 15:00:12.205 +00:00 M%QII	æ¸ãè¾¼ã¿ã¼(ã»âã»)ï¼ï¼å¢å°¾è£å¸/uploads/images/25856139178134.jpg2015-07-09 14:59:41.211 +00:002015-07-09 14:59:41.211 +00:00 S%QII	æ¬¡ãæ¸ãè¾¼ã¿(ã»âã»)ï¼ï¼å¢å°¾è£å¸/uploads/images/25856139178134.jpg2015-07-09 14:58:21.559 +00:002015-07-09 14:58:21.559 +00:00 M%QII	ãããã¼ã¿(ã»âã»)ï¼ï¼å¢å°¾è£å¸/uploads/images/25856139178134.jpg2015-07-09 14:41:49.924 +00:002015-07-09 14:41:49.924 +00:00 +%QII	write new imageå¢å°¾è£å¸/uploads/images/25856139178134.jpg2015-07-09 14:41:00.283 +00:002015-07-09 14:41:00.283 +00:00h =% II	ãããããã¼ãï¼å¢å°¾è£å¸2015-07-09 11:11:48.098 +00:002015-07-09 11:11:48.098 +00:00v Y% II	ãªã«ãæ¸ãè¾¼ããã§(ã»âã»)å¢å°¾è£å¸2015-07-09 11:11:38.028 +00:002015-07-09 11:11:38.028 +00:00    ´ &è ´ ô                                                                                                                                                                    1{1tableTimelinesTimelinesCREATE TABLE `Timelines` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `model_name` VARCHAR(255) NOT NULL, `model_id` INTEGER NOT NULL, `createdAt` DATETIME NOT NULL, `updatedAt` DATETIME NOT NULL, `user_id` INTEGER REFERENCES `Users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE);zItableSessionsSessionsCREATE TABLE `Sessions` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `session_id` VARCHAR(255) NOT NULL, `logout` TINYINT(1) NOT NULL DEFAULT 0, `created_at` DATETIME NOT NULL, `updated_at` DATETIME NOT NULL, `user_id` INTEGER REFERENCES `Users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE)WytablePoliciesPoliciesCREATE TABLE `Policies` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` VARCHAR(255) NOT NULL, `description` TEXT NOT NULL, `createdAt` DATETIME NOT NULL, `updatedAt` DATETIME NOT NULL)    ) züU À )                    Q%QII	æ¸ãè¾¼ã¿ï¼
å¤æ®µã§
SocketIOå¢å°¾è£å¸/uploads/images/25856139178134.jpg2015-07-10 01:58:31.336 +00:002015-07-10 01:58:31.336 +00:00 M%QII	ä»æ¥ã¯
DQNã
å¤ããªã...å¢å°¾è£å¸/uploads/images/25856139178134.jpg2015-07-10 01:53:35.189 +00:002015-07-10 01:53:35.189 +00:00$ q%QII	è¤æ°è¡ã«æ¸¡ã
æ¸ãè¾¼ã¿ã
å®æ½ããï¼å¢å°¾è£å¸/uploads/images/25856139178134.jpg2015-07-10 00:57:56.631 +00:002015-07-10 00:57:56.631 +00:00| !%QII	kakikomi-
å¢å°¾è£å¸/uploads/images/25856139178134.jpg2015-07-10 00:57:37.881 +00:002015-07-10 00:57:37.881 +00:00

 =%QII	ããããããªï¼ï¼å¢å°¾è£å¸/uploads/images/25856139178134.jpg2015-07-10 00:56:52.213 +00:002015-07-10 00:56:52.213 +00:00	 M%QII	ãããã¿ã¼(ã»âã»)ï¼ï¼å¢å°¾è£å¸/uploads/images/25856139178134.jpg2015-07-10 00:56:38.840 +00:002015-07-10 00:56:38.840 +00:00b C IIãã£ã¡ããæ¸ãè¾¼ã¿UG2015-07-09 15:01:30.049 +00:002015-07-09 15:01:30.049 +00:00     +                                                                                                                                  -QI II UGug@aimerthyst.cocd642f5372e93f00332719baa21e94bf3e4e022841d804b3d69a06c3c37e85ee0deca5c5cff7e5843ef743b5ca3a2f7021333d4559e7c19a420554be48ace7a0/uploads/images/25856173878120.jpge7c45ec965dbb0a02dea68a92691103ee043c31b59eca612f1ba9f00dbd23f9886b082393fbc64876b7163319ad0a3b5515230ab7f73d1b5cc27b6d62cecdcc32015-07-09 14:58:10.980 +00:002015-07-09 15:00:59.559 +00:002015-07-09 15:01:44.352 +00:00R %1QIaII å¢å°¾è£å¸info@aimerthyst.cocd642f5372e93f00332719baa21e94bf3e4e022841d804b3d69a06c3c37e85ee0deca5c5cff7e5843ef743b5ca3a2f7021333d4559e7c19a420554be48ace7a0/uploads/images/25856139178134.jpg41637335c1e866a8c5794ad508f9b703e0a1b3db298a1ac84fc3a51bd4a9fa49080bfd35607a65d2f0dad393511b3ca0bcbd68fe4213dfbf0a971c17ab6b40b32015-07-09 11:07:48.165 +00:00ãã­ãã£ã¼ã«æ©è½ãè¿½å ããï¼2015-07-09 11:11:26.837 +00:002015-07-09 14:29:36.603 +00:00    '  '                             V	 =IIãã©ã¤ãã·ã¼æå ±ãã©ã¤ãã·ã¼æå ±ã®ãã¡ãåäººæå ±ãã¨ã¯ï¼åäººæå ±ä¿è­·æ³ã«ãããåäººæå ±ããæããã®ã¨ãï¼çå­ããåäººã«é¢ããæå ±ã§ãã£ã¦ï¼å½è©²æå ±ã«å«ã¾ããæ°åï¼çå¹´ææ¥ï¼ä½æï¼é»è©±çªå·ï¼é£çµ¡åãã®ä»ã®è¨è¿°ç­ã«ããç¹å®ã®åäººãè­å¥ã§ããæå ±ãæãã¾ãã ãã©ã¤ãã·ã¼æå ±ã®ãã¡ãå±¥æ­´æå ±ããã³ç¹æ§æå ±ãã¨ã¯ï¼ä¸è¨ã«å®ãããåäººæå ±ãä»¥å¤ã®ãã®ãããï¼ãå©ç¨ããã ãããµã¼ãã¹ããè³¼å¥ããã ããååï¼ãè¦§ã«ãªã£ããã¼ã¸ãåºåã®å±¥æ­´ï¼ã¦ã¼ã¶ã¼ãæ¤ç´¢ãããæ¤ç´¢ã­ã¼ã¯ã¼ãï¼ãå©ç¨æ¥æï¼ãå©ç¨ã®æ¹æ³ï¼ãå©ç¨ç°å¢ï¼éµä¾¿çªå·ãæ§å¥ï¼è·æ¥­ï¼å¹´é½¢ï¼ã¦ã¼ã¶ã¼ã®IPã¢ãã¬ã¹ï¼ã¯ãã­ã¼æå ±ï¼ä½ç½®æå ±ï¼ç«¯æ«ã®åä½è­å¥æå ±ãªã©ãæãã¾ãã2015-07-04 09:44:35.729 +00:002015-07-04 09:44:35.729 +00:00    ý ~ ý                                                                                                                                                                                                                                                 ~ 1 I II namename@aimerhtyst.co000db26795540d5d15db9ab0e05b3c1dd3a92a18df22c26d65e184f4bdffab012b43cfe63c86d85775f7e50179611953c229a9a5a04702c8a9bcd1a0d468ee7bec17bd75a022ce1be33221b3566c00ec26a30e2a9f395487276f9f1bb3e20ef9285da682dd6db3187b80d06df8f7ccda27b3c317ec5ea10952d9cea04dc93fbd2015-07-09 15:04:33.920 +00:002015-07-09 15:04:48.664 +00:002015-07-09 15:04:48.664 +00:00 1 I II aimeraimer@aimrthyst.cob109f3bbbc244eb82441917ed06d618b9008dd09b3befd1b5e07394c706a8bb980b1d7785e5976ec049b46df5f1326af5a2ea6d103fd07c95385ffab0cacbc8623754be3c8c6a9d97e744fd40620b9acc45d5f472c26d8c49269d7e22863798d83d5e72bbc8f13e43ba0c5a1ddfe0dd320e1bea6587ef5b25c447224d8ea1c0d2015-07-09 14:58:10.980 +00:002015-07-09 15:03:06.587 +00:002015-07-09 15:03:06.587 +00:00