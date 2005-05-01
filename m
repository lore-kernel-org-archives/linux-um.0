Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DSgSU-0003gW-5q	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 May 2005 12:19:58 -0700
Received: from mail-relay-3.tiscali.it ([213.205.33.43])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DSgST-0003TO-DE	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 May 2005 12:19:58 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050501163818.142A3400F1@zion>
Subject: [uml-devel] [patch 1/1] uml: remove jail mode + other leftovers
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
Date: Sun, 01 May 2005 18:38:15 +0200
To: jdike@addtoit.com
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


This var is currently useless, as it's apparent from reading the code. Until
2.6.11 it was used in some code related to jail mode, in the same proc.:

        if(jail){
		while(!reading) sched_yield();
	}

jail mode has been dropped, together with that use, so let's finish dropping
this.

Also, remove some other useless definitions I met.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/arch/um/kernel/tt/process_kern.c |    6 ------
 linux-2.6.12-paolo/arch/um/kernel/um_arch.c         |    6 ------
 linux-2.6.12-paolo/include/asm-um/pgtable.h         |    8 --------
 3 files changed, 20 deletions(-)

diff -puN arch/um/kernel/tt/process_kern.c~uml-remove-jail-rem arch/um/kernel/tt/process_kern.c
--- linux-2.6.12/arch/um/kernel/tt/process_kern.c~uml-remove-jail-rem	2005-05-01 18:34:35.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/kernel/tt/process_kern.c	2005-05-01 18:34:35.000000000 +0200
@@ -32,10 +32,6 @@ void *switch_to_tt(void *prev, void *nex
 	unsigned long flags;
 	int err, vtalrm, alrm, prof, cpu;
 	char c;
-	/* jailing and SMP are incompatible, so this doesn't need to be 
-	 * made per-cpu 
-	 */
-	static int reading;
 
 	from = prev;
 	to = next;
@@ -59,12 +55,10 @@ void *switch_to_tt(void *prev, void *nex
 	c = 0;
 	set_current(to);
 
-	reading = 0;
 	err = os_write_file(to->thread.mode.tt.switch_pipe[1], &c, sizeof(c));
 	if(err != sizeof(c))
 		panic("write of switch_pipe failed, err = %d", -err);
 
-	reading = 1;
 	if((from->exit_state == EXIT_ZOMBIE) ||
 	   (from->exit_state == EXIT_DEAD))
 		os_kill_process(os_getpid(), 0);
diff -puN arch/um/kernel/um_arch.c~uml-remove-jail-rem arch/um/kernel/um_arch.c
--- linux-2.6.12/arch/um/kernel/um_arch.c~uml-remove-jail-rem	2005-05-01 18:34:54.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/kernel/um_arch.c	2005-05-01 18:36:42.000000000 +0200
@@ -110,12 +110,6 @@ struct seq_operations cpuinfo_op = {
 	.show	= show_cpuinfo,
 };
 
-pte_t * __bad_pagetable(void)
-{
-	panic("Someone should implement __bad_pagetable");
-	return(NULL);
-}
-
 /* Set in linux_main */
 unsigned long host_task_size;
 unsigned long task_size;
diff -puN include/asm-um/pgtable.h~uml-remove-jail-rem include/asm-um/pgtable.h
--- linux-2.6.12/include/asm-um/pgtable.h~uml-remove-jail-rem	2005-05-01 18:35:18.000000000 +0200
+++ linux-2.6.12-paolo/include/asm-um/pgtable.h	2005-05-01 18:36:33.000000000 +0200
@@ -114,17 +114,9 @@ extern unsigned long end_iomem;
 extern unsigned long pg0[1024];
 
 /*
- * BAD_PAGETABLE is used when we need a bogus page-table, while
- * BAD_PAGE is used for a bogus page.
- *
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
  */
-extern pte_t __bad_page(void);
-extern pte_t * __bad_pagetable(void);
-
-#define BAD_PAGETABLE __bad_pagetable()
-#define BAD_PAGE __bad_page()
 
 #define ZERO_PAGE(vaddr) virt_to_page(empty_zero_page)
 
_


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
