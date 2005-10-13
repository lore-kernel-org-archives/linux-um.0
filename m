Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EQ7kc-0001ha-3A	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Oct 2005 11:24:22 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EQ7kZ-0000bC-6t
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Oct 2005 11:24:21 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] 2.6.14-rc4;
	panic: do_syscall_stub : failed to wait for SIGUSR1/SIGTRAP
Message-ID: <20051013161937.GA5352@ccure.user-mode-linux.org>
References: <Pine.LNX.4.64.0510122241080.6495@sparrow>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510122241080.6495@sparrow>
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
Date: Thu, 13 Oct 2005 12:19:37 -0400
To: William Stearns <wstearns@pobox.com>
Cc: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Wed, Oct 12, 2005 at 11:39:02PM -0400, William Stearns wrote:
> Kernel panic - not syncing: do_syscall_stub : failed to wait for 
> SIGUSR1/SIGTRAP, pid = 3357, n = 3357, errno = 0, status = 0xb7f

Can you apply the patch below, and see what it says?

				Jeff

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
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
