Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DUBhn-00089j-Ti	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 May 2005 15:53:59 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DUBhn-0004rR-DW	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 May 2005 15:53:59 -0700
Message-Id: <200505062249.j46MnH9l010462@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 6/12] UML - Eliminate unusable function
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
Date: Fri, 06 May 2005 18:49:17 -0400
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Eliminate the non-inline version of switch_mm, which can't be used, 
considering the inline version in asm/mmu_context.h

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11-mm/arch/um/kernel/process_kern.c
===================================================================
--- linux-2.6.11-mm.orig/arch/um/kernel/process_kern.c	2005-04-30 12:57:43.000000000 -0400
+++ linux-2.6.11-mm/arch/um/kernel/process_kern.c	2005-04-30 13:13:04.000000000 -0400
@@ -116,16 +116,6 @@
 	return(pid);
 }
 
-void switch_mm(struct mm_struct *prev, struct mm_struct *next, 
-	       struct task_struct *tsk)
-{
-	int cpu = smp_processor_id();
-
-	if (prev != next) 
-		cpu_clear(cpu, prev->cpu_vm_mask);
-	cpu_set(cpu, next->cpu_vm_mask);
-}
-
 void set_current(void *t)
 {
 	struct task_struct *task = t;



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
