Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BEXj5-0003KS-25 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Apr 2004 11:06:07 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BEXj3-0000KE-T0 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Apr 2004 11:06:06 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Problems with the SKAS patch and 2.6
References: <407F7EFF.5060106@austin.rr.com>
	<Pine.LNX.4.58.0404161608350.9658@boston.corp.fedex.com>
In-Reply-To: <Pine.LNX.4.58.0404161608350.9658@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JfBgACpzG/AePjM"
Message-Id: <200404161928.41884.blaisorblade_spam@yahoo.it>
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
Date: Fri, 16 Apr 2004 19:28:41 +0200
To: user-mode-linux-devel@lists.sourceforge.net



--Boundary-00=_JfBgACpzG/AePjM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Alle 10:19, venerd=EC 16 aprile 2004, Jeff Chua ha scritto:
> It is possible to run SKAS on 2.6. I'm running 2.6.6-rc1-1um SKAS now.
>
> Try the attached patch (00-2.6.6-v0-host-SKAS2.patch.bz2) for 2.6.6-rc1.
> It's slightly modified from the original 00-2.6.2-v1-host-SKAS2.patch.bz2
> patch, which should apply up to 2.6.5.

It applies until 2.6.5, yes, but I posted some time ago a new SKAS patch on=
to=20
my home page because that one had a bug with SMP hosts, which is fixed in t=
he=20
new one (I have reports that it now works).

Also, that patch applies onto a kernel which has already been UML - patched=
,=20
while the later version applies onto a vanilla kernel.

There is a separate version which can be applied like the old one, i.e. ont=
o=20
the kernel + UML patch, in the main UML page.

I applied your slight change to this 2nd version and attached the result -=
=20
test at least if it applies correctly (this one goes onto the UML patch).

Bye and thanks for your update!
=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_JfBgACpzG/AePjM
Content-Type: text/x-diff; charset="iso-8859-1";
	name="host+Uml-skas3-2.6.6-rc1-v1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="host+Uml-skas3-2.6.6-rc1-v1.patch"

--- ./arch/i386/kernel/sys_i386.c.~1~	2003-12-20 17:54:25.000000000 +0100
+++ ./arch/i386/kernel/sys_i386.c	2004-02-29 16:23:11.000000000 +0100
@@ -40,7 +40,7 @@
 }
 
 /* common code for old and new mmaps */
-static inline long do_mmap2(
+long do_mmap2(struct mm_struct *mm,
 	unsigned long addr, unsigned long len,
 	unsigned long prot, unsigned long flags,
 	unsigned long fd, unsigned long pgoff)
@@ -55,9 +55,9 @@
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
@@ -69,7 +69,7 @@
 	unsigned long prot, unsigned long flags,
 	unsigned long fd, unsigned long pgoff)
 {
-	return do_mmap2(addr, len, prot, flags, fd, pgoff);
+	return do_mmap2(current->mm, addr, len, prot, flags, fd, pgoff);
 }
 
 /*
@@ -100,7 +100,7 @@
 	if (a.offset & ~PAGE_MASK)
 		goto out;
 
-	err = do_mmap2(a.addr, a.len, a.prot, a.flags, a.fd, a.offset >> PAGE_SHIFT);
+	err = do_mmap2(current->mm, a.addr, a.len, a.prot, a.flags, a.fd, a.offset >> PAGE_SHIFT);
 out:
 	return err;
 }
--- ./arch/i386/kernel/ptrace.c.~1~	2003-12-20 17:54:25.000000000 +0100
+++ ./arch/i386/kernel/ptrace.c	2004-02-29 16:23:11.000000000 +0100
@@ -14,3 +14,4 @@
 #include <linux/audit.h>
+#include <linux/proc_mm.h>
 
 #include <asm/uaccess.h>
@@ -507,6 +508,56 @@
 					     addr, (struct user_desc __user *) data);
 		break;
 
+#ifdef CONFIG_PROC_MM
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
--- ./arch/i386/kernel/ldt.c.~1~	2003-12-25 19:23:56.000000000 +0100
+++ ./arch/i386/kernel/ldt.c	2004-02-29 16:23:11.000000000 +0100
@@ -54,7 +54,7 @@
 	pc->size = mincount;
 	wmb();
 
-	if (reload) {
+	if (reload && (&current->active_mm->context == pc)) {
 #ifdef CONFIG_SMP
 		cpumask_t mask;
 		preempt_disable();
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
@@ -121,11 +124,11 @@
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
@@ -169,9 +172,8 @@
 	return err;
 }
 
-static int write_ldt(void __user * ptr, unsigned long bytecount, int oldmode)
+static int write_ldt(struct mm_struct * mm, void __user * ptr, unsigned long bytecount, int oldmode)
 {
-	struct mm_struct * mm = current->mm;
 	__u32 entry_1, entry_2, *lp;
 	int error;
 	struct user_desc ldt_info;
@@ -195,7 +197,7 @@
 
 	down(&mm->context.sem);
 	if (ldt_info.entry_number >= mm->context.size) {
-		error = alloc_ldt(&current->mm->context, ldt_info.entry_number+1, 1);
+		error = alloc_ldt(&mm->context, ldt_info.entry_number+1, 1);
 		if (error < 0)
 			goto out_unlock;
 	}
@@ -228,23 +230,29 @@
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
--- ./arch/i386/Kconfig.~1~	2004-02-20 16:34:03.000000000 +0100
+++ ./arch/i386/Kconfig	2004-02-29 16:23:11.000000000 +0100
@@ -698,6 +698,9 @@
 	depends on HIGHMEM64G
 	default y
 
+config PROC_MM
+	bool "/proc/mm support"
+
 # Common NUMA Features
 config NUMA
 	bool "Numa Memory Allocation Support"
--- ./arch/um/include/skas_ptrace.h.~1~	2004-02-20 18:43:26.000000000 +0100
+++ ./arch/um/include/skas_ptrace.h	2004-02-29 16:23:11.000000000 +0100
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
--- ./arch/um/kernel/ptrace.c.~1~	2004-02-29 16:22:01.000000000 +0100
+++ ./arch/um/kernel/ptrace.c	2004-02-29 16:22:33.000000000 +0100
@@ -24,11 +24,6 @@
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
--- ./arch/um/kernel/syscall_kern.c.~1~	2004-02-29 16:22:01.000000000 +0100
+++ ./arch/um/kernel/syscall_kern.c	2004-02-29 16:23:11.000000000 +0100
@@ -81,7 +81,7 @@
 	}
 
 	down_write(&mm->mmap_sem);
-	error = do_mmap_pgoff(mm, file, addr, len, prot, flags, pgoff);
+	error = __do_mmap_pgoff(mm, file, addr, len, prot, flags, pgoff);
 	up_write(&mm->mmap_sem);
 
 	if (file)
--- ./include/linux/mm.h.~1~	2004-02-29 16:22:01.000000000 +0100
+++ ./include/linux/mm.h	2004-02-29 16:23:11.000000000 +0100
@@ -540,10 +540,15 @@
 
 extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
 
-extern unsigned long do_mmap_pgoff(struct mm_struct *mm, struct file *file, 
+extern unsigned long __do_mmap_pgoff(struct mm_struct *mm, struct file *file, 
 				   unsigned long addr, unsigned long len,
 				   unsigned long prot, unsigned long flag,
 				   unsigned long pgoff);
+static inline unsigned long do_mmap_pgoff(struct file *file, unsigned long addr,
+	unsigned long len, unsigned long prot,
+	unsigned long flag, unsigned long pgoff) {
+	return __do_mmap_pgoff(current->mm, file, addr, len, prot, flag, pgoff);
+}
 
 static inline unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot,
@@ -553,8 +558,7 @@
 	if ((offset + PAGE_ALIGN(len)) < offset)
 		goto out;
 	if (!(offset & ~PAGE_MASK))
-		ret = do_mmap_pgoff(current->mm, file, addr, len, prot, flag, 
-				    offset >> PAGE_SHIFT);
+		ret = do_mmap_pgoff(file, addr, len, prot, flag, offset >> PAGE_SHIFT);
 out:
 	return ret;
 }
--- ./include/asm-i386/desc.h.~1~	2003-12-20 17:44:08.000000000 +0100
+++ ./include/asm-i386/desc.h	2004-02-29 16:23:11.000000000 +0100
@@ -123,6 +123,9 @@
 	put_cpu();
 }
 
+extern int modify_ldt(struct mm_struct * mm, int func, void __user *ptr,
+		      unsigned long bytecount);
+
 #endif /* !__ASSEMBLY__ */
 
 #endif
--- ./include/asm-i386/processor.h.~1~	2004-01-09 21:27:46.000000000 +0100
+++ ./include/asm-i386/processor.h	2004-02-29 16:23:11.000000000 +0100
@@ -630,4 +630,6 @@
 
 extern void select_idle_routine(const struct cpuinfo_x86 *c);
 
+extern int __init_new_context(struct mm_struct *mm, struct mm_struct *old_mm);
+
 #endif /* __ASM_I386_PROCESSOR_H */
--- ./include/asm-i386/ptrace.h.~1~	2003-12-20 17:21:33.000000000 +0100
+++ ./include/asm-i386/ptrace.h	2004-02-29 16:23:11.000000000 +0100
@@ -59,4 +59,26 @@
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
--- ./include/asm-i386/mmu_context.h.~1~	2003-12-25 19:24:24.000000000 +0100
+++ ./include/asm-i386/mmu_context.h	2004-02-29 16:23:11.000000000 +0100
@@ -29,6 +29,10 @@
 {
 	int cpu = smp_processor_id();
 
+#ifdef CONFIG_SMP
+	prev = cpu_tlbstate[cpu].active_mm;
+#endif
+
 	if (likely(prev != next)) {
 		/* stop flush ipis for the previous mm */
 		cpu_clear(cpu, prev->cpu_vm_mask);
@@ -50,7 +54,6 @@
 #ifdef CONFIG_SMP
 	else {
 		cpu_tlbstate[cpu].state = TLBSTATE_OK;
-		BUG_ON(cpu_tlbstate[cpu].active_mm != next);
 
 		if (!cpu_test_and_set(cpu, next->cpu_vm_mask)) {
 			/* We were in lazy tlb mode and leave_mm disabled 
--- ./include/asm-um/processor-generic.h.~1~	2004-02-20 18:43:27.000000000 +0100
+++ ./include/asm-um/processor-generic.h	2004-02-29 16:23:11.000000000 +0100
@@ -101,9 +101,9 @@
 
 extern unsigned long thread_saved_pc(struct task_struct *t);
 
-static inline void mm_copy_segments(struct mm_struct *from_mm, 
-				    struct mm_struct *new_mm)
+static inline int __init_new_context(struct mm_struct *mm, struct mm_struct *old_mm)
 {
+  return 0;
 }
 
 #define init_stack	(init_thread_union.stack)
--- ./mm/mmap.c.~1~	2004-02-29 16:22:01.000000000 +0100
+++ ./mm/mmap.c	2004-02-29 16:23:11.000000000 +0100
@@ -460,7 +460,7 @@
  * The caller must hold down_write(current->mm->mmap_sem).
  */
 
-unsigned long do_mmap_pgoff(struct mm_struct *mm, struct file * file, 
+unsigned long __do_mmap_pgoff(struct mm_struct *mm, struct file * file, 
 			    unsigned long addr, unsigned long len,
 			    unsigned long prot, unsigned long flags,
 			    unsigned long pgoff)
@@ -712,7 +712,7 @@
 	return error;
 }
 
-EXPORT_SYMBOL(do_mmap_pgoff);
+EXPORT_SYMBOL(__do_mmap_pgoff);
 
 /* Get an address range which is currently unmapped.
  * For shmat() with addr=0.
--- ./mm/mprotect.c.~1~	2004-02-29 16:22:01.000000000 +0100
+++ ./mm/mprotect.c	2004-02-29 16:23:11.000000000 +0100
@@ -221,7 +221,7 @@
 	return error;
 }
 
-asmlinkage long
+long
 do_mprotect(struct mm_struct *mm, unsigned long start, size_t len, 
 	     unsigned long prot)
 {
--- ./mm/proc_mm.c.~1~	2004-02-29 16:22:01.000000000 +0100
+++ ./mm/proc_mm.c	2004-02-29 16:23:11.000000000 +0100
@@ -93,7 +93,7 @@
 			break;
 		}
 
-		mm_copy_segments(from, mm);
+		__init_new_context(mm, from);
 		break;
 	}
 	default:

--Boundary-00=_JfBgACpzG/AePjM--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
