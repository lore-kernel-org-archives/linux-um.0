Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CHANl-0002i1-0j for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:19:13 -0700
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CHANi-0007ZV-Ml for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:19:12 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20041012001756.D46958693@zion.localdomain>
Subject: [uml-devel] [patch 06/10] uml: update makefile to new kbuild API names
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
Date: Tue, 12 Oct 2004 02:17:56 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Drop the usage of check_gcc and host-progs, and use their new names. A
must-have :-).

Oh, and it will create lots of serious problems - it will give me your root
account! Yes, you don't see the code in the patch, but it happens! :-)))

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/Makefile                  |    2 +-
 linux-2.6.9-current-paolo/arch/um/kernel/skas/util/Makefile |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff -puN arch/um/Makefile~uml-kbuild-renamings arch/um/Makefile
--- linux-2.6.9-current/arch/um/Makefile~uml-kbuild-renamings	2004-09-19 20:31:38.624115320 +0200
+++ linux-2.6.9-current-paolo/arch/um/Makefile	2004-09-19 20:31:38.628114712 +0200
@@ -46,7 +46,7 @@ CFLAGS += $(CFLAGS-y) -D__arch_um__ -DSU
 	-D_LARGEFILE64_SOURCE $(ARCH_INCLUDE) -Derrno=kernel_errno \
 	-Dsigprocmask=kernel_sigprocmask $(MODE_INCLUDE)
 
-CFLAGS += $(call check_gcc,-fno-unit-at-a-time,)
+CFLAGS += $(call cc-option,-fno-unit-at-a-time,)
 
 LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
 
diff -puN arch/um/kernel/skas/util/Makefile~uml-kbuild-renamings arch/um/kernel/skas/util/Makefile
--- linux-2.6.9-current/arch/um/kernel/skas/util/Makefile~uml-kbuild-renamings	2004-09-19 20:31:38.625115168 +0200
+++ linux-2.6.9-current-paolo/arch/um/kernel/skas/util/Makefile	2004-09-19 20:32:05.746992016 +0200
@@ -1,2 +1,2 @@
-host-progs		:= mk_ptregs
-always			:= $(host-progs)
+hostprogs-y		:= mk_ptregs
+always			:= $(hostprogs-y)
_


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
