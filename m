Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Imutd-0001oy-9y for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Oct 2007 10:28:59 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Imutb-0002nT-Ni
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Oct 2007 10:28:57 -0700
Date: Tue, 30 Oct 2007 13:28:48 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071030172848.GA8356@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/4] UML - Remove xmm checking on x86
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Karol Swietlicki <magotari@gmail.com>

From: Karol Swietlicki <magotari@gmail.com>

This patch removes some code which ran at every boot, but does not
seem to do anything anymore. Please test. It works for me but mistakes
can happen.

Signed-off-by: Karol Swietlicki <magotari@gmail.com>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/sys-i386/bugs.c         |    3 ---
 include/asm-um/processor-i386.h |    1 -
 2 files changed, 4 deletions(-)

Index: linux-2.6.22/arch/um/sys-i386/bugs.c
===================================================================
--- linux-2.6.22.orig/arch/um/sys-i386/bugs.c	2007-10-25 23:33:16.000000000 -0400
+++ linux-2.6.22/arch/um/sys-i386/bugs.c	2007-10-26 12:31:25.000000000 -0400
@@ -15,7 +15,6 @@
 
 /* Set during early boot */
 int host_has_cmov = 1;
-int host_has_xmm = 0;
 
 static char token(int fd, char *buf, int len, char stop)
 {
@@ -163,8 +162,6 @@ void arch_check_bugs(void)
 	}
 	if (check_cpu_flag("cmov", &have_it))
 		host_has_cmov = have_it;
-	if (check_cpu_flag("xmm", &have_it))
-		host_has_xmm = have_it;
 }
 
 int arch_handle_signal(int sig, struct uml_pt_regs *regs)
Index: linux-2.6.22/include/asm-um/processor-i386.h
===================================================================
--- linux-2.6.22.orig/include/asm-um/processor-i386.h	2007-07-08 19:32:17.000000000 -0400
+++ linux-2.6.22/include/asm-um/processor-i386.h	2007-10-26 12:32:07.000000000 -0400
@@ -10,7 +10,6 @@
 #include "asm/host_ldt.h"
 #include "asm/segment.h"
 
-extern int host_has_xmm;
 extern int host_has_cmov;
 
 /* include faultinfo structure */

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
