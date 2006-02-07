Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F6IUw-0003pS-GP for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Feb 2006 18:22:30 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1F6IUw-000411-2Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Feb 2006 18:22:30 -0800
Message-Id: <200602070223.k172NpJa009654@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/8] UML - Define jmpbuf access constants
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
Date: Mon, 06 Feb 2006 21:23:51 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

With newer libcs, the JB_* macros (which we shouldn't be using anyway, 
probably) go away.  This patch defines them if setjmp.h doesn't.  It'd
be nice to have a real way to do this, as sysrq-t requires a way to
get registers from out-of-context threads, which we store in jmpbufs.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/os-Linux/sys-i386/registers.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/sys-i386/registers.c	2005-10-28 12:58:12.000000000 -0400
+++ linux-2.6.15/arch/um/os-Linux/sys-i386/registers.c	2006-02-06 17:34:36.000000000 -0500
@@ -127,6 +127,12 @@ void get_safe_registers(unsigned long *r
 	memcpy(regs, exec_regs, HOST_FRAME_SIZE * sizeof(unsigned long));
 }
 
+#ifndef JB_PC
+#define JB_PC 5
+#define JB_SP 4
+#define JB_BP 3
+#endif
+
 void get_thread_regs(union uml_pt_regs *uml_regs, void *buffer)
 {
 	struct __jmp_buf_tag *jmpbuf = buffer;
Index: linux-2.6.15/arch/um/os-Linux/sys-x86_64/registers.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/sys-x86_64/registers.c	2005-10-28 12:58:12.000000000 -0400
+++ linux-2.6.15/arch/um/os-Linux/sys-x86_64/registers.c	2006-02-06 17:34:36.000000000 -0500
@@ -75,6 +75,12 @@ void get_safe_registers(unsigned long *r
 	memcpy(regs, exec_regs, HOST_FRAME_SIZE * sizeof(unsigned long));
 }
 
+#ifndef JB_PC
+#define JB_PC 7
+#define JB_RSP 6
+#define JB_RBP 1
+#endif
+
 void get_thread_regs(union uml_pt_regs *uml_regs, void *buffer)
 {
 	struct __jmp_buf_tag *jmpbuf = buffer;



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
