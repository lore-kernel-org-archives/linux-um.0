Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DbTIX-0006S6-R6	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 May 2005 18:06:01 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DbTI0-0006u6-Ey	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 May 2005 18:06:01 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050527003854.C1C351AEE90@zion.home.lan>
Subject: [uml-devel] [patch 8/8] uml: remove jail mode + other leftovers
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
Date: Fri, 27 May 2005 02:38:54 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

This var is currently useless, as it's apparent from reading the code. Until
2.6.11 it was used in some code related to jail mode, in the same proc.:

        if(jail){
		while(!reading) sched_yield();
	}

jail mode has been dropped, together with that use, so let's finish dropping
this.

Also, remove some other useless definitions I met.

Acked-by: Jeff Dike <jdike@addtoit.com>

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/kernel/tt/process_kern.c |    8 +-------
 linux-2.6.git-paolo/arch/um/kernel/um_arch.c         |    6 ------
 linux-2.6.git-paolo/include/asm-um/pgtable.h         |    8 --------
 3 files changed, 1 insertion(+), 21 deletions(-)

diff -puN arch/um/kernel/tt/process_kern.c~uml-remove-jail-rem arch/um/kernel/tt/process_kern.c
--- linux-2.6.git/arch/um/kernel/tt/process_kern.c~uml-remove-jail-rem	2005-05-10 00:06:20.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/tt/process_kern.c	2005-05-10 00:06:42.000000000 +0200
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
@@ -59,13 +55,11 @@ void *switch_to_tt(void *prev, void *nex
 	c = 0;
 	set_current(to);
 
-	reading = 0;
 	err = os_write_file(to->thread.mode.tt.switch_pipe[1], &c, sizeof(c));
 	if(err != sizeof(c))
 		panic("write of switch_pipe failed, err = %d", -err);
 
-	reading = 1;
-        if(from->thread.mode.tt.switch_pipe[0] == -1)
+	if(from->thread.mode.tt.switch_pipe[0] == -1)
 		os_kill_process(os_getpid(), 0);
 
 	err = os_read_file(from->thread.mode.tt.switch_pipe[0], &c, sizeof(c));
diff -puN arch/um/kernel/um_arch.c~uml-remove-jail-rem arch/um/kernel/um_arch.c
--- linux-2.6.git/arch/um/kernel/um_arch.c~uml-remove-jail-rem	2005-05-10 00:06:20.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/um_arch.c	2005-05-10 00:06:20.000000000 +0200
@@ -111,12 +111,6 @@ struct seq_operations cpuinfo_op = {
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
--- linux-2.6.git/include/asm-um/pgtable.h~uml-remove-jail-rem	2005-05-10 00:06:20.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-um/pgtable.h	2005-05-10 00:06:20.000000000 +0200
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
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
