Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CFBG6-000063-2H for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Oct 2004 05:51:06 -0700
Received: from ctron-dnm.enterasys.com ([12.25.1.120] ident=firewall-user)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CFBFz-0003Bz-Uy for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Oct 2004 05:51:05 -0700
Received: (from uucp@localhost)
	by ctron-dnm.enterasys.com (8.8.7/8.8.7) id IAA03918
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 6 Oct 2004 08:54:42 -0400 (EDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <EAC7622167479948B614F8B9AD41C505ECA5D4@MAANDMBX2.ets.enterasys.com>
From: "Tsillas, Demetrios J" <jtsillas@enterasys.com>
Subject: [uml-devel] segv soon after startup 2.6.9-rc2-mm4
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 6 Oct 2004 08:49:18 -0400
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net

Using 2.6.9-rc2-mm4 with the incrementals.

If CONFIG_MODE_TT is enabled and linux is run with
no args. The value of argv[1] is 0 causing a crash
with strlen in linux_main:

349     #ifdef CONFIG_MODE_TT
350             argv1_begin = argv[1];
351             argv1_end = &argv[1][strlen(argv[1])];
352     #endif

BTW, I've had problems building with CONFIG_MODE_TT
turned off:



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
