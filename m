Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HEssV-0003rc-OR for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 11:54:52 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HEssT-000644-8J
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 11:54:51 -0800
Message-Id: <200702071947.l17JlhGW006605@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Wed, 07 Feb 2007 14:47:43 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/7] UML - SIGIO locking comment
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

Comment the use of a mysterious-looking lock.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/kernel/sigio.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.18-mm/arch/um/kernel/sigio.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/sigio.c	2007-01-10 15:12:51.000000000 -0500
+++ linux-2.6.18-mm/arch/um/kernel/sigio.c	2007-01-10 15:44:08.000000000 -0500
@@ -42,6 +42,7 @@ int write_sigio_irq(int fd)
 	return(0);
 }
 
+/* These are called from os-Linux/sigio.c to protect its pollfds arrays. */
 static DEFINE_SPINLOCK(sigio_spinlock);
 
 void sigio_lock(void)


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
