Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8Ndd-0002Qf-3B for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 11:11:33 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D8Ndb-0001ya-GE for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 11:11:33 -0800
Message-Id: <200503072038.j27Kc6bc003978@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 8/16] UML - Code cleanup
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
Date: Mon, 07 Mar 2005 15:38:06 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, bstroesser@fujitsu-siemens.com

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Shifting register restore and userspace resume to the
beginning of the userspace loop, we can remove the
identical code done before the loop.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: uml-i386/arch/um/kernel/skas/process.c
===================================================================
--- uml-i386.orig/arch/um/kernel/skas/process.c	2005-03-02 23:39:26.408483443 -0800
+++ uml-i386/arch/um/kernel/skas/process.c	2005-03-02 23:45:55.666136061 -0800
@@ -139,17 +139,20 @@
 	int err, status, op, pid = userspace_pid[0];
 	int local_using_sysemu; /*To prevent races if using_sysemu changes under us.*/
 
-	restore_registers(pid, regs);
-		
-	local_using_sysemu = get_using_sysemu();
+	while(1){
+		restore_registers(pid, regs);
 
-	op = local_using_sysemu ? PTRACE_SYSEMU : PTRACE_SYSCALL;
-	err = ptrace(op, pid, 0, 0);
+		/* Now we set local_using_sysemu to be used for one loop */
+		local_using_sysemu = get_using_sysemu();
+
+		op = SELECT_PTRACE_OPERATION(local_using_sysemu, singlestepping(NULL));
+
+		err = ptrace(op, pid, 0, 0);
+		if(err)
+			panic("userspace - could not resume userspace process, "
+			      "pid=%d, ptrace operation = %d, errno = %d\n",
+			      op, errno);
 
-	if(err)
-		panic("userspace - PTRACE_%s failed, errno = %d\n",
-		       local_using_sysemu ? "SYSEMU" : "SYSCALL", errno);
-	while(1){
 		CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED));
 		if(err < 0)
 			panic("userspace - waitpid failed, errno = %d\n", 
@@ -187,19 +190,6 @@
 			/* Avoid -ERESTARTSYS handling in host */
 			PT_SYSCALL_NR(regs->skas.regs) = -1;
 		}
-
-		restore_registers(pid, regs);
-
-		/*Now we ended the syscall, so re-read local_using_sysemu.*/
-		local_using_sysemu = get_using_sysemu();
-
-		op = SELECT_PTRACE_OPERATION(local_using_sysemu, singlestepping(NULL));
-
-		err = ptrace(op, pid, 0, 0);
-		if(err)
-			panic("userspace - PTRACE_%s failed, "
-			      "errno = %d\n",
-			      local_using_sysemu ? "SYSEMU" : "SYSCALL", errno);
 	}
 }
 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
