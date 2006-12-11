Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GtrCq-00026Q-F3 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Dec 2006 11:52:56 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GtrCo-0000ql-VG
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Dec 2006 11:52:56 -0800
Message-Id: <200612111948.kBBJmLF0023523@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Mon, 11 Dec 2006 14:48:21 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH] Fix crossbuilding checkstack
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: akpm@osdl.org
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

The previous checkstack fix for UML, which needs to use the host's tools, 
was wrong in the crossbuilding case.  It would use the build host's,
rather than the target's, toolchain.

This patch removes the old fix and adds an explicit special case for UML, 
leaving everyone else alone.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

---
 Makefile |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

Index: linux-2.6.18-mm/Makefile
===================================================================
--- linux-2.6.18-mm.orig/Makefile	2006-11-24 14:36:32.000000000 -0500
+++ linux-2.6.18-mm/Makefile	2006-12-05 13:08:20.000000000 -0500
@@ -1390,12 +1390,18 @@ endif #ifeq ($(mixed-targets),1)
 
 PHONY += checkstack kernelrelease kernelversion
 
-# Use $(SUBARCH) here instead of $(ARCH) so that this works for UML.
-# In the UML case, $(SUBARCH) is the name of the underlying
-# architecture, while for all other arches, it is the same as $(ARCH).
+# UML needs a little special treatment here.  It wants to use the host
+# toolchain, so needs $(SUBARCH) passed to checkstack.pl.  Everyone
+# else wants $(ARCH), including people doing cross-builds, which means
+# that $(SUBARCH) doesn't work here.
+ifeq ($(ARCH), um)
+CHECKSTACK_ARCH := $(SUBARCH)
+else
+CHECKSTACK_ARCH := $(ARCH)
+endif
 checkstack:
 	$(OBJDUMP) -d vmlinux $$(find . -name '*.ko') | \
-	$(PERL) $(src)/scripts/checkstack.pl $(SUBARCH)
+	$(PERL) $(src)/scripts/checkstack.pl $(CHECKSTACK_ARCH)
 
 kernelrelease:
 	$(if $(wildcard include/config/kernel.release), $(Q)echo $(KERNELRELEASE), \


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
