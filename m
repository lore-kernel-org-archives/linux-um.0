Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AiDIz-0005gv-BQ for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 05:49:33 -0800
Received: from mx1.elte.hu ([157.181.1.137])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AiDIy-00007E-Es for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 05:49:32 -0800
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [uml-devel] uml-patch-2.6.0
Message-ID: <20040118134935.GA10490@elte.hu>
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
	<200401172009.50449.blaisorblade_spam@yahoo.it>
	<20040117195137.GB7405@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040117195137.GB7405@ccure.user-mode-linux.org>
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
Date: Sun, 18 Jan 2004 14:49:35 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net


* Jeff Dike <jdike@addtoit.com> wrote:

> > This are some brief patches descriptions (in the 00-README).
> 
> OK, I'll pull them down and start merging them in...

the ones below are needed too in addition, to make the x86 kernel
compile again. (the patch also adds those few things still missing for
host-skas3 support to work on x86.)

	Ingo

--- linux/arch/i386/kernel/sys_i386.c.orig	
+++ linux/arch/i386/kernel/sys_i386.c	
@@ -40,7 +40,7 @@ asmlinkage int sys_pipe(unsigned long __
 }
 
 /* common code for old and new mmaps */
-static inline long do_mmap2(
+long do_mmap2(struct mm_struct *mm,
 	unsigned long addr, unsigned long len,
 	unsigned long prot, unsigned long flags,
 	unsigned long fd, unsigned long pgoff)
@@ -55,9 +55,9 @@ static inline long do_mmap2(
 			goto out;
 	}
 
-	down_write(&current->mm->mmap_sem);
-	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-	up_write(&current->mm->mmap_sem);
+	down_write(&mm->mmap_sem);
+	error = do_mmap_pgoff(mm, file, addr, len, prot, flags, pgoff);
+	up_write(&mm->mmap_sem);
 
 	if (file)
 		fput(file);
@@ -69,7 +69,7 @@ asmlinkage long sys_mmap2(unsigned long 
 	unsigned long prot, unsigned long flags,
 	unsigned long fd, unsigned long pgoff)
 {
-	return do_mmap2(addr, len, prot, flags, fd, pgoff);
+	return do_mmap2(current->mm, addr, len, prot, flags, fd, pgoff);
 }
 
 /*
@@ -100,7 +100,7 @@ asmlinkage int old_mmap(struct mmap_arg_
 	if (a.offset & ~PAGE_MASK)
 		goto out;
 
-	err = do_mmap2(a.addr, a.len, a.prot, a.flags, a.fd, a.offset >> PAGE_SHIFT);
+	err = do_mmap2(current->mm, a.addr, a.len, a.prot, a.flags, a.fd, a.offset >> PAGE_SHIFT);
 out:
 	return err;
 }
--- linux/arch/i386/kernel/ptrace.c.orig	
+++ linux/arch/i386/kernel/ptrace.c	
@@ -14,6 +14,7 @@
 #include <linux/ptrace.h>
 #include <linux/user.h>
 #include <linux/security.h>
+#include <linux/proc_mm.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -507,6 +508,56 @@ asmlinkage int sys_ptrace(long request, 
 					     addr, (struct user_desc __user *) data);
 		break;
 
+	case PTRACE_FAULTINFO: {
+		struct ptrace_faultinfo fault;
+
+		fault = ((struct ptrace_faultinfo) 
+			{ .is_write	= child->thread.error_code,
+			  .addr		= child->thread.cr2 });
+		ret = copy_to_user((unsigned long *) data, &fault, 
+				   sizeof(fault));
+		if(ret)
+			break;
+		break;
+	}
+
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
+#ifdef CONFIG_PROC_MM
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
+
 	default:
 		ret = ptrace_request(child, request, addr, data);
 		break;
--- linux/arch/i386/kernel/ldt.c.orig	
+++ linux/arch/i386/kernel/ldt.c	
@@ -54,7 +54,7 @@ static int alloc_ldt(mm_context_t *pc, i
 	pc->size = mincount;
 	wmb();
 
-	if (reload) {
+	if (reload && (&current->active_mm->context == pc)) {
 #ifdef CONFIG_SMP
 		cpumask_t mask;
 		preempt_disable();
@@ -121,11 +121,11 @@ void destroy_context(struct mm_struct *m
 	}
 }
 
-static int read_ldt(void __user * ptr, unsigned long bytecount)
+static int read_ldt(struct mm_struct * mm, void __user * ptr,
+		    unsigned long bytecount)
 {
 	int err;
 	unsigned long size;
-	struct mm_struct * mm = current->mm;
 
 	if (!mm->context.size)
 		return 0;
@@ -169,9 +169,8 @@ static int read_default_ldt(void __user 
 	return err;
 }
 
-static int write_ldt(void __user * ptr, unsigned long bytecount, int oldmode)
+static int write_ldt(struct mm_struct * mm, void __user * ptr, unsigned long bytecount, int oldmode)
 {
-	struct mm_struct * mm = current->mm;
 	__u32 entry_1, entry_2, *lp;
 	int error;
 	struct user_desc ldt_info;
@@ -195,7 +194,7 @@ static int write_ldt(void __user * ptr, 
 
 	down(&mm->context.sem);
 	if (ldt_info.entry_number >= mm->context.size) {
-		error = alloc_ldt(&current->mm->context, ldt_info.entry_number+1, 1);
+		error = alloc_ldt(&mm->context, ldt_info.entry_number+1, 1);
 		if (error < 0)
 			goto out_unlock;
 	}
@@ -228,23 +227,29 @@ out:
 	return error;
 }
 
-asmlinkage int sys_modify_ldt(int func, void __user *ptr, unsigned long bytecount)
+int modify_ldt(struct mm_struct * mm, int func, void __user *ptr,
+	       unsigned long bytecount)
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
+asmlinkage int sys_modify_ldt(int func, void __user *ptr, unsigned long bytecount)
+{
+	return modify_ldt(current->mm, func, ptr, bytecount);
+}
--- linux/arch/i386/Kconfig.orig	
+++ linux/arch/i386/Kconfig	
@@ -697,6 +697,9 @@ config X86_PAE
 	depends on HIGHMEM64G
 	default y
 
+config PROC_MM
+	bool "/proc/mm support"
+
 # Common NUMA Features
 config NUMA
 	bool "Numa Memory Allocation Support"
--- linux/arch/um/kernel/ptrace.c.orig	
+++ linux/arch/um/kernel/ptrace.c	
@@ -24,11 +24,6 @@ void ptrace_disable(struct task_struct *
 { 
 }
 
-extern long do_mmap2(struct task_struct *task, unsigned long addr, 
-		     unsigned long len, unsigned long prot, 
-		     unsigned long flags, unsigned long fd,
-		     unsigned long pgoff);
-
 int sys_ptrace(long request, long pid, long addr, long data)
 {
 	struct task_struct *child;
--- linux/arch/um/include/skas_ptrace.h.orig	
+++ linux/arch/um/include/skas_ptrace.h	
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
@@ -17,6 +21,8 @@ struct ptrace_ldt {
 	unsigned long bytecount;
 };
 
+#endif
+
 #define PTRACE_FAULTINFO 52
 #define PTRACE_SIGPENDING 53
 #define PTRACE_LDT 54
--- linux/include/asm-i386/desc.h.orig	
+++ linux/include/asm-i386/desc.h	
@@ -123,6 +123,9 @@ static inline void load_LDT(mm_context_t
 	put_cpu();
 }
 
+extern int modify_ldt(struct mm_struct * mm, int func, void __user *ptr,
+		      unsigned long bytecount);
+
 #endif /* !__ASSEMBLY__ */
 
 #endif
--- linux/include/asm-i386/ptrace.h.orig	
+++ linux/include/asm-i386/ptrace.h	
@@ -59,4 +59,26 @@ struct pt_regs {
 #define instruction_pointer(regs) ((regs)->eip)
 #endif
 
+/*For SKAS3 support.*/
+#ifndef _LINUX_PTRACE_STRUCT_DEF
+#define _LINUX_PTRACE_STRUCT_DEF
+
+#define PTRACE_FAULTINFO	  52
+#define PTRACE_SIGPENDING	  53
+#define PTRACE_LDT		  54
+#define PTRACE_SWITCH_MM 	  55
+
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
+#endif /*ifndef _LINUX_PTRACE_STRUCT_DEF*/
+
 #endif
--- linux/mm/proc_mm.c.orig	
+++ linux/mm/proc_mm.c	
@@ -85,17 +85,11 @@ static ssize_t write_proc_mm(struct file
 		break;
 	}
 
-	case MM_COPY_SEGMENTS: {
-		struct mm_struct *from = proc_mm_get_mm(req.u.copy_segments);
-
-		if(IS_ERR(from)){
-			ret = PTR_ERR(from);
-			break;
-		}
-
-		mm_copy_segments(from, mm);
+	/* Not necessary anymore - for compatibility only */
+	case MM_COPY_SEGMENTS:
+		ret = count;
 		break;
-	}
+
 	default:
 		ret = -EINVAL;
 		break;


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
