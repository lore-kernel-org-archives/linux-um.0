Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I8z9C-0003N8-8W for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Jul 2007 06:55:59 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user87614)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I8z96-0006ys-91
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Jul 2007 06:55:56 -0700
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18])
	by mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id
	l6CDtkG4008326 for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 12 Jul 2007 14:55:46 +0100
References: <87odihsrvs.fsf@hades.wkstn.nix>
From: Nix <nix@esperi.org.uk>
Date: Thu, 12 Jul 2007 14:55:46 +0100
In-Reply-To: <87odihsrvs.fsf@hades.wkstn.nix> (nix@esperi.org.uk's message of
	"Thu, 12 Jul 2007 13:55:51 +0100")
Message-ID: <87bqehsp3x.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Subject: Re: [uml-devel] block layer request length increases break 2.6.22.*
	COW ubd
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

On 12 Jul 2007, nix@esperi.org.uk stated:
> My firewall has long been a UML instance sitting atop a COW-backed UBD,
> with the UBD being marked immutable and sha1-checked against a copy
> on a CD-R every boot.

... aaand Jeff solved it two days ago and I didn't notice. Er, oops?

Here, have a skas-v9-pre9 patch forward-ported to 2.6.22 in restitution
of my idiocy.

(The 2.6.20 patch, the most recent I could find, collided with paravirt
and the header-inclusion reduction work. My fix to the latter is
especially ugly, since it means that <linux/mm.h> is including
<asm/current.h> and <linux/sched.h> again.  Probably the right fix is
for do_mmap_pgoff() to no longer be inlined, but I'm not sure what
performance implications that might have.)

(Compile-tested only so far.)

Index: i686-loki/arch/i386/Kconfig
===================================================================
--- i686-loki.orig/arch/i386/Kconfig	2007-07-12 14:19:46.000000000 +0100
+++ i686-loki/arch/i386/Kconfig	2007-07-12 13:59:19.000000000 +0100
@@ -601,6 +601,26 @@
 	default y
 	select RESOURCES_64BIT
 
+config PROC_MM
+	bool "/proc/mm support"
+	default y
+
+config PROC_MM_DUMPABLE
+	bool "Make UML childs /proc/<pid> completely browsable"
+	default n
+	help
+	  If in doubt, say N.
+
+	  This fiddles with some settings to make sure /proc/<pid> is completely
+	  browsable by who started UML, at the expense of some additional
+	  locking (maybe this could slow down the runned UMLs of a few percents,
+	  I've not tested this).
+
+	  Also, if there is a bug in this feature, there is some little
+	  possibility to do privilege escalation if you have UML installed
+	  setuid (which you shouldn't have done) or if UML changes uid on
+	  startup (which will be a good thing, when enabled) ...
+
 # Common NUMA Features
 config NUMA
 	bool "Numa Memory Allocation and Scheduler Support"
Index: i686-loki/arch/i386/kernel/ldt.c
===================================================================
--- i686-loki.orig/arch/i386/kernel/ldt.c	2007-07-12 14:19:46.000000000 +0100
+++ i686-loki/arch/i386/kernel/ldt.c	2007-07-12 13:59:19.000000000 +0100
@@ -27,11 +27,12 @@
 }
 #endif
 
-static int alloc_ldt(mm_context_t *pc, int mincount, int reload)
+static int alloc_ldt(struct mm_struct *mm, int mincount, int reload)
 {
 	void *oldldt;
 	void *newldt;
 	int oldsize;
+	mm_context_t * pc = &mm->context;
 
 	if (mincount <= pc->size)
 		return 0;
@@ -58,13 +59,15 @@
 #ifdef CONFIG_SMP
 		cpumask_t mask;
 		preempt_disable();
-		load_LDT(pc);
+		if (&current->active_mm->context == pc)
+			load_LDT(pc);
 		mask = cpumask_of_cpu(smp_processor_id());
-		if (!cpus_equal(current->mm->cpu_vm_mask, mask))
+		if (!cpus_equal(mm->cpu_vm_mask, mask))
 			smp_call_function(flush_ldt, NULL, 1, 1);
 		preempt_enable();
 #else
-		load_LDT(pc);
+		if (&current->active_mm->context == pc)
+			load_LDT(pc);
 #endif
 	}
 	if (oldsize) {
@@ -76,12 +79,12 @@
 	return 0;
 }
 
-static inline int copy_ldt(mm_context_t *new, mm_context_t *old)
+static inline int copy_ldt(struct mm_struct *new, struct mm_struct *old)
 {
-	int err = alloc_ldt(new, old->size, 0);
+	int err = alloc_ldt(new, old->context.size, 0);
 	if (err < 0)
 		return err;
-	memcpy(new->ldt, old->ldt, old->size*LDT_ENTRY_SIZE);
+	memcpy(new->context.ldt, old->context.ldt, old->context.size*LDT_ENTRY_SIZE);
 	return 0;
 }
 
@@ -89,22 +92,24 @@
  * we do not have to muck with descriptors here, that is
  * done in switch_mm() as needed.
  */
-int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+int copy_context(struct mm_struct *mm, struct mm_struct *old_mm)
 {
-	struct mm_struct * old_mm;
 	int retval = 0;
 
-	init_MUTEX(&mm->context.sem);
-	mm->context.size = 0;
-	old_mm = current->mm;
 	if (old_mm && old_mm->context.size > 0) {
 		down(&old_mm->context.sem);
-		retval = copy_ldt(&mm->context, &old_mm->context);
+		retval = copy_ldt(mm, old_mm);
 		up(&old_mm->context.sem);
 	}
 	return retval;
 }
 
+int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+{
+	init_new_empty_context(mm);
+	return copy_context(mm, current->mm);
+}
+
 /*
  * No need to lock the MM as we are the last user
  */
@@ -121,11 +126,11 @@
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
@@ -172,9 +177,8 @@
 	return err;
 }
 
-static int write_ldt(void __user * ptr, unsigned long bytecount, int oldmode)
+static int write_ldt(struct mm_struct * mm, void __user * ptr, unsigned long bytecount, int oldmode)
 {
-	struct mm_struct * mm = current->mm;
 	__u32 entry_1, entry_2;
 	int error;
 	struct user_desc ldt_info;
@@ -198,7 +202,7 @@
 
 	down(&mm->context.sem);
 	if (ldt_info.entry_number >= mm->context.size) {
-		error = alloc_ldt(&current->mm->context, ldt_info.entry_number+1, 1);
+		error = alloc_ldt(mm, ldt_info.entry_number+1, 1);
 		if (error < 0)
 			goto out_unlock;
 	}
@@ -228,23 +232,33 @@
 	return error;
 }
 
-asmlinkage int sys_modify_ldt(int func, void __user *ptr, unsigned long bytecount)
+int __modify_ldt(struct mm_struct * mm, int func, void __user *ptr,
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
+	int ret = __modify_ldt(current->mm, func, ptr, bytecount);
+	/* A tail call would reorder parameters on the stack and they would then
+	 * be restored at the wrong places. */
+	prevent_tail_call(ret);
+	return ret;
+}
Index: i686-loki/arch/i386/kernel/ptrace.c
===================================================================
--- i686-loki.orig/arch/i386/kernel/ptrace.c	2007-07-12 14:19:46.000000000 +0100
+++ i686-loki/arch/i386/kernel/ptrace.c	2007-07-12 13:59:19.000000000 +0100
@@ -16,6 +16,7 @@
 #include <linux/audit.h>
 #include <linux/seccomp.h>
 #include <linux/signal.h>
+#include <linux/proc_mm.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -620,6 +621,66 @@
 					(struct user_desc __user *) data);
 		break;
 
+#ifdef CONFIG_PROC_MM
+	case PTRACE_EX_FAULTINFO: {
+		struct ptrace_ex_faultinfo fault;
+
+		fault = ((struct ptrace_ex_faultinfo)
+			{ .is_write	= child->thread.error_code,
+			  .addr		= child->thread.cr2,
+			  .trap_no	= child->thread.trap_no });
+		ret = copy_to_user((unsigned long *) data, &fault,
+				   sizeof(fault));
+		break;
+	}
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
+
+	case PTRACE_LDT: {
+		struct ptrace_ldt ldt;
+
+		if(copy_from_user(&ldt, (unsigned long *) data,
+				  sizeof(ldt))){
+			ret = -EIO;
+			break;
+		}
+		ret = __modify_ldt(child->mm, ldt.func, ldt.ptr, ldt.bytecount);
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
+
+		lock_fix_dumpable_setting(child, new);
+
+		child->mm = new;
+		child->active_mm = new;
+
+		task_unlock(child);
+
+		mmput(old);
+		ret = 0;
+		break;
+	}
+#endif
+
 	default:
 		ret = ptrace_request(child, request, addr, data);
 		break;
Index: i686-loki/arch/i386/kernel/sys_i386.c
===================================================================
--- i686-loki.orig/arch/i386/kernel/sys_i386.c	2007-07-12 14:19:46.000000000 +0100
+++ i686-loki/arch/i386/kernel/sys_i386.c	2007-07-12 13:59:19.000000000 +0100
@@ -22,6 +22,7 @@
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 #include <asm/ipc.h>
+#include <asm/proc_mm.h>
 
 /*
  * sys_pipe() is the normal C calling standard for creating
@@ -40,13 +41,12 @@
 	return error;
 }
 
-asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
-			  unsigned long prot, unsigned long flags,
-			  unsigned long fd, unsigned long pgoff)
+long do_mmap2(struct mm_struct *mm, unsigned long addr, unsigned long len,
+		unsigned long prot, unsigned long flags, unsigned long fd,
+		unsigned long pgoff)
 {
 	int error = -EBADF;
 	struct file *file = NULL;
-	struct mm_struct *mm = current->mm;
 
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
 	if (!(flags & MAP_ANONYMOUS)) {
@@ -56,7 +56,7 @@
 	}
 
 	down_write(&mm->mmap_sem);
-	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
+	error = __do_mmap_pgoff(mm, file, addr, len, prot, flags, pgoff);
 	up_write(&mm->mmap_sem);
 
 	if (file)
@@ -65,6 +65,18 @@
 	return error;
 }
 
+asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
+       unsigned long prot, unsigned long flags,
+       unsigned long fd, unsigned long pgoff)
+{
+	long ret = do_mmap2(current->mm, addr, len, prot, flags, fd, pgoff);
+
+	/* A tail call would reorder parameters on the stack and they would then
+	 * be restored at the wrong places. */
+	prevent_tail_call(ret);
+	return ret;
+}
+
 /*
  * Perform the select(nd, in, out, ex, tv) and mmap() system
  * calls. Linux/i386 didn't use to be able to handle more than
@@ -93,8 +105,11 @@
 	if (a.offset & ~PAGE_MASK)
 		goto out;
 
-	err = sys_mmap2(a.addr, a.len, a.prot, a.flags,
+	err = do_mmap2(current->mm, a.addr, a.len, a.prot, a.flags,
 			a.fd, a.offset >> PAGE_SHIFT);
+	/* A tail call would reorder parameters on the stack and they would then
+	 * be restored at the wrong places. */
+	prevent_tail_call(err);
 out:
 	return err;
 }
Index: i686-loki/arch/um/include/skas_ptrace.h
===================================================================
--- i686-loki.orig/arch/um/include/skas_ptrace.h	2007-07-12 14:19:46.000000000 +0100
+++ i686-loki/arch/um/include/skas_ptrace.h	2007-07-12 13:59:19.000000000 +0100
@@ -6,6 +6,8 @@
 #ifndef __SKAS_PTRACE_H
 #define __SKAS_PTRACE_H
 
+#ifndef PTRACE_FAULTINFO
+
 #define PTRACE_FAULTINFO 52
 #define PTRACE_SWITCH_MM 55
 
@@ -13,6 +15,8 @@
 
 #endif
 
+#endif
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
Index: i686-loki/arch/x86_64/Kconfig
===================================================================
--- i686-loki.orig/arch/x86_64/Kconfig	2007-07-12 14:19:46.000000000 +0100
+++ i686-loki/arch/x86_64/Kconfig	2007-07-12 13:59:19.000000000 +0100
@@ -514,6 +514,26 @@
 	  access 32-bits of memory can be used on systems with more than
 	  3 GB of memory. If unsure, say Y.
 
+config PROC_MM
+	bool "/proc/mm support"
+	default y
+
+config PROC_MM_DUMPABLE
+	bool "Make UML childs /proc/<pid> completely browsable"
+	default n
+	help
+	  If in doubt, say N.
+
+	  This fiddles with some settings to make sure /proc/<pid> is completely
+	  browsable by who started UML, at the expense of some additional
+	  locking (maybe this could slow down the runned UMLs of a few percents,
+	  I've not tested this).
+
+	  Also, if there is a bug in this feature, there is some little
+	  possibility to do privilege escalation if you have UML installed
+	  setuid (which you shouldn't have done) or if UML changes uid on
+	  startup (which will be a good thing, when enabled) ...
+
 config X86_MCE
 	bool "Machine check support" if EMBEDDED
 	default y
Index: i686-loki/arch/x86_64/ia32/ptrace32.c
===================================================================
--- i686-loki.orig/arch/x86_64/ia32/ptrace32.c	2007-07-12 14:19:46.000000000 +0100
+++ i686-loki/arch/x86_64/ia32/ptrace32.c	2007-07-12 13:59:19.000000000 +0100
@@ -16,6 +16,8 @@
 #include <linux/unistd.h>
 #include <linux/mm.h>
 #include <linux/ptrace.h>
+#include <linux/types.h>
+#include <linux/proc_mm.h>
 #include <asm/ptrace.h>
 #include <asm/compat.h>
 #include <asm/uaccess.h>
@@ -26,6 +28,7 @@
 #include <asm/i387.h>
 #include <asm/fpu32.h>
 #include <asm/ia32.h>
+#include <asm/desc.h>
 
 /*
  * Determines which flags the user has access to [1 = access, 0 = no access].
@@ -265,6 +268,12 @@
 	case PTRACE_SETFPXREGS:
 	case PTRACE_GETFPXREGS:
 	case PTRACE_GETEVENTMSG:
+#ifdef CONFIG_PROC_MM
+	case PTRACE_EX_FAULTINFO:
+	case PTRACE_FAULTINFO:
+	case PTRACE_LDT:
+	case PTRACE_SWITCH_MM:
+#endif
 		break;
 
 	case PTRACE_SETSIGINFO:
@@ -387,6 +396,65 @@
 		ret = 0; 
 		break;
 	}
+#ifdef CONFIG_PROC_MM
+	case PTRACE_EX_FAULTINFO: {
+		struct ptrace_ex_faultinfo32 fault;
+
+		fault = ((struct ptrace_ex_faultinfo32)
+			{ .is_write	= (compat_int_t) child->thread.error_code,
+			  .addr		= (compat_uptr_t) child->thread.cr2,
+			  .trap_no	= (compat_int_t) child->thread.trap_no });
+		ret = copy_to_user((unsigned long *) datap, &fault,
+				   sizeof(fault));
+		break;
+	}
+
+	case PTRACE_FAULTINFO: {
+		struct ptrace_faultinfo32 fault;
+
+		fault = ((struct ptrace_faultinfo32)
+			{ .is_write	= (compat_int_t) child->thread.error_code,
+			  .addr		= (compat_uptr_t) child->thread.cr2 });
+		ret = copy_to_user((unsigned long *) datap, &fault,
+				   sizeof(fault));
+		break;
+	}
+
+	case PTRACE_LDT: {
+		struct ptrace_ldt32 ldt;
+
+		if(copy_from_user(&ldt, (unsigned long *) datap,
+				  sizeof(ldt))){
+			ret = -EIO;
+			break;
+		}
+		ret = __modify_ldt(child->mm, ldt.func, compat_ptr(ldt.ptr), ldt.bytecount);
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
+
+		lock_fix_dumpable_setting(child, new);
+
+		child->mm = new;
+		child->active_mm = new;
+
+		task_unlock(child);
+
+		mmput(old);
+		ret = 0;
+		break;
+	}
+#endif
 
 	case PTRACE_GETEVENTMSG:
 		ret = put_user(child->ptrace_message,(unsigned int __user *)compat_ptr(data));
Index: i686-loki/arch/x86_64/ia32/sys_ia32.c
===================================================================
--- i686-loki.orig/arch/x86_64/ia32/sys_ia32.c	2007-07-12 14:19:46.000000000 +0100
+++ i686-loki/arch/x86_64/ia32/sys_ia32.c	2007-07-12 13:59:19.000000000 +0100
@@ -693,11 +693,10 @@
 	return ret;
 }
 
-asmlinkage long sys32_mmap2(unsigned long addr, unsigned long len,
-	unsigned long prot, unsigned long flags,
+long do32_mmap2(struct mm_struct *mm, unsigned long addr,
+	unsigned long len, unsigned long prot, unsigned long flags,
 	unsigned long fd, unsigned long pgoff)
 {
-	struct mm_struct *mm = current->mm;
 	unsigned long error;
 	struct file * file = NULL;
 
@@ -709,7 +708,7 @@
 	}
 
 	down_write(&mm->mmap_sem);
-	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
+	error = __do_mmap_pgoff(mm, file, addr, len, prot, flags, pgoff);
 	up_write(&mm->mmap_sem);
 
 	if (file)
@@ -717,6 +716,15 @@
 	return error;
 }
 
+/* XXX: this wrapper can be probably removed, we can simply use the 64-bit
+ * version.*/
+asmlinkage long sys32_mmap2(unsigned long addr, unsigned long len,
+	unsigned long prot, unsigned long flags,
+	unsigned long fd, unsigned long pgoff)
+{
+	return do32_mmap2(current->mm, addr, len, prot, flags, fd, pgoff);
+}
+
 asmlinkage long sys32_olduname(struct oldold_utsname __user * name)
 {
 	int err;
Index: i686-loki/arch/x86_64/kernel/ldt.c
===================================================================
--- i686-loki.orig/arch/x86_64/kernel/ldt.c	2007-07-12 14:19:46.000000000 +0100
+++ i686-loki/arch/x86_64/kernel/ldt.c	2007-07-12 13:59:19.000000000 +0100
@@ -21,6 +21,7 @@
 #include <asm/ldt.h>
 #include <asm/desc.h>
 #include <asm/proto.h>
+#include <asm/mmu_context.h>
 
 #ifdef CONFIG_SMP /* avoids "defined but not used" warnig */
 static void flush_ldt(void *null)
@@ -30,11 +31,12 @@
 }
 #endif
 
-static int alloc_ldt(mm_context_t *pc, unsigned mincount, int reload)
+static int alloc_ldt(struct mm_struct *mm, unsigned mincount, int reload)
 {
 	void *oldldt;
 	void *newldt;
 	unsigned oldsize;
+	mm_context_t * pc = &mm->context;
 
 	if (mincount <= (unsigned)pc->size)
 		return 0;
@@ -63,12 +65,14 @@
 
 		preempt_disable();
 		mask = cpumask_of_cpu(smp_processor_id());
-		load_LDT(pc);
-		if (!cpus_equal(current->mm->cpu_vm_mask, mask))
+		if (&current->active_mm->context == pc)
+			load_LDT(pc);
+		if (!cpus_equal(mm->cpu_vm_mask, mask))
 			smp_call_function(flush_ldt, NULL, 1, 1);
 		preempt_enable();
 #else
-		load_LDT(pc);
+		if (&current->active_mm->context == pc)
+			load_LDT(pc);
 #endif
 	}
 	if (oldsize) {
@@ -80,12 +84,12 @@
 	return 0;
 }
 
-static inline int copy_ldt(mm_context_t *new, mm_context_t *old)
+static inline int copy_ldt(struct mm_struct *new, struct mm_struct *old)
 {
-	int err = alloc_ldt(new, old->size, 0);
+	int err = alloc_ldt(new, old->context.size, 0);
 	if (err < 0)
 		return err;
-	memcpy(new->ldt, old->ldt, old->size*LDT_ENTRY_SIZE);
+	memcpy(new->context.ldt, old->context.ldt, old->context.size*LDT_ENTRY_SIZE);
 	return 0;
 }
 
@@ -93,22 +97,24 @@
  * we do not have to muck with descriptors here, that is
  * done in switch_mm() as needed.
  */
-int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+int copy_context(struct mm_struct *mm, struct mm_struct *old_mm)
 {
-	struct mm_struct * old_mm;
 	int retval = 0;
 
-	init_MUTEX(&mm->context.sem);
-	mm->context.size = 0;
-	old_mm = current->mm;
 	if (old_mm && old_mm->context.size > 0) {
 		down(&old_mm->context.sem);
-		retval = copy_ldt(&mm->context, &old_mm->context);
+		retval = copy_ldt(mm, old_mm);
 		up(&old_mm->context.sem);
 	}
 	return retval;
 }
 
+int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+{
+	init_new_empty_context(mm);
+	return copy_context(mm, current->mm);
+}
+
 /*
  * 
  * Don't touch the LDT register - we're already in the next thread.
@@ -124,11 +130,10 @@
 	}
 }
 
-static int read_ldt(void __user * ptr, unsigned long bytecount)
+static int read_ldt(struct mm_struct * mm, void __user * ptr, unsigned long bytecount)
 {
 	int err;
 	unsigned long size;
-	struct mm_struct * mm = current->mm;
 
 	if (!mm->context.size)
 		return 0;
@@ -169,10 +174,8 @@
 	return bytecount; 
 }
 
-static int write_ldt(void __user * ptr, unsigned long bytecount, int oldmode)
+static int write_ldt(struct mm_struct * mm, void __user * ptr, unsigned long bytecount, int oldmode)
 {
-	struct task_struct *me = current;
-	struct mm_struct * mm = me->mm;
 	__u32 entry_1, entry_2, *lp;
 	int error;
 	struct user_desc ldt_info;
@@ -197,7 +200,7 @@
 
 	down(&mm->context.sem);
 	if (ldt_info.entry_number >= (unsigned)mm->context.size) {
-		error = alloc_ldt(&current->mm->context, ldt_info.entry_number+1, 1);
+		error = alloc_ldt(mm, ldt_info.entry_number+1, 1);
 		if (error < 0)
 			goto out_unlock;
 	}
@@ -230,23 +233,29 @@
 	return error;
 }
 
-asmlinkage int sys_modify_ldt(int func, void __user *ptr, unsigned long bytecount)
+int __modify_ldt(struct mm_struct * mm, int func, void __user *ptr,
+		unsigned long bytecount)
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
+	return __modify_ldt(current->mm, func, ptr, bytecount);
+}
Index: i686-loki/arch/x86_64/kernel/ptrace.c
===================================================================
--- i686-loki.orig/arch/x86_64/kernel/ptrace.c	2007-07-12 14:19:46.000000000 +0100
+++ i686-loki/arch/x86_64/kernel/ptrace.c	2007-07-12 13:59:19.000000000 +0100
@@ -18,6 +18,7 @@
 #include <linux/audit.h>
 #include <linux/seccomp.h>
 #include <linux/signal.h>
+#include <linux/proc_mm.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -567,6 +568,75 @@
 		break;
 	}
 
+#ifdef CONFIG_PROC_MM
+	case PTRACE_EX_FAULTINFO: {
+		struct ptrace_ex_faultinfo fault;
+
+		/* I checked in thread_struct comments that error_code and cr2
+		 * are still part of the "fault info" section, so I guess that
+		 * things are unchanged for now. Still to check manuals. BB*/
+		fault = ((struct ptrace_ex_faultinfo)
+			{ .is_write	= child->thread.error_code,
+			  .addr		= child->thread.cr2,
+			  .trap_no	= child->thread.trap_no });
+		ret = copy_to_user((unsigned long *) data, &fault,
+				   sizeof(fault));
+		break;
+	}
+
+	/*Don't extend this broken interface to x86-64*/
+#if 0
+	case PTRACE_FAULTINFO: {
+		struct ptrace_faultinfo fault;
+
+		/* I checked in thread_struct comments that error_code and cr2
+		 * are still part of the "fault info" section, so I guess that
+		 * things are unchanged for now. Still to check manuals. BB*/
+		fault = ((struct ptrace_faultinfo)
+			{ .is_write	= child->thread.error_code,
+			  .addr		= child->thread.cr2 });
+		ret = copy_to_user((unsigned long *) data, &fault,
+				   sizeof(fault));
+		break;
+	}
+#endif
+
+	case PTRACE_LDT: {
+		struct ptrace_ldt ldt;
+
+		if(copy_from_user(&ldt, (unsigned long *) data,
+				  sizeof(ldt))){
+			ret = -EIO;
+			break;
+		}
+		ret = __modify_ldt(child->mm, ldt.func, ldt.ptr, ldt.bytecount);
+		break;
+	}
+
+	case PTRACE_SWITCH_MM: {
+		struct mm_struct *old = child->mm;
+		struct mm_struct *new = proc_mm_get_mm64(data);
+
+		if(IS_ERR(new)){
+			ret = PTR_ERR(new);
+			break;
+		}
+
+		atomic_inc(&new->mm_users);
+
+		lock_fix_dumpable_setting(child, new);
+
+		child->mm = new;
+		child->active_mm = new;
+
+		task_unlock(child);
+
+		mmput(old);
+		ret = 0;
+		break;
+	}
+#endif
+
 	default:
 		ret = ptrace_request(child, request, addr, data);
 		break;
Index: i686-loki/arch/x86_64/kernel/sys_x86_64.c
===================================================================
--- i686-loki.orig/arch/x86_64/kernel/sys_x86_64.c	2007-07-12 14:19:46.000000000 +0100
+++ i686-loki/arch/x86_64/kernel/sys_x86_64.c	2007-07-12 13:59:19.000000000 +0100
@@ -18,6 +18,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/ia32.h>
+#include <asm/proc_mm.h>
 
 /*
  * sys_pipe() is the normal C calling standard for creating
@@ -36,7 +37,7 @@
 	return error;
 }
 
-asmlinkage long sys_mmap(unsigned long addr, unsigned long len, unsigned long prot, unsigned long flags,
+long do64_mmap(struct mm_struct *mm, unsigned long addr, unsigned long len, unsigned long prot, unsigned long flags,
 	unsigned long fd, unsigned long off)
 {
 	long error;
@@ -54,9 +55,9 @@
 		if (!file)
 			goto out;
 	}
-	down_write(&current->mm->mmap_sem);
-	error = do_mmap_pgoff(file, addr, len, prot, flags, off >> PAGE_SHIFT);
-	up_write(&current->mm->mmap_sem);
+	down_write(&mm->mmap_sem);
+	error = __do_mmap_pgoff(mm, file, addr, len, prot, flags, off >> PAGE_SHIFT);
+	up_write(&mm->mmap_sem);
 
 	if (file)
 		fput(file);
@@ -64,6 +65,12 @@
 	return error;
 }
 
+asmlinkage long sys_mmap(unsigned long addr, unsigned long len, unsigned long prot, unsigned long flags,
+	unsigned long fd, unsigned long off)
+{
+	return do64_mmap(current->mm, addr, len, prot, flags, fd, off);
+}
+
 static void find_start_end(unsigned long flags, unsigned long *begin,
 			   unsigned long *end)
 {
Index: i686-loki/arch/x86_64/mm/Makefile
===================================================================
--- i686-loki.orig/arch/x86_64/mm/Makefile	2007-07-12 14:19:46.000000000 +0100
+++ i686-loki/arch/x86_64/mm/Makefile	2007-07-12 13:59:19.000000000 +0100
@@ -7,5 +7,6 @@
 obj-$(CONFIG_NUMA) += numa.o
 obj-$(CONFIG_K8_NUMA) += k8topology.o
 obj-$(CONFIG_ACPI_NUMA) += srat.o
+obj-$(CONFIG_PROC_MM) += proc_mm.o
 
 hugetlbpage-y = ../../i386/mm/hugetlbpage.o
Index: i686-loki/arch/x86_64/mm/proc_mm.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ i686-loki/arch/x86_64/mm/proc_mm.c	2007-07-12 13:59:19.000000000 +0100
@@ -0,0 +1,85 @@
+#include <linux/proc_mm.h>
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/proc_fs.h>
+#include <linux/file.h>
+#include <linux/mman.h>
+#include <asm/uaccess.h>
+#include <asm/mmu_context.h>
+
+ssize_t write_proc_mm_emul(struct file *file, const char *buffer,
+			     size_t count, loff_t *ppos)
+{
+	struct mm_struct *mm = file->private_data;
+	struct proc_mm_op32 req;
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
+		struct mm_mmap32 *map = &req.u.mmap;
+
+		/* Nobody ever noticed it, but do_mmap_pgoff() calls
+		 * get_unmapped_area() which checks current->mm, if
+		 * MAP_FIXED is not set, so mmap() could replace
+		 * an old mapping.
+		 */
+		if (! (map->flags & MAP_FIXED))
+			return(-EINVAL);
+
+		ret = __do_mmap(mm, map->addr, map->len, map->prot,
+			       map->flags, map->fd, map->offset);
+		if((ret & ~PAGE_MASK) == 0)
+			ret = count;
+
+		break;
+	}
+	case MM_MUNMAP: {
+		struct mm_munmap32 *unmap = &req.u.munmap;
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
+		struct mm_mprotect32 *protect = &req.u.mprotect;
+
+		ret = do_mprotect(mm, protect->addr, protect->len,
+				  protect->prot);
+		if(ret == 0)
+			ret = count;
+		break;
+	}
+
+	case MM_COPY_SEGMENTS: {
+		struct mm_struct *from = proc_mm_get_mm_emul(req.u.copy_segments);
+
+		if(IS_ERR(from)){
+			ret = PTR_ERR(from);
+			break;
+		}
+
+		ret = copy_context(mm, from);
+		if(ret == 0)
+			ret = count;
+		break;
+	}
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
Index: i686-loki/include/asm-i386/desc.h
===================================================================
--- i686-loki.orig/include/asm-i386/desc.h	2007-07-12 14:19:46.000000000 +0100
+++ i686-loki/include/asm-i386/desc.h	2007-07-12 13:59:19.000000000 +0100
@@ -216,6 +216,9 @@
 	return base;
 }
 
+extern int __modify_ldt(struct mm_struct * mm, int func, void __user *ptr,
+		      unsigned long bytecount);
+
 #else /* __ASSEMBLY__ */
 
 /*
Index: i686-loki/include/asm-i386/mmu_context.h
===================================================================
--- i686-loki.orig/include/asm-i386/mmu_context.h	2007-07-12 14:19:46.000000000 +0100
+++ i686-loki/include/asm-i386/mmu_context.h	2007-07-12 14:01:49.000000000 +0100
@@ -8,6 +8,7 @@
 #include <asm/paravirt.h>
 #ifndef CONFIG_PARAVIRT
 #include <asm-generic/mm_hooks.h>
+#include <asm/semaphore.h>
 
 static inline void paravirt_activate_mm(struct mm_struct *prev,
 					struct mm_struct *next)
@@ -17,11 +18,22 @@
 
 
 /*
- * Used for LDT copy/destruction.
+ * Used for LDT initialization/destruction. You cannot copy an LDT with
+ * init_new_context, since it thinks you are passing it a new LDT and won't
+ * deallocate its old content.
  */
 int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
 void destroy_context(struct mm_struct *mm);
 
+/* LDT initialization for a clean environment - needed for SKAS. */
+static inline void init_new_empty_context(struct mm_struct *mm)
+{
+	init_MUTEX(&mm->context.sem);
+	mm->context.size = 0;
+}
+
+/* LDT copy for SKAS - for the above problem.*/
+int copy_context(struct mm_struct *mm, struct mm_struct *old_mm);
 
 static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
@@ -38,6 +50,10 @@
 {
 	int cpu = smp_processor_id();
 
+#ifdef CONFIG_SMP
+	prev = per_cpu(cpu_tlbstate, cpu).active_mm;
+#endif
+
 	if (likely(prev != next)) {
 		/* stop flush ipis for the previous mm */
 		cpu_clear(cpu, prev->cpu_vm_mask);
@@ -59,7 +75,6 @@
 #ifdef CONFIG_SMP
 	else {
 		per_cpu(cpu_tlbstate, cpu).state = TLBSTATE_OK;
-		BUG_ON(per_cpu(cpu_tlbstate, cpu).active_mm != next);
 
 		if (!cpu_test_and_set(cpu, next->cpu_vm_mask)) {
 			/* We were in lazy tlb mode and leave_mm disabled 
Index: i686-loki/include/asm-i386/proc_mm.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ i686-loki/include/asm-i386/proc_mm.h	2007-07-12 13:59:19.000000000 +0100
@@ -0,0 +1,18 @@
+#ifndef __ASM_PROC_MM
+#define __ASM_PROC_MM
+
+#include <asm/page.h>
+
+extern long do_mmap2(struct mm_struct *mm, unsigned long addr,
+		unsigned long len, unsigned long prot, unsigned long flags,
+		unsigned long fd, unsigned long pgoff);
+
+static inline long __do_mmap(struct mm_struct *mm, unsigned long addr,
+		     unsigned long len, unsigned long prot,
+		     unsigned long flags, unsigned long fd,
+		     unsigned long off)
+{
+	return do_mmap2(mm, addr, len, prot, flags, fd, off >> PAGE_SHIFT);
+}
+
+#endif /* __ASM_PROC_MM */
Index: i686-loki/include/asm-i386/ptrace.h
===================================================================
--- i686-loki.orig/include/asm-i386/ptrace.h	2007-07-12 14:19:46.000000000 +0100
+++ i686-loki/include/asm-i386/ptrace.h	2007-07-12 13:59:19.000000000 +0100
@@ -60,4 +60,33 @@
 extern unsigned long profile_pc(struct pt_regs *regs);
 #endif /* __KERNEL__ */
 
+/*For SKAS3 support.*/
+#ifndef _LINUX_PTRACE_STRUCT_DEF
+#define _LINUX_PTRACE_STRUCT_DEF
+
+#define PTRACE_FAULTINFO	  52
+/* 53 was used for PTRACE_SIGPENDING, don't reuse it. */
+#define PTRACE_LDT		  54
+#define PTRACE_SWITCH_MM 	  55
+#define PTRACE_EX_FAULTINFO	  56
+
+struct ptrace_faultinfo {
+	int is_write;
+	unsigned long addr;
+};
+
+struct ptrace_ex_faultinfo {
+	int is_write;
+	unsigned long addr;
+	int trap_no;
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
Index: i686-loki/include/asm-x86_64/desc.h
===================================================================
--- i686-loki.orig/include/asm-x86_64/desc.h	2007-07-12 14:19:46.000000000 +0100
+++ i686-loki/include/asm-x86_64/desc.h	2007-07-12 13:59:19.000000000 +0100
@@ -169,6 +169,9 @@
 
 extern struct desc_ptr idt_descr;
 
+extern int __modify_ldt(struct mm_struct * mm, int func, void __user *ptr,
+		unsigned long bytecount);
+
 #endif /* !__ASSEMBLY__ */
 
 #endif
Index: i686-loki/include/asm-x86_64/mmu_context.h
===================================================================
--- i686-loki.orig/include/asm-x86_64/mmu_context.h	2007-07-12 14:19:46.000000000 +0100
+++ i686-loki/include/asm-x86_64/mmu_context.h	2007-07-12 14:02:53.000000000 +0100
@@ -8,13 +8,28 @@
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
 #include <asm-generic/mm_hooks.h>
+#include <asm/semaphore.h>
 
 /*
  * possibly do the LDT unload here?
+ * Used for LDT initialization/destruction. You cannot copy an LDT with
+ * init_new_context, since it thinks you are passing it a new LDT and won't
+ * deallocate its old content.
  */
+
 int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
 void destroy_context(struct mm_struct *mm);
 
+/* LDT initialization for a clean environment - needed for SKAS.*/
+static inline void init_new_empty_context(struct mm_struct *mm)
+{
+	init_MUTEX(&mm->context.sem);
+	mm->context.size = 0;
+}
+
+/* LDT copy for SKAS - for the above problem.*/
+int copy_context(struct mm_struct *mm, struct mm_struct *old_mm);
+
 static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
 #ifdef CONFIG_SMP
@@ -32,6 +47,9 @@
 			     struct task_struct *tsk)
 {
 	unsigned cpu = smp_processor_id();
+#ifdef CONFIG_SMP
+	prev = read_pda(active_mm);
+#endif
 	if (likely(prev != next)) {
 		/* stop flush ipis for the previous mm */
 		cpu_clear(cpu, prev->cpu_vm_mask);
@@ -48,8 +66,6 @@
 #ifdef CONFIG_SMP
 	else {
 		write_pda(mmu_state, TLBSTATE_OK);
-		if (read_pda(active_mm) != next)
-			out_of_line_bug();
 		if (!cpu_test_and_set(cpu, next->cpu_vm_mask)) {
 			/* We were in lazy tlb mode and leave_mm disabled 
 			 * tlb flush IPI delivery. We must reload CR3
Index: i686-loki/include/asm-x86_64/proc_mm.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ i686-loki/include/asm-x86_64/proc_mm.h	2007-07-12 13:59:19.000000000 +0100
@@ -0,0 +1,58 @@
+#ifndef __ASM_PROC_MM
+#define __ASM_PROC_MM
+#include <linux/types.h>
+
+#include <asm/compat.h>
+
+struct mm_mmap32 {
+	compat_ulong_t addr;
+	compat_ulong_t len;
+	compat_ulong_t prot;
+	compat_ulong_t flags;
+	compat_ulong_t fd;
+	compat_ulong_t offset;
+};
+
+struct mm_munmap32 {
+	compat_ulong_t addr;
+	compat_ulong_t len;
+};
+
+struct mm_mprotect32 {
+	compat_ulong_t addr;
+	compat_ulong_t len;
+        compat_uint_t prot;
+};
+
+struct proc_mm_op32 {
+	compat_int_t op;
+	union {
+		struct mm_mmap32 mmap;
+		struct mm_munmap32 munmap;
+	        struct mm_mprotect32 mprotect;
+		compat_int_t copy_segments;
+	} u;
+};
+
+extern ssize_t write_proc_mm_emul(struct file *file, const char *buffer,
+			     size_t count, loff_t *ppos);
+
+extern struct mm_struct *proc_mm_get_mm64(int fd);
+
+extern long do64_mmap(struct mm_struct *mm, unsigned long addr, unsigned long len, unsigned long prot, unsigned long flags,
+	unsigned long fd, unsigned long off);
+
+static inline long __do_mmap(struct mm_struct *mm, unsigned long addr,
+		     unsigned long len, unsigned long prot,
+		     unsigned long flags, unsigned long fd,
+		     unsigned long off)
+{
+	/* The latter one is stricter, since will actually check that off is page
+	 * aligned. The first one skipped the check. */
+
+	/* return do32_mmap2(mm, addr, len, prot, flags, fd, off >>
+	 * PAGE_SHIFT);*/
+	return do64_mmap(mm, addr, len, prot, flags, fd, off);
+}
+
+#endif /* __ASM_PROC_MM */
Index: i686-loki/include/asm-x86_64/ptrace-abi.h
===================================================================
--- i686-loki.orig/include/asm-x86_64/ptrace-abi.h	2007-07-12 14:19:46.000000000 +0100
+++ i686-loki/include/asm-x86_64/ptrace-abi.h	2007-07-12 13:59:19.000000000 +0100
@@ -42,6 +42,12 @@
 #define PTRACE_GETFPXREGS         18
 #define PTRACE_SETFPXREGS         19
 
+#define PTRACE_FAULTINFO 52
+/* 53 was used for PTRACE_SIGPENDING, don't reuse it. */
+#define PTRACE_LDT 54
+#define PTRACE_SWITCH_MM 55
+#define PTRACE_EX_FAULTINFO	  56
+
 /* only useful for access 32bit programs */
 #define PTRACE_GET_THREAD_AREA    25
 #define PTRACE_SET_THREAD_AREA    26
Index: i686-loki/include/asm-x86_64/ptrace.h
===================================================================
--- i686-loki.orig/include/asm-x86_64/ptrace.h	2007-07-12 14:19:46.000000000 +0100
+++ i686-loki/include/asm-x86_64/ptrace.h	2007-07-12 13:59:19.000000000 +0100
@@ -72,6 +72,59 @@
         EF_ID   = 0x00200000,   /* id */
 };
 
+/* Stolen from
+#include <linux/compat.h>; we can't include it because
+there is a nasty ciclic include chain.
+*/
+
+#include <asm/types.h>
+
+#define		compat_int_t	s32
+#define		compat_long_t	s32
+#define		compat_uint_t	u32
+#define		compat_ulong_t	u32
+#define		compat_uptr_t	u32
+
+struct ptrace_faultinfo32 {
+	compat_int_t is_write;
+	compat_ulong_t addr;
+};
+
+struct ptrace_ex_faultinfo32 {
+	compat_int_t is_write;
+	compat_ulong_t addr;
+	compat_int_t trap_no;
+};
+
+struct ptrace_ldt32 {
+	compat_int_t func;
+	compat_uptr_t ptr; /*Actually a void pointer on i386, but must be converted.*/
+	compat_ulong_t bytecount;
+};
+
+struct ptrace_faultinfo {
+	int is_write;
+	unsigned long addr;
+};
+
+struct ptrace_ex_faultinfo {
+	int is_write;
+	unsigned long addr;
+	int trap_no;
+};
+
+struct ptrace_ldt {
+	int func;
+  	void *ptr;
+	unsigned long bytecount;
+};
+
+#undef	compat_int_t
+#undef	compat_long_t
+#undef	compat_uint_t
+#undef	compat_ulong_t
+#undef	compat_uptr_t
+
 #endif
 
 #endif
Index: i686-loki/include/linux/mm.h
===================================================================
--- i686-loki.orig/include/linux/mm.h	2007-07-12 14:19:46.000000000 +0100
+++ i686-loki/include/linux/mm.h	2007-07-12 14:22:06.000000000 +0100
@@ -16,6 +16,8 @@
 #include <linux/debug_locks.h>
 #include <linux/backing-dev.h>
 #include <linux/mm_types.h>
+#include <linux/sched.h>
+#include <asm/current.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -1069,9 +1071,15 @@
 
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
@@ -1088,6 +1096,9 @@
 
 extern int do_munmap(struct mm_struct *, unsigned long, size_t);
 
+extern long do_mprotect(struct mm_struct *mm, unsigned long start,
+			size_t len, unsigned long prot);
+
 extern unsigned long do_brk(unsigned long, unsigned long);
 
 /* filemap.c */
Index: i686-loki/include/linux/proc_mm.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ i686-loki/include/linux/proc_mm.h	2007-07-12 13:59:19.000000000 +0100
@@ -0,0 +1,113 @@
+/*
+ * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __PROC_MM_H
+#define __PROC_MM_H
+
+#include <linux/sched.h>
+#include <linux/compiler.h>
+
+/* The differences between this one and do_mmap are that:
+ * - we must perform controls for userspace-supplied params (which are
+ *   arch-specific currently). And also fget(fd) if needed and so on...
+ * - we must accept the struct mm_struct on which to act as first param, and the
+ *   offset in byte rather than page units as last param.
+ */
+static inline long __do_mmap(struct mm_struct *mm, unsigned long addr,
+		     unsigned long len, unsigned long prot,
+		     unsigned long flags, unsigned long fd,
+		     unsigned long off);
+
+/* This header can be used only on archs defining CONFIG_PROC_MM in their
+ * configs, so asm/proc_mm.h can still exist only for the needed archs.
+ * Including it only in the x86-64 case does not make sense.*/
+#include <asm/proc_mm.h>
+
+/*XXX: this is defined on x86_64, but not on every 64-bit arch (not on sh64).*/
+#ifdef CONFIG_64BIT
+
+#define write_proc_mm write_proc_mm_emul
+#define write_proc_mm64 write_proc_mm_native
+
+/* It would make more sense to do this mapping the reverse direction, to map the
+ * called name to the defined one and not the reverse. Like the 2nd example
+ */
+/*#define proc_mm_get_mm proc_mm_get_mm_emul
+#define proc_mm_get_mm64 proc_mm_get_mm_native*/
+
+#define proc_mm_get_mm_emul proc_mm_get_mm
+#define proc_mm_get_mm_native proc_mm_get_mm64
+
+#else
+
+#define write_proc_mm write_proc_mm_native
+#undef write_proc_mm64
+
+/*#define proc_mm_get_mm proc_mm_get_mm_native
+#undef proc_mm_get_mm64*/
+
+#define proc_mm_get_mm_native proc_mm_get_mm
+#undef proc_mm_get_mm_emul
+
+#endif
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
+/* Cope with older kernels */
+#ifndef __acquires
+#define __acquires(x)
+#endif
+
+#ifdef CONFIG_PROC_MM_DUMPABLE
+/*
+ * Since we take task_lock of child and it's needed also by the caller, we
+ * return with it locked.
+ */
+extern void lock_fix_dumpable_setting(struct task_struct * child,
+		struct mm_struct* new) __acquires(child->alloc_lock);
+#else
+static inline void lock_fix_dumpable_setting(struct task_struct * child,
+		struct mm_struct* new) __acquires(child->alloc_lock)
+{
+	task_lock(child);
+}
+#endif
+
+#endif
Index: i686-loki/localversion-skas
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ i686-loki/localversion-skas	2007-07-12 13:59:19.000000000 +0100
@@ -0,0 +1 @@
+-skas3-v9-pre9
Index: i686-loki/mm/Makefile
===================================================================
--- i686-loki.orig/mm/Makefile	2007-07-12 14:19:46.000000000 +0100
+++ i686-loki/mm/Makefile	2007-07-12 14:03:26.000000000 +0100
@@ -31,4 +31,8 @@
 obj-$(CONFIG_MIGRATION) += migrate.o
 obj-$(CONFIG_SMP) += allocpercpu.o
 obj-$(CONFIG_QUICKLIST) += quicklist.o
+obj-$(CONFIG_PROC_MM)	+= proc_mm.o
 
+ifeq ($(CONFIG_PROC_MM),y)
+obj-m			+= proc_mm-mod.o
+endif
Index: i686-loki/mm/mmap.c
===================================================================
--- i686-loki.orig/mm/mmap.c	2007-07-12 14:19:46.000000000 +0100
+++ i686-loki/mm/mmap.c	2007-07-12 13:59:19.000000000 +0100
@@ -889,11 +889,11 @@
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
@@ -1175,7 +1175,7 @@
 	return error;
 }
 
-EXPORT_SYMBOL(do_mmap_pgoff);
+EXPORT_SYMBOL(__do_mmap_pgoff);
 
 /* Get an address range which is currently unmapped.
  * For shmat() with addr=0.
Index: i686-loki/mm/mprotect.c
===================================================================
--- i686-loki.orig/mm/mprotect.c	2007-07-12 14:19:46.000000000 +0100
+++ i686-loki/mm/mprotect.c	2007-07-12 13:59:19.000000000 +0100
@@ -214,8 +214,9 @@
 	return error;
 }
 
-asmlinkage long
-sys_mprotect(unsigned long start, size_t len, unsigned long prot)
+long
+do_mprotect(struct mm_struct *mm, unsigned long start, size_t len,
+	     unsigned long prot)
 {
 	unsigned long vm_flags, nstart, end, tmp, reqprot;
 	struct vm_area_struct *vma, *prev;
@@ -245,9 +246,9 @@
 
 	vm_flags = calc_vm_prot_bits(prot);
 
-	down_write(&current->mm->mmap_sem);
+	down_write(&mm->mmap_sem);
 
-	vma = find_vma_prev(current->mm, start, &prev);
+	vma = find_vma_prev(mm, start, &prev);
 	error = -ENOMEM;
 	if (!vma)
 		goto out;
@@ -309,6 +310,15 @@
 		}
 	}
 out:
-	up_write(&current->mm->mmap_sem);
+	up_write(&mm->mmap_sem);
 	return error;
 }
+
+asmlinkage long sys_mprotect(unsigned long start, size_t len, unsigned long prot)
+{
+	long ret = do_mprotect(current->mm, start, len, prot);
+	/* A tail call would reorder parameters on the stack and they would then
+	 * be restored at the wrong places. */
+	prevent_tail_call(ret);
+	return ret;
+}
Index: i686-loki/mm/proc_mm-mod.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ i686-loki/mm/proc_mm-mod.c	2007-07-12 13:59:19.000000000 +0100
@@ -0,0 +1,50 @@
+#include <linux/kernel.h>
+#include <linux/proc_mm.h>
+#include <linux/ptrace.h>
+#include <linux/module.h>
+
+#ifdef CONFIG_64BIT
+#define PRINT_OFFSET(type, member) \
+	printk(KERN_DEBUG "struct " #type "32->" #member " \t: %ld\n", (long) offsetof(struct type ## 32, member))
+#else
+#define PRINT_OFFSET(type, member) \
+	printk(KERN_DEBUG "struct " #type "->" #member " \t: %ld\n", (long) offsetof(struct type, member))
+#endif
+
+static int debug_printoffsets(void)
+{
+	printk(KERN_DEBUG "Skas core structures layout BEGIN:\n");
+	PRINT_OFFSET(mm_mmap, addr);
+	PRINT_OFFSET(mm_mmap, len);
+	PRINT_OFFSET(mm_mmap, prot);
+	PRINT_OFFSET(mm_mmap, flags);
+	PRINT_OFFSET(mm_mmap, fd);
+	PRINT_OFFSET(mm_mmap, offset);
+
+	PRINT_OFFSET(mm_munmap, addr);
+	PRINT_OFFSET(mm_munmap, len);
+
+	PRINT_OFFSET(mm_mprotect, addr);
+	PRINT_OFFSET(mm_mprotect, len);
+	PRINT_OFFSET(mm_mprotect, prot);
+
+	PRINT_OFFSET(proc_mm_op, op);
+	PRINT_OFFSET(proc_mm_op, u);
+	PRINT_OFFSET(proc_mm_op, u.mmap);
+	PRINT_OFFSET(proc_mm_op, u.munmap);
+	PRINT_OFFSET(proc_mm_op, u.mprotect);
+	PRINT_OFFSET(proc_mm_op, u.copy_segments);
+
+	PRINT_OFFSET(ptrace_faultinfo, is_write);
+	PRINT_OFFSET(ptrace_faultinfo, addr);
+
+	PRINT_OFFSET(ptrace_ldt, func);
+	PRINT_OFFSET(ptrace_ldt, ptr);
+	PRINT_OFFSET(ptrace_ldt, bytecount);
+	printk(KERN_DEBUG "Skas core structures layout END.\n");
+
+	return 0;
+}
+#undef PRINT_OFFSET
+
+module_init(debug_printoffsets);
Index: i686-loki/mm/proc_mm.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ i686-loki/mm/proc_mm.c	2007-07-12 13:59:19.000000000 +0100
@@ -0,0 +1,299 @@
+/*
+ * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#include <linux/compiler.h>
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/proc_fs.h>
+#include <linux/proc_mm.h>
+#include <linux/file.h>
+#include <linux/mman.h>
+#include <asm/uaccess.h>
+#include <asm/mmu_context.h>
+
+#ifdef CONFIG_PROC_MM_DUMPABLE
+/* Checks if a task must be considered dumpable
+ *
+ * XXX: copied from fs/proc/base.c, removed task_lock, added rmb(): this must be
+ * called with task_lock(task) held. */
+static int task_dumpable(struct task_struct *task)
+{
+	int dumpable = 0;
+	struct mm_struct *mm;
+
+	mm = task->mm;
+	if (mm) {
+		rmb();
+		dumpable = mm->dumpable;
+	}
+	return dumpable;
+}
+
+/*
+ * This is to be used in PTRACE_SWITCH_MM handling. We are going to set
+ * child->mm to new, and we must first correctly set new->dumpable.
+ * Since we take task_lock of child and it's needed also by the caller, we
+ * return with it locked.
+ */
+void lock_fix_dumpable_setting(struct task_struct* child, struct mm_struct* new)
+	__acquires(child->alloc_lock)
+{
+	int dumpable = 1;
+
+	/* We must be safe.
+	 * If the child is ptraced from a non-dumpable process,
+	 * let's not be dumpable. If the child is non-dumpable itself,
+	 * copy this property across mm's.
+	 *
+	 * Don't try to be smart for the opposite case and turn
+	 * child->mm->dumpable to 1: I've not made sure it is safe.
+	 */
+
+	task_lock(current);
+	if (unlikely(!task_dumpable(current))) {
+		dumpable = 0;
+	}
+	task_unlock(current);
+
+	task_lock(child);
+	if (likely(dumpable) && unlikely(!task_dumpable(child))) {
+		dumpable = 0;
+	}
+
+	if (!dumpable) {
+		new->dumpable = 0;
+		wmb();
+	}
+}
+#endif
+
+/* Naming conventions are a mess, so I note them down.
+ *
+ * Things ending in _mm can be for everything. It's only for
+ * {open,release}_proc_mm.
+ *
+ * For the rest:
+ *
+ * _mm means /proc/mm, _mm64 means /proc/mm64. This is for the infrastructure
+ * only (for instance proc_mm_get_mm checks whether the file is /proc/mm or
+ * /proc/mm64; for instance the /proc handling).
+ *
+ * While for what is conversion dependant, we use the suffix _native and _emul.
+ * In some cases, there is a mapping between these ones (defined by
+ * <asm/proc_mm.h>).
+ */
+
+/*These two are common to everything.*/
+static int open_proc_mm(struct inode *inode, struct file *file)
+{
+	struct mm_struct *mm = mm_alloc();
+	int ret;
+
+	ret = -ENOMEM;
+	if(mm == NULL)
+		goto out_mem;
+
+	init_new_empty_context(mm);
+	arch_pick_mmap_layout(mm);
+#ifdef CONFIG_PROC_MM_DUMPABLE
+	mm->dumpable = current->mm->dumpable;
+	wmb();
+#endif
+
+	file->private_data = mm;
+
+	return 0;
+
+out_mem:
+	return ret;
+}
+
+static int release_proc_mm(struct inode *inode, struct file *file)
+{
+	struct mm_struct *mm = file->private_data;
+
+	mmput(mm);
+	return 0;
+}
+
+static struct file_operations proc_mm_fops;
+
+struct mm_struct *proc_mm_get_mm_native(int fd);
+
+static ssize_t write_proc_mm_native(struct file *file, const char *buffer,
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
+		/* Nobody ever noticed it, but do_mmap_pgoff() calls
+		 * get_unmapped_area() which checks current->mm, if
+		 * MAP_FIXED is not set, so mmap() could replace
+		 * an old mapping.
+		 */
+		if (! (map->flags & MAP_FIXED))
+			return(-EINVAL);
+
+		ret = __do_mmap(mm, map->addr, map->len, map->prot,
+			       map->flags, map->fd, map->offset);
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
+		struct mm_struct *from = proc_mm_get_mm_native(req.u.copy_segments);
+
+		if(IS_ERR(from)){
+			ret = PTR_ERR(from);
+			break;
+		}
+
+		ret = copy_context(mm, from);
+		if(ret == 0)
+			ret = count;
+		break;
+	}
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+/*These three are all for /proc/mm.*/
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
+out_fput:
+	fput(file);
+out:
+	return(ret);
+}
+
+static struct file_operations proc_mm_fops = {
+	.open		= open_proc_mm,
+	.release	= release_proc_mm,
+	.write		= write_proc_mm,
+};
+
+/*Macro-ify it to avoid the duplication.*/
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
+	return 0;
+}
+
+__initcall(make_proc_mm);
+
+/*XXX: change the option.*/
+#ifdef CONFIG_64BIT
+static struct file_operations proc_mm64_fops = {
+	.open		= open_proc_mm,
+	.release	= release_proc_mm,
+	.write		= write_proc_mm64,
+};
+
+static int make_proc_mm64(void)
+{
+	struct proc_dir_entry *ent;
+
+	ent = create_proc_entry("mm64", 0222, &proc_root);
+	if(ent == NULL){
+		printk("make_proc_mm : Failed to register /proc/mm64\n");
+		return(0);
+	}
+	ent->proc_fops = &proc_mm64_fops;
+
+	return 0;
+}
+
+__initcall(make_proc_mm64);
+
+struct mm_struct *proc_mm_get_mm64(int fd)
+{
+	struct mm_struct *ret = ERR_PTR(-EBADF);
+	struct file *file;
+
+	file = fget(fd);
+	if (!file)
+		goto out;
+
+	ret = ERR_PTR(-EINVAL);
+	/*This is the only change.*/
+	if(file->f_op != &proc_mm64_fops)
+		goto out_fput;
+
+	ret = file->private_data;
+out_fput:
+	fput(file);
+out:
+	return(ret);
+}
+#endif
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


-- 
`... in the sense that dragons logically follow evolution so they would
 be able to wield metal.' --- Kenneth Eng's colourless green ideas sleep
 furiously

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
