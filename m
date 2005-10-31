Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EWQcz-0007Tj-OA	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Oct 2005 19:46:33 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EWQcy-0007E4-HI
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Oct 2005 19:46:33 -0800
Message-Id: <200510310439.j9V4dKTN000834@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/10] UML - Improve stub debugging
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
Date: Sun, 30 Oct 2005 23:39:20 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Add some more debugging information when a stub does something unexpected,
usually segfaulting.  Now, it dumps out the stub's registers as well as
the signal.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.14-rc2-mm1/arch/um/kernel/skas/process.c
===================================================================
--- linux-2.6.14-rc2-mm1.orig/arch/um/kernel/skas/process.c	2005-10-05 18:37:51.000000000 -0400
+++ linux-2.6.14-rc2-mm1/arch/um/kernel/skas/process.c	2005-10-05 18:50:23.000000000 -0400
@@ -69,6 +69,17 @@
 
         if((n < 0) || !WIFSTOPPED(status) ||
            (WSTOPSIG(status) != SIGUSR1 && WSTOPSIG(status) != SIGTRAP)){
+		unsigned long regs[FRAME_SIZE];
+		if(ptrace(PTRACE_GETREGS, pid, 0, regs) < 0)
+			printk("Failed to get registers from stub, "
+			       "errno = %d\n", errno);
+		else {
+			int i;
+
+			printk("Stub registers -\n");
+			for(i = 0; i < FRAME_SIZE; i++)
+				printk("\t%d - %lx\n", i, regs[i]);
+		}
                 panic("%s : failed to wait for SIGUSR1/SIGTRAP, "
                       "pid = %d, n = %d, errno = %d, status = 0x%x\n",
                       fname, pid, n, errno, status);



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
