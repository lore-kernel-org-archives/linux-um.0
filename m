Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CyELb-0001TW-4m for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Feb 2005 11:14:59 -0800
Received: from mail-relay-2.tiscali.it ([213.205.33.42])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CyELZ-0002k3-KK for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Feb 2005 11:14:59 -0800
From: blaisorblade@yahoo.it
Message-Id: <20050207191133.25DEF21251@zion>
Subject: [uml-devel] [patch 1/2] uml - kbuild: add further cleaning [before
	2.6.11]
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
Date: Mon, 07 Feb 2005 20:11:32 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Descend into arch/um/kernel/skas/util during make clean.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/kernel/skas/Makefile |    2 ++
 1 files changed, 2 insertions(+)

diff -puN arch/um/kernel/skas/Makefile~uml-kbuild-add-further-cleaning arch/um/kernel/skas/Makefile
--- linux-2.6.11/arch/um/kernel/skas/Makefile~uml-kbuild-add-further-cleaning	2005-02-07 19:36:20.077171544 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/skas/Makefile	2005-02-07 19:36:20.080171088 +0100
@@ -11,3 +11,5 @@ USER_OBJS := $(foreach file,$(USER_OBJS)
 
 $(USER_OBJS) : %.o: %.c
 	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+
+subdir- := util
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
