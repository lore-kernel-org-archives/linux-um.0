Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJbGu-0006Z1-RX for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Apr 2004 09:53:56 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BJbGt-0002Xo-P3 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Apr 2004 09:53:55 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Message-Id: <200404301706.55286.blaisorblade_spam@yahoo.it>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_E2mkA60cfu0WB4B"
Subject: [uml-devel] SKAS patch for 2.4.25 / x86_64
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
Date: Fri, 30 Apr 2004 17:15:16 +0200
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Matt Ayres <matta@tektonic.net>, Jani Averbach <jaa@jaa.iki.fi>, Tim Barbour <trb@eastpac.com.au>, Eric Echter <eric@jaguarpc.com>, Adam Houston <adamhouston@adamhouston.com>



--Boundary-00=_E2mkA60cfu0WB4B
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Some time ago, stimulated by requests and failed tries, I started porting the 
SKAS patch to x86_64, to run a normal 32 bit UML. It was not difficult, but I 
had no possibility to do any testing for it (not even a compile test!).

So please, if you are interested in this, try this patch! But remember it can 
be UNSTABLE, so:
1) be careful
2) post whatever result you get, even success.

Since it seems that at least some of you have the hardware / wondered if a 
such patch existed, I've decided to send it to you. I'm sorry to send you 
unrequested mail, but I need testers to get the work done.

It applies on a vanilla kernel, and cares about modifying the sys32_ syscalls 
and not the normal ones; i.e. the SKAS interface is offered only to 32 bit 
processes.

Also, there is a point: why init_new_context() is a no-op? However for i386 it 
was always so until the change in 2.4.25 to LDT handling, which broke the 
SKAS patch; that change (that comes straight from 2.6) has not been applied 
to x86_64.

Finally, in this patch I removed at all CONFIG_PROC_MM, which is 
shortcircuited to y directly in the source, rather than in .config; so no one 
will forgot either to enable it or to do "make oldconfig" and get failures.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729







--Boundary-00=_E2mkA60cfu0WB4B
Content-Type: text/x-diff; charset="us-ascii";
	name="x86_64-host-skas-Try3-2.4.25.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="x86_64-host-skas-Try3-2.4.25.patch"

--- ./mm/proc_mm.c.fix	2004-02-28 17:54:18.000000000 +0100
+++ ./mm/proc_mm.c	2004-02-28 17:54:34.000000000 +0100
@@ -0,0 +1,173 @@
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
--- ./mm/mprotect.c.fix	2003-12-06 19:47:48.000000000 +0100
+++ ./mm/mprotect.c	2004-02-28 17:54:18.000000000 +0100
@@ -264,7 +264,8 @@
 	return 0;
 }
 
-asmlinkage long sys_mprotect(unsigned long start, size_t len, unsigned long prot)
+long do_mprotect(struct mm_struct *mm, unsigned long start, size_t len, 
+		 unsigned long prot)
 {
 	unsigned long nstart, end, tmp;
 	struct vm_area_struct * vma, * next, * prev;
@@ -281,9 +282,9 @@
 	if (end == start)
 		return 0;
 
-	down_write(&current->mm->mmap_sem);
+	down_write(&mm->mmap_sem);
 
-	vma = find_vma_prev(current->mm, start, &prev);
+	vma = find_vma_prev(mm, start, &prev);
 	error = -ENOMEM;
 	if (!vma || vma->vm_start > start)
 		goto out;
@@ -332,6 +333,11 @@
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
+	return(do_mprotect(current->mm, start, len, prot));
+}
--- ./mm/Makefile.fix	2003-09-11 21:03:50.000000000 +0200
+++ ./mm/Makefile	2004-02-28 17:54:18.000000000 +0100
@@ -17,5 +17,6 @@
 	    shmem.o
 
 obj-$(CONFIG_HIGHMEM) += highmem.o
+obj-y += proc_mm.o
 
 include $(TOPDIR)/Rules.make
--- ./mm/mmap.c.fix	2004-02-20 16:18:11.000000000 +0100
+++ ./mm/mmap.c	2004-02-28 17:54:18.000000000 +0100
@@ -391,10 +391,11 @@
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
--- ./arch/x86_64/ia32/ptrace32.c.fix	2004-02-20 16:17:42.000000000 +0100
+++ ./arch/x86_64/ia32/ptrace32.c	2004-02-28 17:54:18.000000000 +0100
@@ -192,6 +192,11 @@
 	
 } 
 
+extern long modify_ldt(struct mm_struct *mm, int func, void *ptr,
+			unsigned long bytecount);
+
+extern struct mm_struct *proc_mm_get_mm(int fd);
+
 extern asmlinkage long sys_ptrace(long request, long pid, unsigned long addr, unsigned long data);
 
 asmlinkage long sys32_ptrace(long request, u32 pid, u32 addr, u32 data)
@@ -225,6 +230,12 @@
 	case PTRACE_GETFPREGS:
 	case PTRACE_SETFPXREGS:
 	case PTRACE_GETFPXREGS:
+#if 1
+	case PTRACE_FAULTINFO:
+	case PTRACE_SIGPENDING:
+	case PTRACE_LDT:
+	case PTRACE_SWITCH_MM:
+#endif
 		break;
 		
 	default:
@@ -340,6 +351,52 @@
 		ret = 0; 
 		break; 
 	} 
+#if 1
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
 		ret = -EINVAL;
--- ./arch/x86_64/ia32/sys_ia32.c.fix	2004-02-20 16:17:42.000000000 +0100
+++ ./arch/x86_64/ia32/sys_ia32.c	2004-02-28 17:54:18.000000000 +0100
@@ -338,7 +338,7 @@
 
 	mm = current->mm; 
 	down_write(&mm->mmap_sem); 
-	retval = do_mmap_pgoff(file, a.addr, a.len, a.prot, a.flags, a.offset>>PAGE_SHIFT);
+	retval = do_mmap_pgoff(current->mm, file, a.addr, a.len, a.prot, a.flags, a.offset>>PAGE_SHIFT);
 	if (file)
 		fput(file);
 
@@ -2099,7 +2099,9 @@
 	return ret;
 }
 
-asmlinkage long sys32_mmap2(unsigned long addr, unsigned long len,
+/* common code for old and new mmaps */
+long do_mmap2(struct mm_struct *mm,
+	unsigned long addr, unsigned long len,
 	unsigned long prot, unsigned long flags,
 	unsigned long fd, unsigned long pgoff)
 {
@@ -2118,7 +2120,7 @@
 		prot |= PROT_EXEC;
 
 	down_write(&mm->mmap_sem);
-	error = do_mmap_pgoff(file, addr, len, prot, flags|MAP_32BIT, pgoff);
+	error = do_mmap_pgoff(mm, file, addr, len, prot, flags|MAP_32BIT, pgoff);
 	up_write(&mm->mmap_sem);
 
 	if (file)
@@ -2126,6 +2128,15 @@
 	return error;
 }
 
+asmlinkage long sys32_mmap2(
+	unsigned long addr, unsigned long len,
+	unsigned long prot, unsigned long flags,
+	unsigned long fd, unsigned long pgoff)
+{
+	return do_mmap2(current->mm, addr, len, prot, flags, fd, pgoff);
+}
+
+
 asmlinkage long sys32_olduname(struct oldold_utsname * name)
 {
 	int error;
--- ./arch/x86_64/kernel/process.c.fix	2004-02-20 16:17:42.000000000 +0100
+++ ./arch/x86_64/kernel/process.c	2004-02-28 18:10:51.000000000 +0100
@@ -433,13 +433,11 @@
  * we do not have to muck with descriptors here, that is
  * done in switch_mm() as needed.
  */
-void copy_segments(struct task_struct *p, struct mm_struct *new_mm)
+void mm_copy_segments(struct mm_struct * old_mm, struct mm_struct *new_mm)
 {
-	struct mm_struct * old_mm;
 	void *old_ldt, *ldt;
  
 	ldt = NULL;
-	old_mm = current->mm;
 	if (old_mm && (old_ldt = old_mm->context.segments) != NULL) {
 		/*
 		 * Completely new LDT, we initialize it from the parent:
@@ -455,6 +453,11 @@
 	return;
 }
 
+void copy_segments(struct task_struct *p, struct mm_struct *new_mm)
+{
+	mm_copy_segments(current->mm, new_mm);
+}
+
 int copy_thread(int nr, unsigned long clone_flags, unsigned long rsp, 
 		unsigned long unused,
 	struct task_struct * p, struct pt_regs * regs)
--- ./arch/x86_64/kernel/sys_x86_64.c.fix	2003-12-06 19:47:09.000000000 +0100
+++ ./arch/x86_64/kernel/sys_x86_64.c	2004-02-28 17:54:18.000000000 +0100
@@ -56,7 +56,7 @@
 	}
 
 	down_write(&current->mm->mmap_sem);
-	error = do_mmap_pgoff(file, addr, len, prot, flags, off >> PAGE_SHIFT);
+	error = do_mmap_pgoff(current->mm, file, addr, len, prot, flags, off >> PAGE_SHIFT);
 	up_write(&current->mm->mmap_sem);
 
 	if (file)
--- ./arch/x86_64/kernel/ldt.c.fix	2003-06-17 17:44:16.000000000 +0200
+++ ./arch/x86_64/kernel/ldt.c	2004-02-28 18:05:38.000000000 +0100
@@ -28,11 +28,10 @@
  * assured by user-space anyway. Writes are atomic, to protect
  * the security checks done on new descriptors.
  */
-static int read_ldt(void * ptr, unsigned long bytecount)
+static int read_ldt(struct mm_struct * mm, void * ptr, unsigned long bytecount)
 {
 	int err;
 	unsigned long size;
-	struct mm_struct * mm = current->mm;
 
 	err = 0;
 	if (!mm->context.segments)
@@ -59,10 +58,8 @@
 	return bytecount; 
 }
 
-static int write_ldt(void * ptr, unsigned long bytecount, int oldmode)
+static int write_ldt(struct mm_struct * mm, void * ptr, unsigned long bytecount, int oldmode)
 {
-	struct task_struct *me = current;
-	struct mm_struct * mm = me->mm;
 	__u32 entry_1, entry_2, *lp;
 	int error;
 	struct modify_ldt_ldt_s ldt_info;
@@ -99,7 +96,8 @@
 		wmb();
 		mm->context.segments = segments;
 		mm->context.cpuvalid = 1UL << smp_processor_id();
-		load_LDT(mm);
+		if (current->active_mm == mm)
+			load_LDT(mm);
 	}
 
 	lp = (__u32 *) ((ldt_info.entry_number << 3) + (char *) mm->context.segments);
@@ -147,23 +145,28 @@
 	return error;
 }
 
-asmlinkage long sys_modify_ldt(int func, void *ptr, unsigned long bytecount)
+long modify_ldt(struct mm_struct * mm, int func, void *ptr, unsigned long bytecount)
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
 }
+
+asmlinkage long sys_modify_ldt(int func, void *ptr, unsigned long bytecount)
+{
+       return modify_ldt(current->mm, func, ptr, bytecount);
+}
--- ./include/linux/proc_mm.h.fix	2004-02-28 17:54:18.000000000 +0100
+++ ./include/linux/proc_mm.h	2004-02-28 17:54:18.000000000 +0100
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
--- ./include/linux/mm.h.fix	2003-12-06 19:47:45.000000000 +0100
+++ ./include/linux/mm.h	2004-02-28 17:54:18.000000000 +0100
@@ -505,6 +505,9 @@
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm, unsigned long start,
 		int len, int write, int force, struct page **pages, struct vm_area_struct **vmas);
 
+extern long do_mprotect(struct mm_struct *mm, unsigned long start, 
+			size_t len, unsigned long prot);
+
 /*
  * On a two-level page table, this ends up being trivial. Thus the
  * inlining and the symmetry break with pte_alloc() that does all
@@ -552,9 +555,10 @@
 
 extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
 
-extern unsigned long do_mmap_pgoff(struct file *file, unsigned long addr,
-	unsigned long len, unsigned long prot,
-	unsigned long flag, unsigned long pgoff);
+extern unsigned long do_mmap_pgoff(struct mm_struct *mm, 
+				   struct file *file, unsigned long addr,
+				   unsigned long len, unsigned long prot,
+				   unsigned long flag, unsigned long pgoff);
 
 static inline unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot,
@@ -564,7 +568,7 @@
 	if ((offset + PAGE_ALIGN(len)) < offset)
 		goto out;
 	if (!(offset & ~PAGE_MASK))
-		ret = do_mmap_pgoff(file, addr, len, prot, flag, offset >> PAGE_SHIFT);
+		ret = do_mmap_pgoff(current->mm, file, addr, len, prot, flag, offset >> PAGE_SHIFT);
 out:
 	return ret;
 }
--- ./include/asm-x86_64/ptrace.h.fix	2003-12-06 19:47:44.000000000 +0100
+++ ./include/asm-x86_64/ptrace.h	2004-02-28 17:54:18.000000000 +0100
@@ -34,6 +34,23 @@
 
 #define PTRACE_SETOPTIONS         21
 
+struct ptrace_faultinfo {
+       int is_write;
+       unsigned long addr;
+};
+
+struct ptrace_ldt {
+       int func;
+       void *ptr;
+       unsigned long bytecount;
+};
+
+#define PTRACE_FAULTINFO 52
+#define PTRACE_SIGPENDING 53
+#define PTRACE_LDT 54
+#define PTRACE_SWITCH_MM 55
+
+
 /* options set using PTRACE_SETOPTIONS */
 #define PTRACE_O_TRACESYSGOOD     0x00000001
 
--- ./include/asm-x86_64/processor.h.fix	2003-12-06 19:47:44.000000000 +0100
+++ ./include/asm-x86_64/processor.h	2004-02-28 18:31:41.000000000 +0100
@@ -361,6 +361,8 @@
 extern void copy_segments(struct task_struct *p, struct mm_struct * mm);
 extern void release_segments(struct mm_struct * mm);
 
+extern void mm_copy_segments(struct mm_struct * old_mm, struct mm_struct *new_mm);
+
 /*
  * Return saved PC of a blocked thread.
  * What is this good for? it will be always the scheduler or ret_from_fork.

--Boundary-00=_E2mkA60cfu0WB4B--



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
