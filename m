Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ArLtN-0000rR-DL
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 12 Feb 2004 10:48:53 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1ArLs5-0000Hu-KU
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 12 Feb 2004 10:47:33 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
References: <200402101946.30709.blaisorblade_spam@yahoo.it> <20040210191156.GA27600@elte.hu>
In-Reply-To: <20040210191156.GA27600@elte.hu>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_T9nKAnoB2Mqf0xG"
Message-Id: <200402112015.31064.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Hopefully working skas patch against 2.6.2
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
Date: Wed, 11 Feb 2004 20:15:31 +0100
To: Ingo Molnar <mingo@elte.hu>
Cc: user-mode-linux-devel@lists.sourceforge.net



--Boundary-00=_T9nKAnoB2Mqf0xG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

First, for testers: read the final part of this mail, to find how to 
SKAS-patch a 2.6.2 host kernel.

> i dont have a clean diff right now, but below find what i did to ldt.c.
> Call the new __init_new_context() with the right arguments from
> proc_mm.c and it will all work.
>
> 	Ingo
>
> /*
>  * we do not have to muck with descriptors here, that is
>  * done in switch_mm() as needed.
>  */
> int __init_new_context(struct task_struct *tsk, struct mm_struct *mm,
> struct mm_struct *old_mm) {
> 	int retval = 0;
>
> 	init_MUTEX(&mm->context.sem);
> 	mm->context.size = 0;
> 	memset(mm->context.ldt_pages, 0, sizeof(struct page *) * MAX_LDT_PAGES);

That lines comes from a patch in 2.6.2-mm1 (which creates ldt_pages instead of 
ldt) so I dropped it.

> 	if (old_mm && old_mm->context.size > 0) {
> 		down(&old_mm->context.sem);
> 		retval = copy_ldt(mm, &old_mm->context);

In vanilla 2.6.2 this is "retval = copy_ldt(&mm->context, &old_mm->context);" 
which I used; it seems trivial, but if it's not it's here so you can kill me.

> 		up(&old_mm->context.sem);
> 	}
> 	return retval;
> }

But there "tsk" is at all unused, right? So I dropped that parameter.

> /*
>  * we do not have to muck with descriptors here, that is
>  * done in switch_mm() as needed.
>  */
> int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
> {
> 	return __init_new_context(tsk, mm, current->mm);
> }

Ok, I'm attaching for any comments the diff I got from the above code, with 
the changes I remarked above. The E-01 part on my site is unchanged (attached 
for reference, too). This diff replaces the MM_COPY_SEGMENTS nullification in 
mm/proc_mm.c. I've tested it and I could run both a 2.4 and a 2.6 Uml kernel 
in skas mode.

Only problem is that the first time I started a 2.4 I got a kernel panic (the 
"kernel panic with no mm-in idle task - not syncing" message) I couldn't read 
a lot about (I lost the messages because rxvt has no memory). However that 
was non-repeatable (I had once another non-repeatable crash, which probably 
comes from somewhere else), and once started everything worked like a charm.

I'd like to see it checked *before* I upload it since, for past experience, if 
I upload a new patch, that *must* be broken (only I cannot see what's wrong 
this time).

For brave users who want to test it (and report to this ML not only failures, 
but even successes):

You must apply onto a vanilla 2.6.2 the uml-patch-2.6.2-0, the 2.6.2-v1 combo 
patch, the patch at this URL:

http://web.tiscali.it/blaisorblade/linux/archives/UML/2.6.2-v1-host-skas/00-2.6.2-v1-host-SKAS.patch.bz2

and then the "New-SKAS-completion.patch" file I'm attaching to this mail, and 
then enable /proc/mm, to build a host-skas kernel.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_T9nKAnoB2Mqf0xG
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="New-SKAS-completion.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="New-SKAS-completion.patch"

--- ./arch/i386/kernel/ldt.c.fix	2004-02-06 20:53:57.000000000 +0100
+++ ./arch/i386/kernel/ldt.c	2004-02-11 19:09:10.000000000 +0100
@@ -89,14 +89,12 @@
  * we do not have to muck with descriptors here, that is
  * done in switch_mm() as needed.
  */
-int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+int __init_new_context(struct mm_struct *mm, struct mm_struct *old_mm)
 {
-	struct mm_struct * old_mm;
 	int retval = 0;
 
 	init_MUTEX(&mm->context.sem);
 	mm->context.size = 0;
-	old_mm = current->mm;
 	if (old_mm && old_mm->context.size > 0) {
 		down(&old_mm->context.sem);
 		retval = copy_ldt(&mm->context, &old_mm->context);
@@ -105,6 +103,11 @@
 	return retval;
 }
 
+int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+{
+	return __init_new_context(mm, current->mm);
+}
+
 /*
  * No need to lock the MM as we are the last user
  */
--- ./include/asm-i386/processor.h.fix	2004-01-09 21:27:46.000000000 +0100
+++ ./include/asm-i386/processor.h	2004-02-11 19:13:22.000000000 +0100
@@ -630,4 +630,6 @@
 
 extern void select_idle_routine(const struct cpuinfo_x86 *c);
 
+extern int __init_new_context(struct mm_struct *mm, struct mm_struct *old_mm);
+
 #endif /* __ASM_I386_PROCESSOR_H */
--- ./include/asm-um/processor-generic.h.fix	2004-02-05 16:45:11.000000000 +0100
+++ ./include/asm-um/processor-generic.h	2004-02-11 18:52:49.000000000 +0100
@@ -101,9 +101,9 @@
 
 extern unsigned long thread_saved_pc(struct task_struct *t);
 
-static inline void mm_copy_segments(struct mm_struct *from_mm, 
-				    struct mm_struct *new_mm)
+static inline int __init_new_context(struct mm_struct *mm, struct mm_struct *old_mm)
 {
+  return 0;
 }
 
 #define init_stack	(init_thread_union.stack)
--- ./mm/proc_mm.c.fix	2004-02-11 18:30:14.000000000 +0100
+++ ./mm/proc_mm.c	2004-02-11 18:52:40.000000000 +0100
@@ -93,7 +93,7 @@
 			break;
 		}
 
-		mm_copy_segments(from, mm);
+		__init_new_context(mm, from);
 		break;
 	}
 	default:

--Boundary-00=_T9nKAnoB2Mqf0xG
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="E-01-Add_proc_mm_support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="E-01-Add_proc_mm_support.patch"

--- linux-2.6.0/arch/um/include/skas_ptrace.h.Skas_add	2003-12-31 17:11:48.000000000 +0100
+++ linux-2.6.0/arch/um/include/skas_ptrace.h	2003-12-31 17:14:03.000000000 +0100
@@ -6,6 +6,10 @@
 #ifndef __SKAS_PTRACE_H
 #define __SKAS_PTRACE_H
 
+
+#ifndef _LINUX_PTRACE_STRUCT_DEF
+#define _LINUX_PTRACE_STRUCT_DEF
+
 struct ptrace_faultinfo {
 	int is_write;
 	unsigned long addr;
@@ -17,6 +21,8 @@
 	unsigned long bytecount;
 };
 
+#endif /*ifndef _LINUX_PTRACE_STRUCT_DEF*/
+
 #define PTRACE_FAULTINFO 52
 #define PTRACE_SIGPENDING 53
 #define PTRACE_LDT 54
--- linux-2.6.0/arch/um/Kconfig.Skas_add	2003-12-31 17:13:35.000000000 +0100
+++ linux-2.6.0/arch/um/Kconfig	2003-12-31 17:13:57.000000000 +0100
@@ -197,6 +197,9 @@
 config HIGHMEM
 	bool "Highmem support"
 
+config PROC_MM
+	bool "/proc/mm support"
+
 config KERNEL_STACK_ORDER
 	int "Kernel stack size order"
 	default 2
--- linux-2.6.0/include/linux/mm.h.Skas_add	2003-12-31 11:55:31.000000000 +0100
+++ linux-2.6.0/include/linux/mm.h	2003-12-31 17:13:57.000000000 +0100
@@ -507,6 +507,9 @@
 	return __set_page_dirty_buffers(page);
 }
 
+extern long do_mprotect(struct mm_struct *mm, unsigned long start, 
+			size_t len, unsigned long prot);
+
 /*
  * On a two-level page table, this ends up being trivial. Thus the
  * inlining and the symmetry break with pte_alloc_map() that does all
@@ -537,9 +540,15 @@
 
 extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
 
-extern unsigned long do_mmap_pgoff(struct file *file, unsigned long addr,
+extern unsigned long __do_mmap_pgoff(struct mm_struct *mm, struct file *file, 
+				   unsigned long addr, unsigned long len,
+				   unsigned long prot, unsigned long flag,
+				   unsigned long pgoff);
+static inline unsigned long do_mmap_pgoff(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot,
-	unsigned long flag, unsigned long pgoff);
+	unsigned long flag, unsigned long pgoff) {
+	return __do_mmap_pgoff(current->mm, file, addr, len, prot, flag, pgoff);
+}
 
 static inline unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot,
--- linux-2.6.0/include/linux/proc_mm.h.Skas_add	2003-12-31 11:55:31.000000000 +0100
+++ linux-2.6.0/include/linux/proc_mm.h	2003-12-31 17:13:57.000000000 +0100
@@ -0,0 +1,48 @@
+/* 
+ * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __PROC_MM_H
+#define __PROC_MM_H
+
+#include "linux/sched.h"
+
+#define MM_MMAP 54
+#define MM_MUNMAP 55
+#define MM_MPROTECT 56
+#define MM_COPY_SEGMENTS 57
+
+struct mm_mmap {
+	unsigned long addr;
+	unsigned long len;
+	unsigned long prot;
+	unsigned long flags;
+	unsigned long fd;
+	unsigned long offset;
+};
+
+struct mm_munmap {
+	unsigned long addr;
+	unsigned long len;	
+};
+
+struct mm_mprotect {
+	unsigned long addr;
+	unsigned long len;
+        unsigned int prot;
+};
+
+struct proc_mm_op {
+	int op;
+	union {
+		struct mm_mmap mmap;
+		struct mm_munmap munmap;
+	        struct mm_mprotect mprotect;
+		int copy_segments;
+	} u;
+};
+
+extern struct mm_struct *proc_mm_get_mm(int fd);
+
+#endif
--- linux-2.6.0/mm/mmap.c.Skas_add	2003-12-31 11:55:32.000000000 +0100
+++ linux-2.6.0/mm/mmap.c	2003-12-31 17:13:57.000000000 +0100
@@ -460,11 +460,11 @@
  * The caller must hold down_write(current->mm->mmap_sem).
  */
 
-unsigned long do_mmap_pgoff(struct file * file, unsigned long addr,
-			unsigned long len, unsigned long prot,
-			unsigned long flags, unsigned long pgoff)
+unsigned long __do_mmap_pgoff(struct mm_struct *mm, struct file * file, 
+			    unsigned long addr, unsigned long len,
+			    unsigned long prot, unsigned long flags,
+			    unsigned long pgoff)
 {
-	struct mm_struct * mm = current->mm;
 	struct vm_area_struct * vma, * prev;
 	struct inode *inode;
 	unsigned int vm_flags;
@@ -712,7 +712,7 @@
 	return error;
 }
 
-EXPORT_SYMBOL(do_mmap_pgoff);
+EXPORT_SYMBOL(__do_mmap_pgoff);
 
 /* Get an address range which is currently unmapped.
  * For shmat() with addr=0.
--- linux-2.6.0/mm/mprotect.c.Skas_add	2003-12-31 11:55:32.000000000 +0100
+++ linux-2.6.0/mm/mprotect.c	2003-12-31 17:13:57.000000000 +0100
@@ -222,7 +222,8 @@
 }
 
 asmlinkage long
-sys_mprotect(unsigned long start, size_t len, unsigned long prot)
+do_mprotect(struct mm_struct *mm, unsigned long start, size_t len, 
+	     unsigned long prot)
 {
 	unsigned long vm_flags, nstart, end, tmp;
 	struct vm_area_struct * vma, * next, * prev;
@@ -245,9 +246,9 @@
 
 	vm_flags = calc_vm_prot_bits(prot);
 
-	down_write(&current->mm->mmap_sem);
+	down_write(&mm->mmap_sem);
 
-	vma = find_vma_prev(current->mm, start, &prev);
+	vma = find_vma_prev(mm, start, &prev);
 	error = -ENOMEM;
 	if (!vma)
 		goto out;
@@ -326,6 +327,11 @@
 		prev->vm_mm->map_count--;
 	}
 out:
-	up_write(&current->mm->mmap_sem);
+	up_write(&mm->mmap_sem);
 	return error;
 }
+
+asmlinkage long sys_mprotect(unsigned long start, size_t len, unsigned long prot)
+{
+        return(do_mprotect(current->mm, start, len, prot));
+}
--- linux-2.6.0/mm/proc_mm.c.Skas_add	2003-12-31 11:55:32.000000000 +0100
+++ linux-2.6.0/mm/proc_mm.c	2003-12-31 17:13:57.000000000 +0100
@@ -0,0 +1,174 @@
+/* 
+ * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#include "linux/mm.h"
+#include "linux/init.h"
+#include "linux/proc_fs.h"
+#include "linux/proc_mm.h"
+#include "linux/file.h"
+#include "asm/uaccess.h"
+#include "asm/mmu_context.h"
+
+static struct file_operations proc_mm_fops;
+
+struct mm_struct *proc_mm_get_mm(int fd)
+{
+	struct mm_struct *ret = ERR_PTR(-EBADF);
+	struct file *file;
+
+	file = fget(fd);
+	if (!file)
+		goto out;
+
+	ret = ERR_PTR(-EINVAL);
+	if(file->f_op != &proc_mm_fops)
+		goto out_fput;
+
+	ret = file->private_data;
+ out_fput:
+	fput(file);
+ out:
+	return(ret);
+}
+
+extern long do_mmap2(struct mm_struct *mm, unsigned long addr, 
+		     unsigned long len, unsigned long prot, 
+		     unsigned long flags, unsigned long fd,
+		     unsigned long pgoff);
+
+static ssize_t write_proc_mm(struct file *file, const char *buffer,
+			     size_t count, loff_t *ppos)
+{
+	struct mm_struct *mm = file->private_data;
+	struct proc_mm_op req;
+	int n, ret;
+
+	if(count > sizeof(req))
+		return(-EINVAL);
+
+	n = copy_from_user(&req, buffer, count);
+	if(n != 0)
+		return(-EFAULT);
+
+	ret = count;
+	switch(req.op){
+	case MM_MMAP: {
+		struct mm_mmap *map = &req.u.mmap;
+
+		ret = do_mmap2(mm, map->addr, map->len, map->prot, 
+			       map->flags, map->fd, map->offset >> PAGE_SHIFT);
+		if((ret & ~PAGE_MASK) == 0)
+			ret = count;
+	
+		break;
+	}
+	case MM_MUNMAP: {
+		struct mm_munmap *unmap = &req.u.munmap;
+
+		down_write(&mm->mmap_sem);
+		ret = do_munmap(mm, unmap->addr, unmap->len);
+		up_write(&mm->mmap_sem);
+
+		if(ret == 0)
+			ret = count;
+		break;
+	}
+	case MM_MPROTECT: {
+		struct mm_mprotect *protect = &req.u.mprotect;
+
+		ret = do_mprotect(mm, protect->addr, protect->len, 
+				  protect->prot);
+		if(ret == 0)
+			ret = count;
+		break;
+	}
+
+	case MM_COPY_SEGMENTS: {
+		struct mm_struct *from = proc_mm_get_mm(req.u.copy_segments);
+
+		if(IS_ERR(from)){
+			ret = PTR_ERR(from);
+			break;
+		}
+
+		mm_copy_segments(from, mm);
+		break;
+	}
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return(ret);
+}
+
+static int open_proc_mm(struct inode *inode, struct file *file)
+{
+	struct mm_struct *mm = mm_alloc();
+	int ret;
+
+	ret = -ENOMEM;
+	if(mm == NULL)
+		goto out_mem;
+
+	ret = init_new_context(current, mm);
+	if(ret)
+		goto out_free;
+
+	spin_lock(&mmlist_lock);
+	list_add(&mm->mmlist, &current->mm->mmlist);
+	mmlist_nr++;
+	spin_unlock(&mmlist_lock);
+
+	file->private_data = mm;
+
+	return(0);
+
+ out_free:
+	mmput(mm);
+ out_mem:
+	return(ret);
+}
+
+static int release_proc_mm(struct inode *inode, struct file *file)
+{
+	struct mm_struct *mm = file->private_data;
+
+	mmput(mm);
+	return(0);
+}
+
+static struct file_operations proc_mm_fops = {
+	.open		= open_proc_mm,
+	.release	= release_proc_mm,
+	.write		= write_proc_mm,
+};
+
+static int make_proc_mm(void)
+{
+	struct proc_dir_entry *ent;
+
+	ent = create_proc_entry("mm", 0222, &proc_root);
+	if(ent == NULL){
+		printk("make_proc_mm : Failed to register /proc/mm\n");
+		return(0);
+	}
+	ent->proc_fops = &proc_mm_fops;
+
+	return(0);
+}
+
+__initcall(make_proc_mm);
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
--- linux-2.6.0/mm/Makefile.Skas_add	2003-12-31 11:55:32.000000000 +0100
+++ linux-2.6.0/mm/Makefile	2003-12-31 17:13:57.000000000 +0100
@@ -12,3 +12,5 @@
 			   slab.o swap.o truncate.o vmscan.o $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
+obj-$(CONFIG_PROC_MM)	+= proc_mm.o
+
diff -urN vanilla-linux-2.6.2/arch/um/kernel/syscall_kern.c linux-2.6.2/arch/um/kernel/syscall_kern.c
--- vanilla-linux-2.6.2/arch/um/kernel/syscall_kern.c	2003-12-20 17:20:03.000000000 +0100
+++ linux-2.6.2/arch/um/kernel/syscall_kern.c	2004-02-05 16:45:11.000000000 +0100
@@ -66,10 +66,9 @@
 }
 
 /* common code for old and new mmaps */
-static inline long do_mmap2(
-	unsigned long addr, unsigned long len,
-	unsigned long prot, unsigned long flags,
-	unsigned long fd, unsigned long pgoff)
+long do_mmap2(struct mm_struct *mm, unsigned long addr, unsigned long len,
+	      unsigned long prot, unsigned long flags, unsigned long fd,
+	      unsigned long pgoff)
 {
 	int error = -EBADF;
 	struct file * file = NULL;
@@ -81,9 +80,9 @@
 			goto out;
 	}
 
-	down_write(&current->mm->mmap_sem);
-	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-	up_write(&current->mm->mmap_sem);
+	down_write(&mm->mmap_sem);
+	error = __do_mmap_pgoff(mm, file, addr, len, prot, flags, pgoff);
+	up_write(&mm->mmap_sem);
 
 	if (file)
 		fput(file);
@@ -95,7 +94,7 @@
 	       unsigned long prot, unsigned long flags,
 	       unsigned long fd, unsigned long pgoff)
 {
-	return do_mmap2(addr, len, prot, flags, fd, pgoff);
+	return do_mmap2(current->mm, addr, len, prot, flags, fd, pgoff);
 }
 
 /*
@@ -122,7 +121,8 @@
 	if (offset & ~PAGE_MASK)
 		goto out;
 
-	err = do_mmap2(addr, len, prot, flags, fd, offset >> PAGE_SHIFT);
+	err = do_mmap2(current->mm, addr, len, prot, flags, fd, 
+		       offset >> PAGE_SHIFT);
  out:
 	return err;
 }

--Boundary-00=_T9nKAnoB2Mqf0xG--



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
