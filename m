Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DuBal-0000ND-Pj	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 17 Jul 2005 09:02:11 -0700
Received: from [67.70.253.242] (helo=localhost.localdomain)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.44)
	id 1DuBah-0006GG-9t	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 17 Jul 2005 09:02:11 -0700
Content-Disposition: inline
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200507171809.27658.blaisorblade@yahoo.it>
Subject: [uml-devel] Fwd: fix -rc3-mm1 and -rc3-git UML build (was: [PATCH]
	readd missing define to arch/um/Makefile-i386)
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
Date: Sun, 17 Jul 2005 18:09:27 +0200
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>



----------  Forwarded Message  ----------

Subject: [PATCH] readd missing define to arch/um/Makefile-i386
Date: Sunday 17 July 2005 16:52
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, blaisorblade@yahoo.it, 
linux-kernel@vger.kernel.org

New in 2.6.13-rc3-git4:

scripts/Makefile.build:13: /Makefile: No such file or directory
scripts/Makefile.build:64: kbuild: Makefile.build is included improperly

the define was removed, but its still required to build some targets.

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/um/Makefile-i386 |    1 +
 1 files changed, 1 insertion(+)

Index: linux-2.6.13-rc3-git4/arch/um/Makefile-i386
===================================================================
--- linux-2.6.13-rc3-git4.orig/arch/um/Makefile-i386
+++ linux-2.6.13-rc3-git4/arch/um/Makefile-i386
@@ -33,6 +33,7 @@ ifneq ($(CONFIG_GPROF),y)
 ARCH_CFLAGS += -DUM_FASTCALL
 endif

+SYS_UTIL_DIR	:= $(ARCH_DIR)/sys-i386/util
 SYS_HEADERS	:= $(SYS_DIR)/sc.h $(SYS_DIR)/thread.h

 prepare: $(SYS_HEADERS)

-------------------------------------------------------

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
