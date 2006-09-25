Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GRvIz-0004Ly-7H for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Sep 2006 11:35:49 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GRvIy-0003Li-Ne
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Sep 2006 11:35:49 -0700
Message-Id: <200609251834.k8PIYftQ005046@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Mon, 25 Sep 2006 14:34:41 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 6/8] UML - Add checkstack support
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
Cc: Paolo Giarrusso <blaisorblade@yahoo.it>, Joern Engel <joern@wohnheim.fh-wedel.de>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Matt Mackall <mpm@selenic.com>

Make checkstack work for UML.  We need to pass the underlying architecture
name, rather than "um" to checkstack.pl.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/Makefile
===================================================================
--- linux-2.6.18-mm.orig/Makefile	2006-09-22 11:34:57.000000000 -0400
+++ linux-2.6.18-mm/Makefile	2006-09-22 11:35:38.000000000 -0400
@@ -1333,9 +1333,13 @@ endif #ifeq ($(config-targets),1)
 endif #ifeq ($(mixed-targets),1)
 
 PHONY += checkstack kernelrelease kernelversion
+
+# Use $(SUBARCH) here instead of $(ARCH) so that this works for UML.
+# In the UML case, $(SUBARCH) is the name of the underlying
+# architecture, while for all other arches, it is the same as $(ARCH).
 checkstack:
 	$(OBJDUMP) -d vmlinux $$(find . -name '*.ko') | \
-	$(PERL) $(src)/scripts/checkstack.pl $(ARCH)
+	$(PERL) $(src)/scripts/checkstack.pl $(SUBARCH)
 
 kernelrelease:
 	$(if $(wildcard include/config/kernel.release), $(Q)echo $(KERNELRELEASE), \


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
