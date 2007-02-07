Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HEssW-0003rj-3v for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 11:54:52 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HEssT-000645-Ky
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 11:54:52 -0800
Message-Id: <200702071947.l17Jljei006610@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Wed, 07 Feb 2007 14:47:45 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 3/7] UML - SIGIO formatting fixes
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
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Fix formatting in the sigio code.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/include/sigio.h |   11 -----------
 arch/um/kernel/sigio.c  |    6 +++---
 2 files changed, 3 insertions(+), 14 deletions(-)

Index: linux-2.6.18-mm/arch/um/include/sigio.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/sigio.h	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.18-mm/arch/um/include/sigio.h	2007-01-09 15:16:29.000000000 -0500
@@ -12,14 +12,3 @@ extern void sigio_lock(void);
 extern void sigio_unlock(void);
 
 #endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.18-mm/arch/um/kernel/sigio.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/sigio.c	2007-01-09 15:12:08.000000000 -0500
+++ linux-2.6.18-mm/arch/um/kernel/sigio.c	2007-01-09 15:15:59.000000000 -0500
@@ -23,7 +23,7 @@ static irqreturn_t sigio_interrupt(int i
 
 	os_read_file(sigio_irq_fd, &c, sizeof(c));
 	reactivate_fd(sigio_irq_fd, SIGIO_WRITE_IRQ);
-	return(IRQ_HANDLED);
+	return IRQ_HANDLED;
 }
 
 int write_sigio_irq(int fd)
@@ -36,10 +36,10 @@ int write_sigio_irq(int fd)
 	if(err){
 		printk("write_sigio_irq : um_request_irq failed, err = %d\n",
 		       err);
-		return(-1);
+		return -1;
 	}
 	sigio_irq_fd = fd;
-	return(0);
+	return 0;
 }
 
 /* These are called from os-Linux/sigio.c to protect its pollfds arrays. */


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
