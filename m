Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cx9d2-0004Vg-TQ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 12:00:32 -0800
Received: from www.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1Cx9d0-0000yK-RL for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 12:00:32 -0800
From: blaisorblade@yahoo.it
Message-Id: <20050204183558.4EB559BCBA@zion>
Subject: [uml-devel] [patch 8/8] uml: fix x86_64 submode compilation [before
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
Date: Fri, 04 Feb 2005 19:35:58 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Jeff Dike <jdike@addtoit.com>

Forgot to use ARCH_USER_CFLAGS after defining it for x86_64.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/Makefile~uml-x86_64-fixes arch/um/Makefile
--- linux-2.6.11/arch/um/Makefile~uml-x86_64-fixes	2005-02-04 07:41:07.673156760 +0100
+++ linux-2.6.11-paolo/arch/um/Makefile	2005-02-04 07:41:07.727148552 +0100
@@ -58,7 +58,7 @@ CFLAGS += $(CFLAGS-y) -D__arch_um__ -DSU
 
 USER_CFLAGS := $(patsubst -I%,,$(CFLAGS))
 USER_CFLAGS := $(patsubst -D__KERNEL__,,$(USER_CFLAGS)) $(ARCH_INCLUDE) \
-	$(MODE_INCLUDE)
+	$(MODE_INCLUDE) $(ARCH_USER_CFLAGS)
 CFLAGS += -Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask
 CFLAGS += $(call cc-option,-fno-unit-at-a-time,)
 
_


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
