Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bf3nl-0002vh-2N for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Jun 2004 14:36:33 -0700
Received: from catv-5062e6af.catv.broadband.hu ([80.98.230.175]
	helo=paprika.budape.st)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1Bf3ni-0008HE-FF for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Jun 2004 14:36:32 -0700
From: Tom Rottler <tom@multip.hu>
Message-ID: <20040628213625.GI1583@paprika.budape.st>
References: <20040628213232.GH1583@paprika.budape.st>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <20040628213232.GH1583@paprika.budape.st>
Subject: [uml-devel] Re: host and uml kernel with grsec
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
Date: Mon, 28 Jun 2004 23:36:25 +0200
To: user-mode-linux-devel@lists.sourceforge.net



--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tom Rottler [Mon, 2004 Jun 28 23:32:32 +0200]:
... I'm sorry, I forgot to attach te file. :-(
Here it is!

Regards: Tom

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="host-skas3-2.4.26-grsec-2.0.patch"

diff -ruN linux-2.4.26-grsec-2.0/Makefile linux-2.4.26-grsec-2.0-skas3/Makefile
--- linux-2.4.26-grsec-2.0/Makefile	Mon Jun 28 21:22:42 2004
+++ linux-2.4.26-grsec-2.0-skas3/Makefile	Mon Jun 28 21:35:47 2004
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
 SUBLEVEL = 26
-EXTRAVERSION = -grsec
+EXTRAVERSION = -grsec-skas-2
 
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 
diff -ruN linux-2.4.26-grsec-2.0/arch/i386/kernel/ldt.c linux-2.4.26-grsec-2.0-skas3/arch/i386/kernel/ldt.c
--- linux-2.4.26-grsec-2.0/arch/i386/kernel/ldt.c	Mon Jun 28 21:22:42 2004
+++ linux-2.4.26-grsec-2.0-skas3/arch/i386/kernel/ldt.c	Mon Jun 28 20:41:40 2004
@@ -53,7 +53,7 @@
 	wmb();
 	pc->ldt = newldt;
 	pc->size = mincount;
-	if (reload) {
+	if (reload && (&current->active_mm->context == pc)) {
 		load_LDT(pc);
 #ifdef CONFIG_SMP
 		if (current->mm->cpu_vm_mask != (1<<smp_processor_id()))
@@ -86,14 +86,12 @@
  * we do not have to muck with descriptors here, that is
  * done in switch_mm() as needed.
  */
-int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+int __init_new_context(struct mm_struct *old_mm, struct mm_struct *mm)
 {
-	struct mm_struct * old_mm;
 	int retval = 0;
 
 	init_MUTEX(&mm->context.sem);
 	mm->context.size = 0;
-	old_mm = current->mm;
 	if (old_mm && old_mm->context.size > 0) {
 		down(&old_mm->context.sem);
 		retval = copy_ldt(&mm->context, &old_mm->context);
@@ -102,6 +100,10 @@
 	return retval;
 }
 
+int init_new_context(struct task_struct *tsk, struct mm_struct *mm) {
+	return __init_new_context(current->mm, mm);
+}
+
 /*
  * No need to lock the MM as we are the last user
  * Do not touch the ldt register, we are already
@@ -118,11 +120,10 @@
 	}
 }
 
-static int read_ldt(void * ptr, unsigned long bytecount)
+static int read_ldt(struct mm_struct * mm, void * ptr, unsigned long bytecount)
 {
 	int err;
 	unsigned long size;
-	struct mm_struct * mm = current->mm;
 
 	if (!mm->context.size)
 		return 0;
@@ -166,9 +167,8 @@
 	return err;
 }
 
-static int write_ldt(void * ptr, unsigned long bytecount, int oldmode)
+static int write_ldt(struct mm_struct * mm, void * ptr, unsigned long bytecount, int oldmode)
 {
-	struct mm_struct * mm = current->mm;
 	__u32 entry_1, entry_2, *lp;
 	int error;
 	struct modify_ldt_ldt_s ldt_info;
@@ -192,7 +192,7 @@
 
 	down(&mm->context.sem);
 	if (ldt_info.entry_number >= mm->context.size) {
-		error = alloc_ldt(&current->mm->context, ldt_info.entry_number+1, 1);
+		error = alloc_ldt(&mm->context, ldt_info.entry_number+1, 1);
 		if (error < 0)
 			goto out_unlock;
 	}
@@ -247,23 +247,27 @@
 	return error;
 }
 
-asmlinkage int sys_modify_ldt(int func, void *ptr, unsigned long bytecount)
+int modify_ldt(struct mm_struct * mm, int func, void *ptr, unsigned long bytecount)
 {
 	int ret = -ENOSYS;
 
 	switch (func) {
 	case 0:
-		ret = read_ldt(ptr, bytecount);
+		ret = read_ldt(mm, ptr, bytecount);
 		break;
 	case 1:
-		ret = write_ldt(ptr, bytecount, 1);
+		ret = write_ldt(mm, ptr, bytecount, 1);
 		break;
 	case 2:
 		ret = read_default_ldt(ptr, bytecount);
 		break;
 	case 0x11:
-		ret = write_ldt(ptr, bytecount, 0);
+		ret = write_ldt(mm, ptr, bytecount, 0);
 		break;
 	}
 	return ret;
+}
+
+asmlinkage int sys_modify_ldt(int func, void *ptr, unsigned long bytecount) {
+	return modify_ldt(current->mm, func, ptr, bytecount);
 }
diff -ruN linux-2.4.26-grsec-2.0/arch/i386/kernel/ptrace.c linux-2.4.26-grsec-2.0-skas3/arch/i386/kernel/ptrace.c
--- linux-2.4.26-grsec-2.0/arch/i386/kernel/ptrace.c	Mon Jun 28 21:22:42 2004
+++ linux-2.4.26-grsec-2.0-skas3/arch/i386/kernel/ptrace.c	Mon Jun 28 20:41:40 2004
@@ -148,6 +148,11 @@
 	put_stack_long(child, EFL_OFFSET, tmp);
 }
 
+extern int modify_ldt(struct mm_struct *mm, int func, void *ptr, 
+		      unsigned long bytecount);
+
+extern struct mm_struct *proc_mm_get_mm(int fd);
+
 asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
 {
 	struct task_struct *child;
@@ -433,6 +438,53 @@
 		ret = 0;
 		break;
 	}
+
+	case PTRACE_FAULTINFO: {
+		struct ptrace_faultinfo fault;
+
+		fault = ((struct ptrace_faultinfo) 
+			{ .is_write	= child->thread.error_code,
+			  .addr		= child->thread.cr2 });
+		ret = copy_to_user((unsigned long *) data, &fault, 
+				   sizeof(fault));
+		break;
+	}
+	case PTRACE_SIGPENDING:
+		ret = copy_to_user((unsigned long *) data, 
+				   &child->pending.signal,
+				   sizeof(child->pending.signal));
+		break;
+
+	case PTRACE_LDT: {
+		struct ptrace_ldt ldt;
+
+		if(copy_from_user(&ldt, (unsigned long *) data, 
+				  sizeof(ldt))){
+			ret = -EIO;
+			break;
+		}
+		ret = modify_ldt(child->mm, ldt.func, ldt.ptr, ldt.bytecount);
+		break;
+	}
+
+#if 1 /* CONFIG_PROC_MM*/
+	case PTRACE_SWITCH_MM: {
+		struct mm_struct *old = child->mm;
+		struct mm_struct *new = proc_mm_get_mm(data);
+
+		if(IS_ERR(new)){
+			ret = PTR_ERR(new);
+			break;
+		}
+
+		atomic_inc(&new->mm_users);
+		child->mm = new;
+		child->active_mm = new;
+		mmput(old);
+		ret = 0;
+		break;
+	}
+#endif
 
 	default:
 		ret = -EIO;
diff -ruN linux-2.4.26-grsec-2.0/arch/i386/kernel/sys_i386.c linux-2.4.26-grsec-2.0-skas3/arch/i386/kernel/sys_i386.c
--- linux-2.4.26-grsec-2.0/arch/i386/kernel/sys_i386.c	Mon Jun 28 21:22:42 2004
+++ linux-2.4.26-grsec-2.0-skas3/arch/i386/kernel/sys_i386.c	Mon Jun 28 20:51:44 2004
@@ -41,7 +41,7 @@
 }
 
 /* common code for old and new mmaps */
-static inline long do_mmap2(
+long do_mmap2(struct mm_struct *mm,
 	unsigned long addr, unsigned long len,
 	unsigned long prot, unsigned long flags,
 	unsigned long fd, unsigned long pgoff)
@@ -67,9 +67,9 @@
 		goto out;
 	}
 
-	down_write(&current->mm->mmap_sem);
-	error = do_mmap(file, addr, len, prot, flags, pgoff << PAGE_SHIFT);
-	up_write(&current->mm->mmap_sem);
+	down_write(&mm->mmap_sem);
+	error = tf_do_mmap_skasgrsec(mm,file, addr, len, prot, flags, pgoff << PAGE_SHIFT);
+	up_write(&mm->mmap_sem);
 
 	if (file)
 		fput(file);
@@ -81,7 +81,7 @@
 	unsigned long prot, unsigned long flags,
 	unsigned long fd, unsigned long pgoff)
 {
-	return do_mmap2(addr, len, prot, flags, fd, pgoff);
+	return do_mmap2(current->mm, addr, len, prot, flags, fd, pgoff);
 }
 
 /*
@@ -112,7 +112,7 @@
 	if (a.offset & ~PAGE_MASK)
 		goto out;
 
-	err = do_mmap2(a.addr, a.len, a.prot, a.flags, a.fd, a.offset >> PAGE_SHIFT);
+	err = do_mmap2(current->mm, a.addr, a.len, a.prot, a.flags, a.fd, a.offset >> PAGE_SHIFT);
 out:
 	return err;
 }
diff -ruN linux-2.4.26-grsec-2.0/include/asm-i386/processor.h linux-2.4.26-grsec-2.0-skas3/include/asm-i386/processor.h
--- linux-2.4.26-grsec-2.0/include/asm-i386/processor.h	Mon Jun 28 21:22:42 2004
+++ linux-2.4.26-grsec-2.0-skas3/include/asm-i386/processor.h	Mon Jun 28 21:39:35 2004
@@ -442,6 +442,8 @@
 static inline void copy_segments(struct task_struct *p, struct mm_struct * mm) { }
 static inline void release_segments(struct mm_struct * mm) { }
 
+extern int __init_new_context(struct mm_struct *old_mm, struct mm_struct *mm);
+
 /*
  * Return saved PC of a blocked thread.
  */
diff -ruN linux-2.4.26-grsec-2.0/include/asm-i386/ptrace.h linux-2.4.26-grsec-2.0-skas3/include/asm-i386/ptrace.h
--- linux-2.4.26-grsec-2.0/include/asm-i386/ptrace.h	Fri Sep 14 23:04:08 2001
+++ linux-2.4.26-grsec-2.0-skas3/include/asm-i386/ptrace.h	Mon Jun 28 20:41:40 2004
@@ -51,6 +51,22 @@
 
 #define PTRACE_SETOPTIONS         21
 
+struct ptrace_faultinfo {
+	int is_write;
+	unsigned long addr;
+};
+
+struct ptrace_ldt {
+	int func;
+  	void *ptr;
+	unsigned long bytecount;
+};
+
+#define PTRACE_FAULTINFO 52
+#define PTRACE_SIGPENDING 53
+#define PTRACE_LDT 54
+#define PTRACE_SWITCH_MM 55
+
 /* options set using PTRACE_SETOPTIONS */
 #define PTRACE_O_TRACESYSGOOD     0x00000001
 
diff -ruN linux-2.4.26-grsec-2.0/include/linux/mm.h linux-2.4.26-grsec-2.0-skas3/include/linux/mm.h
--- linux-2.4.26-grsec-2.0/include/linux/mm.h	Mon Jun 28 21:22:42 2004
+++ linux-2.4.26-grsec-2.0-skas3/include/linux/mm.h	Mon Jun 28 21:40:29 2004
@@ -537,6 +537,9 @@
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm, unsigned long start,
 		int len, int write, int force, struct page **pages, struct vm_area_struct **vmas);
 
+extern long do_mprotect(struct mm_struct *mm, unsigned long start, 
+			size_t len, unsigned long prot);
+
 /*
  * On a two-level page table, this ends up being trivial. Thus the
  * inlining and the symmetry break with pte_alloc() that does all
@@ -584,9 +587,10 @@
 
 extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
 
-extern unsigned long do_mmap_pgoff(struct file *file, unsigned long addr,
-	unsigned long len, unsigned long prot,
-	unsigned long flag, unsigned long pgoff);
+extern unsigned long do_mmap_pgoff(struct mm_struct *mm, 
+				   struct file *file, unsigned long addr,
+				   unsigned long len, unsigned long prot,
+				   unsigned long flag, unsigned long pgoff);
 
 extern int do_munmap(struct mm_struct *, unsigned long, size_t);
 
@@ -605,10 +609,11 @@
 	if ((offset + PAGE_ALIGN(len)) < offset)
 		goto out;
 	if (!(offset & ~PAGE_MASK))
-		ret = do_mmap_pgoff(file, addr, len, prot, flag, offset >> PAGE_SHIFT);
+		ret = do_mmap_pgoff(current->mm, file, addr, len, prot, flag, offset >> PAGE_SHIFT);
 
 #ifdef CONFIG_GRKERNSEC_PAX_SEGMEXEC
-	if ((current->flags & PF_PAX_SEGMEXEC) && ret < TASK_SIZE && ((flag & MAP_TYPE) == MAP_PRIVATE)
+#define BAD_ADDR(x)>   ((unsigned long)(x) > TASK_SIZE)
+	if ((current->flags & PF_PAX_SEGMEXEC) && !BAD_ADDR(ret) && ((flag & MAP_TYPE) == MAP_PRIVATE)
 
 #ifdef CONFIG_GRKERNSEC_PAX_MPROTECT
 	    && (!(current->flags & PF_PAX_MPROTECT) || ((prot & PROT_EXEC) && file && !(prot & PROT_WRITE)))
@@ -618,11 +623,55 @@
 		unsigned long ret_m;
 		prot = prot & PROT_EXEC ? prot : PROT_NONE;
 		ret_m = do_mmap_pgoff(NULL, ret + SEGMEXEC_TASK_SIZE, 0UL, prot, flag | MAP_MIRROR | MAP_FIXED, ret);
-		if (ret_m >= TASK_SIZE) {
+		if (BAD_ADDR(ret_m)) {
 			do_munmap(current->mm, ret, len);
 			ret = ret_m;
 		}
 	}
+#undef BAD_ADDR
+#endif
+
+out:
+	return ret;
+}
+
+/* T.F. */
+static inline unsigned long tf_do_mmap_skasgrsec(struct mm_struct *mm,
+					    struct file *file, unsigned long addr,
+					    unsigned long len, unsigned long prot,
+					    unsigned long flag, unsigned long offset)
+{
+	unsigned long ret = -EINVAL;
+
+#ifdef CONFIG_GRKERNSEC_PAX_SEGMEXEC
+	if ((current->flags & PF_PAX_SEGMEXEC) &&
+	   (len > SEGMEXEC_TASK_SIZE || (addr && addr > SEGMEXEC_TASK_SIZE-len)))
+		goto out;
+#endif
+
+	if ((offset + PAGE_ALIGN(len)) < offset)
+		goto out;
+	if (!(offset & ~PAGE_MASK))
+		ret = do_mmap_pgoff(mm, file, addr, len, prot, flag, offset >> PAGE_SHIFT);
+
+#ifdef CONFIG_GRKERNSEC_PAX_SEGMEXEC
+#define BAD_ADDR(x)>   ((unsigned long)(x) > TASK_SIZE)
+	if ((current->flags & PF_PAX_SEGMEXEC) && !BAD_ADDR(ret) && ((flag & MAP_TYPE) == MAP_PRIVATE)
+
+#ifdef CONFIG_GRKERNSEC_PAX_MPROTECT
+	    && (!(current->flags & PF_PAX_MPROTECT) || ((prot & PROT_EXEC) && file && !(prot & PROT_WRITE)))
+#endif
+	   )
+      {
+		unsigned long ret_m;
+		prot = prot & PROT_EXEC ? prot : PROT_NONE;
+		ret_m = do_mmap_pgoff(mm, NULL, ret + SEGMEXEC_TASK_SIZE, 0UL, prot, flag | MAP_MIRROR | MAP_FIXED, ret);
+		if (BAD_ADDR(ret_m)) {
+			do_munmap(mm, ret, len);
+			ret = ret_m;
+		}
+	}
+#undef BAD_ADDR
 #endif
 
 out:
diff -ruN linux-2.4.26-grsec-2.0/include/linux/proc_mm.h linux-2.4.26-grsec-2.0-skas3/include/linux/proc_mm.h
--- linux-2.4.26-grsec-2.0/include/linux/proc_mm.h	Thu Jan  1 01:00:00 1970
+++ linux-2.4.26-grsec-2.0-skas3/include/linux/proc_mm.h	Mon Jun 28 20:41:40 2004
@@ -0,0 +1,44 @@
+/* 
+ * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __PROC_MM_H
+#define __PROC_MM_H
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
+#endif
diff -ruN linux-2.4.26-grsec-2.0/mm/Makefile linux-2.4.26-grsec-2.0-skas3/mm/Makefile
--- linux-2.4.26-grsec-2.0/mm/Makefile	Sat Aug  3 02:39:46 2002
+++ linux-2.4.26-grsec-2.0-skas3/mm/Makefile	Mon Jun 28 20:41:40 2004
@@ -17,5 +17,7 @@
 	    shmem.o
 
 obj-$(CONFIG_HIGHMEM) += highmem.o
+#obj-$(CONFIG_PROC_MM)
+obj-y += proc_mm.o
 
 include $(TOPDIR)/Rules.make
diff -ruN linux-2.4.26-grsec-2.0/mm/mmap.c linux-2.4.26-grsec-2.0-skas3/mm/mmap.c
--- linux-2.4.26-grsec-2.0/mm/mmap.c	Mon Jun 28 21:22:42 2004
+++ linux-2.4.26-grsec-2.0-skas3/mm/mmap.c	Mon Jun 28 20:41:40 2004
@@ -399,10 +399,11 @@
 	return 0;
 }
 
-unsigned long do_mmap_pgoff(struct file * file, unsigned long addr, unsigned long len,
-	unsigned long prot, unsigned long flags, unsigned long pgoff)
+unsigned long do_mmap_pgoff(struct mm_struct *mm, struct file * file, 
+			    unsigned long addr, unsigned long len,
+			    unsigned long prot, unsigned long flags, 
+			    unsigned long pgoff)
 {
-	struct mm_struct * mm = current->mm;
 	struct vm_area_struct * vma, * prev;
 	unsigned int vm_flags;
 	int correct_wcount = 0;
diff -ruN linux-2.4.26-grsec-2.0/mm/mprotect.c linux-2.4.26-grsec-2.0-skas3/mm/mprotect.c
--- linux-2.4.26-grsec-2.0/mm/mprotect.c	Mon Jun 28 21:22:42 2004
+++ linux-2.4.26-grsec-2.0-skas3/mm/mprotect.c	Mon Jun 28 20:45:13 2004
@@ -378,7 +378,8 @@
 }
 #endif
 
-asmlinkage long sys_mprotect(unsigned long start, size_t len, unsigned long prot)
+long do_mprotect(struct mm_struct *mm, unsigned long start, size_t len, 
+		 unsigned long prot)
 {
 	unsigned long nstart, end, tmp;
 	struct vm_area_struct * vma, * next, * prev;
@@ -406,9 +407,9 @@
 	if (end == start)
 		return 0;
 
-	down_write(&current->mm->mmap_sem);
+	down_write(&mm->mmap_sem);
 
-	vma = find_vma_prev(current->mm, start, &prev);
+	vma = find_vma_prev(mm, start, &prev);
 	error = -ENOMEM;
 	if (!vma || vma->vm_start > start)
 		goto out;
@@ -473,7 +474,12 @@
 		prev->vm_mm->map_count--;
 	}
 out:
-
-	up_write(&current->mm->mmap_sem);
+	up_write(&mm->mmap_sem);
 	return error;
 }
+
+asmlinkage long sys_mprotect(unsigned long start, size_t len, unsigned long prot)
+{
+	return(do_mprotect(current->mm, start, len, prot));
+}
+
diff -ruN linux-2.4.26-grsec-2.0/mm/proc_mm.c linux-2.4.26-grsec-2.0-skas3/mm/proc_mm.c
--- linux-2.4.26-grsec-2.0/mm/proc_mm.c	Thu Jan  1 01:00:00 1970
+++ linux-2.4.26-grsec-2.0-skas3/mm/proc_mm.c	Mon Jun 28 20:41:40 2004
@@ -0,0 +1,174 @@
+/* 
+ * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
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
+
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
+		/*mm_copy_segments(from, mm);*/
+		__init_new_context(from, mm);
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

--IS0zKkzwUGydFO0o--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
