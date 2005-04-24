Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DPli5-0004sF-CG for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 11:20:01 -0700
Received: from mail-relay-4.tiscali.it ([213.205.33.44])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DPli2-0006Su-L8 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 11:20:01 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050424181007.5680155D01@zion>
Subject: [uml-devel] [patch 5/6] uml: inline empty proc
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
Date: Sun, 24 Apr 2005 20:10:07 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


Cleanup: make an inline of this empty proc.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/arch/um/kernel/process_kern.c      |    4 ----
 linux-2.6.12-paolo/include/asm-um/processor-generic.h |    6 +++++-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff -puN include/asm-um/processor-generic.h~uml-inline-empty include/asm-um/processor-generic.h
--- linux-2.6.12/include/asm-um/processor-generic.h~uml-inline-empty	2005-04-24 19:32:18.000000000 +0200
+++ linux-2.6.12-paolo/include/asm-um/processor-generic.h	2005-04-24 19:32:18.000000000 +0200
@@ -89,7 +89,11 @@ extern struct task_struct *alloc_task_st
 extern void release_thread(struct task_struct *);
 extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 extern void dump_thread(struct pt_regs *regs, struct user *u);
-extern void prepare_to_copy(struct task_struct *tsk);
+
+static inline void prepare_to_copy(struct task_struct *tsk)
+{
+}
+
 
 extern unsigned long thread_saved_pc(struct task_struct *t);
 
diff -puN arch/um/kernel/process_kern.c~uml-inline-empty arch/um/kernel/process_kern.c
--- linux-2.6.12/arch/um/kernel/process_kern.c~uml-inline-empty	2005-04-24 19:32:18.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/kernel/process_kern.c	2005-04-24 19:32:18.000000000 +0200
@@ -161,10 +161,6 @@ void *get_current(void)
 	return(current);
 }
 
-void prepare_to_copy(struct task_struct *tsk)
-{
-}
-
 int copy_thread(int nr, unsigned long clone_flags, unsigned long sp,
 		unsigned long stack_top, struct task_struct * p, 
 		struct pt_regs *regs)
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
