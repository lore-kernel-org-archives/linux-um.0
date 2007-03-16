Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HSGKu-0000Hf-JG for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Mar 2007 10:35:29 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HSGKu-0007Fl-36
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Mar 2007 10:35:28 -0700
Date: Fri, 16 Mar 2007 12:10:15 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070316161015.GA7948@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] UML - arch_prctl should set thread fs
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
To: stable@kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

[ This missed getting into -stable the first time I sent it ]

In my previous x86_64 thread fix, I forgot to initialize
thread.arch.fs in arch_prctl.  A process calling arch_prctl to set %fs
would lose it on the next context switch.

It also turns out that you can switch to a process which is in the
process of exiting and which has lost its mm.  In this case, it's
worse than useless to try to call arch_prctl on the host process. 

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/sys-x86_64/syscalls.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux-2.6.17/arch/um/sys-x86_64/syscalls.c
===================================================================
--- linux-2.6.17.orig/arch/um/sys-x86_64/syscalls.c	2007-03-07 12:18:38.000000000 -0500
+++ linux-2.6.17/arch/um/sys-x86_64/syscalls.c	2007-03-16 12:04:40.000000000 -0400
@@ -103,6 +103,9 @@ long arch_prctl_skas(struct task_struct 
 
         switch(code){
 	case ARCH_SET_FS:
+		current->thread.arch.fs = (unsigned long) ptr;
+		save_registers(pid, &current->thread.regs.regs);
+		break;
 	case ARCH_SET_GS:
                 save_registers(pid, &current->thread.regs.regs);
 		break;
@@ -140,9 +143,8 @@ long sys_clone(unsigned long clone_flags
 
 void arch_switch_to_skas(struct task_struct *from, struct task_struct *to)
 {
-        if(to->thread.arch.fs == 0)
+        if((to->thread.arch.fs == 0) || (to->mm == NULL))
                 return;
 
         arch_prctl_skas(to, ARCH_SET_FS, (void __user *) to->thread.arch.fs);
 }
-

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
