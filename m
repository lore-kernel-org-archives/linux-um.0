Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6Y59-0006Jw-Js for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Sep 2004 10:24:07 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1C6Y58-0001kw-Rw for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Sep 2004 10:24:07 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Unsent fixes by Andrew Morton
References: <20040826020626.GA28471@malice.crymeariver.org>
	<200409111745.18659.blaisorblade_spam@yahoo.it>
	<20040911182615.GB2966@ccure.user-mode-linux.org>
In-Reply-To: <20040911182615.GB2966@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zEHRBLmbWdcboJe"
Message-Id: <200409121754.27163.blaisorblade_spam@yahoo.it>
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
Date: Sun, 12 Sep 2004 17:54:27 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, David Jeffery <djeffery@britsys.net>


--Boundary-00=_zEHRBLmbWdcboJe
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 11 September 2004 20:26, Jeff Dike wrote:
> > Also, Andrew Morton wrote some UML fixes (for scheduler bugs) on his own.
> > Did you already note this or you want them forwarded?

> I didn't see them, please send them over.

Here is his patch to the SMP code about forking the idle thread, which is only 
one, actually (sched-update).

Also, it seems that there is some other work that you sent to Andrew but 
didn't take to your own tree.

Quoting from changelogs:
"        convert all calls to open_private_file to dentry_open"
"        use the new get_signal_to_deliver interface"

Also, since you decided to define instruction_pointer (which gets the value 
from a pt_regs struct), what about fixing this, too, which is 
include/asm-um/processor-generic.h? 

#define current_text_addr() ((void *) 0)

Here's the i386 one:

It should be in processor-i386.h, because it's impossible to write it in C, 
IMHO:

/*
 * Default implementation of macro that returns current
 * instruction pointer ("program counter").
 */
#define current_text_addr() ({ void *pc; __asm__("movl $1f,%0\n1:":"=g" (pc)); 
pc; })

If it's Ok for you, apply the second patch. (add-current_text_addr).

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_zEHRBLmbWdcboJe
Content-Type: text/x-diff; charset="iso-8859-1"; name="uml-sched-update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-sched-update.patch"



Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/um/kernel/smp.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

diff -puN arch/um/kernel/smp.c~uml-sched-update arch/um/kernel/smp.c
--- 25/arch/um/kernel/smp.c~uml-sched-update	2004-08-05 22:11:21.564444232 -0700
+++ 25-akpm/arch/um/kernel/smp.c	2004-08-05 22:11:29.870181568 -0700
@@ -148,8 +148,7 @@ static struct task_struct *idle_thread(i
 
         current->thread.request.u.thread.proc = idle_proc;
         current->thread.request.u.thread.arg = (void *) cpu;
-	new_task = copy_process(CLONE_VM | CLONE_IDLETASK, 0, NULL, 0, NULL,
-				NULL);
+	new_task = fork_idle(cpu);
 	if(IS_ERR(new_task))
 		panic("copy_process failed in idle_thread, error = %ld",
 		      PTR_ERR(new_task));
@@ -161,7 +160,6 @@ static struct task_struct *idle_thread(i
 	CHOOSE_MODE(os_write_file(new_task->thread.mode.tt.switch_pipe[1], &c,
 			  sizeof(c)),
 		    ({ panic("skas mode doesn't support SMP"); }));
-	wake_up_forked_process(new_task);
 	return(new_task);
 }
 
_

--Boundary-00=_zEHRBLmbWdcboJe
Content-Type: text/x-diff; charset="iso-8859-1";
	name="uml-add-current_text_addr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-add-current_text_addr.patch"



Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/include/asm-um/processor-generic.h |    2 --
 uml-linux-2.6.8.1-paolo/include/asm-um/processor-i386.h    |    7 +++++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff -puN include/asm-um/processor-i386.h~uml-add-current_text_addr include/asm-um/processor-i386.h
--- uml-linux-2.6.8.1/include/asm-um/processor-i386.h~uml-add-current_text_addr	2004-09-12 17:48:20.172530912 +0200
+++ uml-linux-2.6.8.1-paolo/include/asm-um/processor-i386.h	2004-09-12 17:49:37.853721576 +0200
@@ -19,6 +19,13 @@ struct arch_thread {
 
 #include "asm/arch/user.h"
 
+/*
+ * Default implementation of macro that returns current
+ * instruction pointer ("program counter"). Stolen
+ * from asm-i386/processor.h
+ */
+#define current_text_addr() ({ void *pc; __asm__("movl $1f,%0\n1:":"=g" (pc)); pc; })
+
 #include "asm/processor-generic.h"
 
 #endif
diff -puN include/asm-um/processor-generic.h~uml-add-current_text_addr include/asm-um/processor-generic.h
--- uml-linux-2.6.8.1/include/asm-um/processor-generic.h~uml-add-current_text_addr	2004-09-12 17:49:26.244486448 +0200
+++ uml-linux-2.6.8.1-paolo/include/asm-um/processor-generic.h	2004-09-12 17:49:39.374490384 +0200
@@ -16,8 +16,6 @@ struct task_struct;
 
 struct mm_struct;
 
-#define current_text_addr() ((void *) 0)
-
 #define cpu_relax()   barrier()
 
 struct thread_struct {
_

--Boundary-00=_zEHRBLmbWdcboJe--



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
