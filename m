Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E9q0p-0001bI-51	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Aug 2005 13:13:47 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E9q0n-0002z1-Iy
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Aug 2005 13:13:47 -0700
Message-Id: <200508292007.j7TK70Iu029922@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 3/9] UML - Remove libc reference in build
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
Date: Mon, 29 Aug 2005 16:07:00 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>

From Al Viro - Remove an unneeded reference to libc

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-rc6/arch/um/scripts/Makefile.unmap
===================================================================
--- linux-2.6.13-rc6.orig/arch/um/scripts/Makefile.unmap	2005-08-08 12:11:18.000000000 -0400
+++ linux-2.6.13-rc6/arch/um/scripts/Makefile.unmap	2005-08-15 13:55:40.000000000 -0400
@@ -12,7 +12,7 @@
 
 quiet_cmd_wrapld = LD      $@
 define cmd_wrapld
-	$(LD) $(LDFLAGS) -r -o $(obj)/unmap_tmp.o $< $(shell $(CC) $(CFLAGS) -print-file-name=libc.a); \
+	$(LD) $(LDFLAGS) -r -o $(obj)/unmap_tmp.o $< ; \
 	$(OBJCOPY) $(UML_OBJCOPYFLAGS) $(obj)/unmap_tmp.o $@ -G switcheroo
 endef
 



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
