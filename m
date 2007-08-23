Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IOKNY-00052Q-Th for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Aug 2007 14:38:13 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IOKNY-0006nR-E3
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Aug 2007 14:38:12 -0700
Date: Thu, 23 Aug 2007 17:38:10 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070823213810.GA9120@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 7/7] UML - Eliminate floating point state from
	register file
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
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

The floating point fields in the pt_regs register file aren't used, so
they are deleted.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/include/sysdep-i386/ptrace.h   |    2 --
 arch/um/include/sysdep-x86_64/ptrace.h |    1 -
 2 files changed, 3 deletions(-)

Index: linux-2.6.22/arch/um/include/sysdep-i386/ptrace.h
===================================================================
--- linux-2.6.22.orig/arch/um/include/sysdep-i386/ptrace.h	2007-08-23 15:05:36.000000000 -0400
+++ linux-2.6.22/arch/um/include/sysdep-i386/ptrace.h	2007-08-23 15:17:14.000000000 -0400
@@ -54,8 +54,6 @@ extern int sysemu_supported;
 
 struct uml_pt_regs {
 	unsigned long gp[MAX_REG_NR];
-	unsigned long fp[HOST_FP_SIZE];
-	unsigned long xfp[HOST_XFP_SIZE];
 	struct faultinfo faultinfo;
 	long syscall;
 	int is_user;
Index: linux-2.6.22/arch/um/include/sysdep-x86_64/ptrace.h
===================================================================
--- linux-2.6.22.orig/arch/um/include/sysdep-x86_64/ptrace.h	2007-08-23 15:05:36.000000000 -0400
+++ linux-2.6.22/arch/um/include/sysdep-x86_64/ptrace.h	2007-08-23 15:17:39.000000000 -0400
@@ -86,7 +86,6 @@
 
 struct uml_pt_regs {
 	unsigned long gp[MAX_REG_NR];
-	unsigned long fp[HOST_FP_SIZE];
 	struct faultinfo faultinfo;
 	long syscall;
 	int is_user;

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
