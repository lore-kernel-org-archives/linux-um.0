Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HEssz-0003xp-Ga for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 11:55:21 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HEssZ-0002zc-7r
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 11:55:21 -0800
Message-Id: <200702071947.l17Jlo57006625@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Wed, 07 Feb 2007 14:47:50 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 6/7] UML - register handling formatting fixes
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

Formatting fixes in the register handling code.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/os-Linux/sys-i386/registers.c   |   14 +++++++-------
 arch/um/os-Linux/sys-x86_64/registers.c |    6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

Index: linux-2.6.18-mm/arch/um/os-Linux/sys-i386/registers.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/sys-i386/registers.c	2007-01-09 15:17:55.000000000 -0500
+++ linux-2.6.18-mm/arch/um/os-Linux/sys-i386/registers.c	2007-01-09 15:45:22.000000000 -0500
@@ -34,27 +34,27 @@ void init_thread_registers(union uml_pt_
 int save_fp_registers(int pid, unsigned long *fp_regs)
 {
 	if(ptrace(PTRACE_GETFPREGS, pid, 0, fp_regs) < 0)
-		return(-errno);
-	return(0);
+		return -errno;
+	return 0;
 }
 
 int restore_fp_registers(int pid, unsigned long *fp_regs)
 {
 	if(ptrace(PTRACE_SETFPREGS, pid, 0, fp_regs) < 0)
-		return(-errno);
-	return(0);
+		return -errno;
+	return 0;
 }
 
 static int move_registers(int pid, int int_op, union uml_pt_regs *regs,
 			  int fp_op, unsigned long *fp_regs)
 {
 	if(ptrace(int_op, pid, 0, regs->skas.regs) < 0)
-		return(-errno);
+		return -errno;
 
 	if(ptrace(fp_op, pid, 0, fp_regs) < 0)
-		return(-errno);
+		return -errno;
 
-	return(0);
+	return 0;
 }
 
 void save_registers(int pid, union uml_pt_regs *regs)
Index: linux-2.6.18-mm/arch/um/os-Linux/sys-x86_64/registers.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/sys-x86_64/registers.c	2007-01-09 15:17:53.000000000 -0500
+++ linux-2.6.18-mm/arch/um/os-Linux/sys-x86_64/registers.c	2007-01-09 15:45:22.000000000 -0500
@@ -27,12 +27,12 @@ static int move_registers(int pid, int i
 			  union uml_pt_regs *regs)
 {
 	if(ptrace(int_op, pid, 0, regs->skas.regs) < 0)
-		return(-errno);
+		return -errno;
 
 	if(ptrace(fp_op, pid, 0, regs->skas.fp) < 0)
-		return(-errno);
+		return -errno;
 
-	return(0);
+	return 0;
 }
 
 void save_registers(int pid, union uml_pt_regs *regs)


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
