Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Jeff Chua <jeff98@silk.corp.fedex.com>
Subject: Re: [uml-devel] UML patches against vanilla 2.6.0
In-Reply-To: <200312261905.48277.blaisorblade_spam@yahoo.it>
Message-ID: <Pine.LNX.4.58.0312280851350.2434@boston.corp.fedex.com>
References: <200312261905.48277.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 28 Dec 2003 09:07:14 +0800 (SGT)
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>, user-mode-linux-user@lists.sourceforge.net


On Fri, 26 Dec 2003, BlaisorBlade wrote:

> Now I've collected also some patches from Ingo Molnar and Michael A. Young;
> the only remaining issue with this package is with Fedora (workarounds
> available, see the Readme). Plus all the patches still to port from UML 2.4.
>

Thanks for the great pointer. I've downloaded all these patches and
finally able to boot a clean 2.6.0-1um using initrd. There seems to some
problem with network (tuntap), but I'm still looking it.

Here's what I did ...

My real linux version is 2.4.24-pre1. My /usr/src/linux points to 2.6.0
with reiser4 and Ingo Molnar's uml-combo-2.6.0-A5 patch applied ... in
order for "make menconfig" to set CONFIG_PROC_MM=y

Here's my patch against Ingo Molnar's uml-combo-2.6.0-A5 patch to make the
patch works if you use reiser4 ...

After that patch, it'll be followed by another patch pointed out by
BlaisorBlade ...


160c160
< -	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
---
> -	error = do_mmap_pgoff(current->mm, file, addr, len, prot, flags, pgoff);
6709,6749d6708
< --- linux/include/linux/mm.h.orig
< +++ linux/include/linux/mm.h
< @@ -487,6 +487,9 @@ static inline int set_page_dirty(struct
<  	return __set_page_dirty_buffers(page);
<  }
<
< +extern long do_mprotect(struct mm_struct *mm, unsigned long start,
< +			size_t len, unsigned long prot);
< +
<  /*
<   * On a two-level page table, this ends up being trivial. Thus the
<   * inlining and the symmetry break with pte_alloc_map() that does all
< @@ -517,9 +520,15 @@ extern void exit_mmap(struct mm_struct *
<
<  extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
<
< -extern unsigned long do_mmap_pgoff(struct file *file, unsigned long addr,
< -	unsigned long len, unsigned long prot,
< -	unsigned long flag, unsigned long pgoff);
< +extern long do_mmap2(struct mm_struct *mm, unsigned long addr,
< +		     unsigned long len, unsigned long prot,
< +		     unsigned long flags, unsigned long fd,
< +		     unsigned long pgoff);
< +
< +extern unsigned long do_mmap_pgoff(struct mm_struct *mm, struct file *file,
< +				   unsigned long addr, unsigned long len,
< +				   unsigned long prot, unsigned long flag,
< +				   unsigned long pgoff);
<
<  static inline unsigned long do_mmap(struct file *file, unsigned long addr,
<  	unsigned long len, unsigned long prot,
< @@ -529,7 +538,8 @@ static inline unsigned long do_mmap(stru
<  	if ((offset + PAGE_ALIGN(len)) < offset)
<  		goto out;
<  	if (!(offset & ~PAGE_MASK))
< -		ret = do_mmap_pgoff(file, addr, len, prot, flag, offset >> PAGE_SHIFT);
< +		ret = do_mmap_pgoff(current->mm, file, addr, len, prot, flag,
< +				    offset >> PAGE_SHIFT);
<  out:
<  	return ret;
<  }
9759,9833d9717
< --- linux/mm/memory.c.orig
< +++ linux/mm/memory.c
< @@ -44,6 +44,7 @@
<  #include <linux/highmem.h>
<  #include <linux/pagemap.h>
<  #include <linux/rmap-locking.h>
< +#include <linux/init.h>
<  #include <linux/module.h>
<
<  #include <asm/pgalloc.h>
< @@ -680,6 +681,24 @@ static inline struct page *get_page_map(
<  }
<
<
< +static struct vm_area_struct fixmap_vma = {
< +	/* Catch users - if there are any valid
< +	   ones, we can make this be "&init_mm" or
< +	   something.  */
< +	.vm_mm = NULL,
< +	.vm_page_prot = PAGE_READONLY,
< +	.vm_flags = VM_READ | VM_EXEC,
< +};
< +
< +static int init_fixmap_vma(void)
< +{
< +	fixmap_vma.vm_start = FIXADDR_START;
< +	fixmap_vma.vm_end = FIXADDR_TOP;
< +	return(0);
< +}
< +
< +__initcall(init_fixmap_vma);
< +
<  int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
<  		unsigned long start, int len, int write, int force,
<  		struct page **pages, struct vm_area_struct **vmas)
< @@ -700,19 +719,8 @@ int get_user_pages(struct task_struct *t
<
<  		vma = find_extend_vma(mm, start);
<
< -#ifdef FIXADDR_USER_START
< -		if (!vma &&
< -		    start >= FIXADDR_USER_START && start < FIXADDR_USER_END) {
< -			static struct vm_area_struct fixmap_vma = {
< -				/* Catch users - if there are any valid
< -				   ones, we can make this be "&init_mm" or
< -				   something.  */
< -				.vm_mm = NULL,
< -				.vm_start = FIXADDR_USER_START,
< -				.vm_end = FIXADDR_USER_END,
< -				.vm_page_prot = PAGE_READONLY,
< -				.vm_flags = VM_READ | VM_EXEC,
< -			};
< +#ifdef FIXADDR_START
< +		if (!vma && start >= FIXADDR_START && start < FIXADDR_TOP) {
<  			unsigned long pg = start & PAGE_MASK;
<  			pgd_t *pgd;
<  			pmd_t *pmd;
< --- linux/mm/mmap.c.orig
< +++ linux/mm/mmap.c
< @@ -462,11 +462,11 @@ static int vma_merge(struct mm_struct *m
<   * The caller must hold down_write(current->mm->mmap_sem).
<   */
<
< -unsigned long do_mmap_pgoff(struct file * file, unsigned long addr,
< -			unsigned long len, unsigned long prot,
< -			unsigned long flags, unsigned long pgoff)
< +unsigned long do_mmap_pgoff(struct mm_struct *mm, struct file * file,
< +			    unsigned long addr, unsigned long len,
< +			    unsigned long prot, unsigned long flags,
< +			    unsigned long pgoff)
<  {
< -	struct mm_struct * mm = current->mm;
<  	struct vm_area_struct * vma, * prev;
<  	struct inode *inode;
<  	unsigned int vm_flags;
9836,9845d9719
< @@ -222,7 +222,8 @@ fail:
<  }
<
<  asmlinkage long
< -sys_mprotect(unsigned long start, size_t len, unsigned long prot)
< +do_mprotect(struct mm_struct *mm, unsigned long start, size_t len,
< +	     unsigned long prot)
<  {
<  	unsigned long vm_flags, nstart, end, tmp;
<  	struct vm_area_struct * vma, * next, * prev;
9858,9870d9731
< @@ -326,6 +327,11 @@ sys_mprotect(unsigned long start, size_t
<  		prev->vm_mm->map_count--;
<  	}
<  out:
< -	up_write(&current->mm->mmap_sem);
< +	up_write(&mm->mmap_sem);
<  	return error;
<  }
< +
< +asmlinkage long sys_mprotect(unsigned long start, size_t len, unsigned long prot)
< +{
< +        return(do_mprotect(current->mm, start, len, prot));
< +}



On uml linux, apply the following patches from ...

http://web.tiscali.it/no-redirect-tiscali/blaisorblade/linux/archives/UML/v2/

A-01-Uml-update.patch
A-02-Hostfs+hppfs.patch
A-03-TTY_silly.patch
A-05-Compile_no_proc_mm.patch
C-01-Fix_clean_mrproper.patch
C-02-Apply_altern-constants.patch
C-03-Module_support.patch
C-04-User_obj_makefiles.patch
D-01-WarningFix.patch
E-01-Add_proc_mm_support.patch
E-02-Proc_mm_speedup.patch
F-01-i386_skas_support.patch
G-01-Align_fix.patch


Next, apply the following patches I created to make uml compiles ...

I'm no expert, but with these patches, at least I can now boot uml 2.6.0
on top of 2.4.24pre1.


Thanks,
Jeff

--- uml/include/asm/ptrace-generic.h	Sat Dec 27 23:18:48 2003
+++ uml.good/include/asm/ptrace-generic.h	Sat Dec 27 11:42:52 2003
@@ -15,7 +15,7 @@
 #define pt_regs pt_regs_subarch
 #define show_regs show_regs_subarch

-#include "asm/arch/ptrace.h"
+//#include "asm/arch/ptrace.h"

 #undef pt_regs
 #undef show_regs
--- uml/arch/um/sys-i386/bugs.c.org	Sat Dec 27 23:28:01 2003
+++ uml/arch/um/sys-i386/bugs.c	Sat Dec 27 23:29:19 2003
@@ -16,6 +16,9 @@

 #define MAXTOKEN 64

+extern int modify_ldt(int func, void *ptr, unsigned long bytecount);
+
+
 /* Set during early boot */
 int host_has_cmov = 1;
 int host_has_xmm = 0;
@@ -107,7 +110,7 @@

 static void disable_lcall(void)
 {
-	struct modify_ldt_ldt_s ldt;
+	struct user_desc ldt;
 	int err;

 	bzero(&ldt, sizeof(ldt));
--- uml/arch/um/sys-i386/ptrace_user.c	Thu Dec 18 10:58:28 2003
+++ uml.good/arch/um/sys-i386/ptrace_user.c	Sat Dec 27 11:57:03 2003
@@ -15,6 +15,28 @@
 #include "user.h"
 #include "os.h"

+#define PTRACE_TRACEME             0
+#define PTRACE_PEEKTEXT            1
+#define PTRACE_PEEKDATA            2
+#define PTRACE_PEEKUSR             3
+#define PTRACE_POKETEXT            4
+#define PTRACE_POKEDATA            5
+#define PTRACE_POKEUSR             6
+#define PTRACE_CONT                7
+#define PTRACE_KILL                8
+#define PTRACE_SINGLESTEP          9
+
+#define PTRACE_ATTACH           0x10
+#define PTRACE_DETACH           0x11
+
+#define PTRACE_SYSCALL            24
+
+#define PTRACE_FAULTINFO          52
+#define PTRACE_SIGPENDING         53
+#define PTRACE_LDT                54
+#define PTRACE_SWITCH_MM          55
+
+
 int ptrace_getregs(long pid, unsigned long *regs_out)
 {
 	return(ptrace(PTRACE_GETREGS, pid, 0, regs_out));
--- uml/arch/um/sys-i386/ptrace_user.c.org	Sat Dec 27 23:47:53 2003
+++ uml/arch/um/sys-i386/ptrace_user.c	Sat Dec 27 23:48:49 2003
@@ -7,8 +7,9 @@
 #include <errno.h>
 #include <unistd.h>
 #include <linux/stddef.h>
-#include <sys/ptrace.h>
-#include <asm/ptrace.h>
+//#include <sys/ptrace.h>
+#include <linux/ptrace.h>
+//#include <asm/ptrace.h>
 #include <asm/user.h>
 #include "kern_util.h"
 #include "sysdep/thread.h"
--- uml/arch/um/kernel/syscall_kern.c.org	Sat Dec 27 23:59:53 2003
+++ uml/arch/um/kernel/syscall_kern.c	Sun Dec 28 00:07:54 2003
@@ -76,7 +76,7 @@
 				unsigned long addr, unsigned long len,
 				unsigned long prot, unsigned long flag,
 				unsigned long pgoff) {
-	return do_mmap_pgoff(file, addr, len, prot, flag, pgoff);
+	return do_mmap_pgoff(mm, file, addr, len, prot, flag, pgoff);
 }
 #endif

--- uml/arch/i386/kernel/sys_i386.c.org	Sun Dec 28 00:12:31 2003
+++ uml/arch/i386/kernel/sys_i386.c	Sun Dec 28 00:12:54 2003
@@ -40,15 +40,6 @@
 }

 /* See this definition in arch/um/kernel/syscall_kern.c for comments.*/
-#ifndef CONFIG_PROC_MM
-static inline unsigned long __do_mmap_pgoff(
-				struct mm_struct *mm, struct file *file,
-				unsigned long addr, unsigned long len,
-				unsigned long prot, unsigned long flag,
-				unsigned long pgoff) {
-	return do_mmap_pgoff(file, addr, len, prot, flag, pgoff);
-}
-#endif

 /* common code for old and new mmaps */
 long do_mmap2(struct mm_struct *mm,
--- uml/mm/mmap.c.org	Sun Dec 28 00:17:14 2003
+++ uml/mm/mmap.c	Sun Dec 28 00:17:43 2003
@@ -714,7 +714,7 @@
 	return error;
 }

-EXPORT_SYMBOL(__do_mmap_pgoff);
+EXPORT_SYMBOL(do_mmap_pgoff);

 /* Get an address range which is currently unmapped.
  * For shmat() with addr=0.


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
