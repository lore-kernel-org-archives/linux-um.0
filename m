Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AcoD2-0005lS-NW for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 Jan 2004 08:01:04 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AcoD2-0004S5-24 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 Jan 2004 08:01:04 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401031659.10844.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Replacement of A-04 patch for mm/memory.c for UML/2.6
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
Date: Sat, 3 Jan 2004 16:59:10 +0100
To: user-mode-linux-devel@lists.sourceforge.net

It turned out that replacing that patch is probably easier than I thought. 
This is the B-02 patch that I will post on my web space:

--- linux-2.6.0/mm/memory.c.memFix	2004-01-03 13:39:37.000000000 +0100
+++ linux-2.6.0/mm/memory.c	2004-01-03 13:42:17.000000000 +0100
@@ -44,6 +44,7 @@
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
 #include <linux/rmap-locking.h>
+#include <linux/init.h>
 #include <linux/module.h>
 
 #include <asm/pgalloc.h>
@@ -680,6 +681,24 @@
 }
 
 
+static struct vm_area_struct fixmap_vma = {
+	/* Catch users - if there are any valid
+	   ones, we can make this be "&init_mm" or
+	   something.  */
+	.vm_mm = NULL,
+	.vm_page_prot = PAGE_READONLY,
+	.vm_flags = VM_READ | VM_EXEC,
+};
+
+static int init_fixmap_vma(void)
+{
+	fixmap_vma.vm_start = FIXADDR_USER_START;
+	fixmap_vma.vm_end = FIXADDR_USER_END;
+	return(0);
+}
+
+__initcall(init_fixmap_vma);
+
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		unsigned long start, int len, int write, int force,
 		struct page **pages, struct vm_area_struct **vmas)
@@ -703,16 +722,6 @@
 #ifdef FIXADDR_USER_START
 		if (!vma &&
 		    start >= FIXADDR_USER_START && start < FIXADDR_USER_END) {
-			static struct vm_area_struct fixmap_vma = {
-				/* Catch users - if there are any valid
-				   ones, we can make this be "&init_mm" or
-				   something.  */
-				.vm_mm = NULL,
-				.vm_start = FIXADDR_USER_START,
-				.vm_end = FIXADDR_USER_END,
-				.vm_page_prot = PAGE_READONLY,
-				.vm_flags = VM_READ | VM_EXEC,
-			};
 			unsigned long pg = start & PAGE_MASK;
 			pgd_t *pgd;
 			pmd_t *pmd;

The difference with the A-04 patch is that while that one replaces 
FIXADDR_USER_* with FIXADDR_*, while this one doesn't apply this change.
I've done this because I've seen that old 2.5 kernels used FIXADDR_* macros; 
then FIXADDR_USER_* was introduced but Jeff Dike, probably, didn't notice 
this.

The change was (and in this version it is) only a syntactic one.
Looking at the change itself, I think that this version makes more sense: that 
code is used to map in the address space of a process the page containing the 
vsyscall code. But it should not be possible to map the other "fixed" virtual 
pages inside a process's address space, right?

Obviously all in my very humble opinion. I'm posting this patch here for 
comments and corrections (as I'm still a newbie about Linux internals, and 
too careless at times).

Besides, after applying it, I got a non-reproducible segmentation fault the 
first time I ran the resulting binary (I've not been able to reproduce that 
crash). I'm not sure the fault was related to my code, but however this is 
the output:

$ ./linux ubd0=~/Uml/root_fs_toms1.7.205 root=/dev/ubd0

Checking for the skas3 patch in the host...found
Checking for /proc/mm...found
Linux version 2.6.0-1um (paolo@blaisorblade) (gcc version 3.2.2 (Mandrake 
Linux 9.1 3.2.2-3mdk)) #12 Sat Jan 3 13:50:46 CET 2004
On node 0 totalpages: 8192
  DMA zone: 8192 pages, LIFO batch:2
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: ubd0=/home/paolo/Uml/root_fs_toms1.7.205 root=/dev/ubd0
PID hash table entries: 16 (order 4: 128 bytes)
Memory: 30680k available
Calibrating delay loop... 681.57 BogoMIPS
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Segmentation fault

-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.23/2.6.0 on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
