Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JDxvE-0007EZ-S7 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Jan 2008 00:10:25 -0800
Received: from rv-out-0910.google.com ([209.85.198.188])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JDxvE-0004cZ-9q
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Jan 2008 00:10:24 -0800
Received: by rv-out-0910.google.com with SMTP id g11so4749269rvb.22
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 13 Jan 2008 00:10:23 -0800 (PST)
Message-ID: <4789C771.5070100@finnie.org>
Date: Sun, 13 Jan 2008 00:10:25 -0800
From: Ryan Finnie <ryan@finnie.org>
MIME-Version: 1.0
Subject: [uml-devel] [RFC PATCH] SKAS3 for 2.6.24-rc7
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1362675307=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============1362675307==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1F993DE614A15D14A0FF33E5"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1F993DE614A15D14A0FF33E5
Content-Type: multipart/mixed; boundary="------------050803020801080000090209"

This is a multi-part message in MIME format.
--------------050803020801080000090209
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Please find attached a SKAS3 patch against Linux 2.6.24-rc7, based on
Jeff Dike's 2007-12-08 patch for 2.6.23.

Quoteth Jeff:
> 2.6.24 is going to be even more interesting, given the x86 merge.

Indeed it is.  This patch is not perfect and I need some help.  Host
i386 and x86_64 build with CONFIG_PROC_MM (I tested i386 and it works,
but for x86_64 I just made sure it compiles defconfig).  Guest i386
builds correctly and runs fine, but I cannot figure this out when
building guest x86_64:

  CC      arch/um/kernel/ptrace.o
In file included from arch/um/include/skas_ptrace.h:12,
                 from arch/um/kernel/ptrace.c:13:
arch/um/include/sysdep/skas_ptrace.h:9: error: redefinition of =E2=80=98s=
truct
ptrace_faultinfo=E2=80=99
arch/um/include/sysdep/skas_ptrace.h:14: error: redefinition of =E2=80=98=
struct
ptrace_ldt=E2=80=99
make[1]: *** [arch/um/kernel/ptrace.o] Error 1
make: *** [arch/um/kernel] Error 2

sysdep-i386/skas_ptrace.h and sysdep-x86_64/skas_ptrace.h are nearly
identical, so I can't figure out why ptrace_faultinfo and ptrace_ldt are
being defined in the first place.

RF

 arch/um/sys-i386/ldt.c           |    2
 arch/x86/Kconfig                 |   20 ++
 arch/x86/ia32/ptrace32.c         |   68 +++++++
 arch/x86/ia32/sys_ia32.c         |   16 +
 arch/x86/kernel/ldt_32.c         |   58 +++---
 arch/x86/kernel/ldt_64.c         |   55 +++--
 arch/x86/kernel/ptrace_32.c      |   61 ++++++
 arch/x86/kernel/ptrace_64.c      |   70 +++++++
 arch/x86/kernel/sys_i386_32.c    |   27 ++
 arch/x86/kernel/sys_x86_64.c     |   15 +
 arch/x86/mm/Makefile_64          |    1
 arch/x86/mm/proc_mm_64.c         |   85 ++++++++
 include/asm-um/compat.h          |    9
 include/asm-um/proc_mm_32.h      |    1
 include/asm-um/proc_mm_64.h      |    1
 include/asm-um/ptrace-x86_64.h   |   11 +
 include/asm-x86/desc_32.h        |    3
 include/asm-x86/desc_64.h        |    3
 include/asm-x86/mmu_context_32.h |   19 +
 include/asm-x86/mmu_context_64.h |   20 +-
 include/asm-x86/proc_mm_32.h     |   18 +
 include/asm-x86/proc_mm_64.h     |   58 ++++++
 include/asm-x86/ptrace-abi.h     |    6
 include/asm-x86/ptrace.h         |   65 ++++++
 include/linux/mm.h               |   19 +
 include/linux/proc_mm.h          |  110 +++++++++++
 mm/Makefile                      |    5
 mm/fremap.c                      |    5
 mm/mmap.c                        |   17 -
 mm/mprotect.c                    |   20 +-
 mm/proc_mm-mod.c                 |   50 +++++
 mm/proc_mm.c                     |  299 +++++++++++++++++++++++++++++++
 32 files changed, 1133 insertions(+), 84 deletions(-)


--------------050803020801080000090209
Content-Type: text/x-patch;
 name="2.6.24-rc7-skas3.20080113.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="2.6.24-rc7-skas3.20080113.patch"

diff -ruN linux-2.6.24-rc7.orig/arch/um/sys-i386/ldt.c linux-2.6.24-rc7/a=
rch/um/sys-i386/ldt.c
--- linux-2.6.24-rc7.orig/arch/um/sys-i386/ldt.c	2008-01-11 22:47:26.0000=
00000 -0800
+++ linux-2.6.24-rc7/arch/um/sys-i386/ldt.c	2008-01-12 23:48:48.000000000=
 -0800
@@ -6,7 +6,7 @@
 #include "linux/mm.h"
 #include "asm/unistd.h"
 #include "os.h"
-#include "proc_mm.h"
+#include "linux/proc_mm.h"
 #include "skas.h"
 #include "skas_ptrace.h"
 #include "sysdep/tls.h"
diff -ruN linux-2.6.24-rc7.orig/arch/x86/ia32/ptrace32.c linux-2.6.24-rc7=
/arch/x86/ia32/ptrace32.c
--- linux-2.6.24-rc7.orig/arch/x86/ia32/ptrace32.c	2008-01-11 22:47:26.00=
0000000 -0800
+++ linux-2.6.24-rc7/arch/x86/ia32/ptrace32.c	2008-01-12 23:45:33.0000000=
00 -0800
@@ -17,6 +17,8 @@
 #include <linux/mm.h>
 #include <linux/err.h>
 #include <linux/ptrace.h>
+#include <linux/types.h>
+#include <linux/proc_mm.h>
 #include <asm/ptrace.h>
 #include <asm/compat.h>
 #include <asm/uaccess.h>
@@ -27,6 +29,7 @@
 #include <asm/i387.h>
 #include <asm/fpu32.h>
 #include <asm/ia32.h>
+#include <asm/desc.h>
=20
 /*
  * Determines which flags the user has access to [1 =3D access, 0 =3D no=
 access].
@@ -266,6 +269,12 @@
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
=20
 	case PTRACE_SETSIGINFO:
@@ -388,6 +397,65 @@
 		ret =3D 0;=20
 		break;
 	}
+#ifdef CONFIG_PROC_MM
+	case PTRACE_EX_FAULTINFO: {
+		struct ptrace_ex_faultinfo32 fault;
+
+		fault =3D ((struct ptrace_ex_faultinfo32)
+			{ .is_write	=3D (compat_int_t) child->thread.error_code,
+			  .addr		=3D (compat_uptr_t) child->thread.cr2,
+			  .trap_no	=3D (compat_int_t) child->thread.trap_no });
+		ret =3D copy_to_user((unsigned long *) datap, &fault,
+				   sizeof(fault));
+		break;
+	}
+
+	case PTRACE_FAULTINFO: {
+		struct ptrace_faultinfo32 fault;
+
+		fault =3D ((struct ptrace_faultinfo32)
+			{ .is_write	=3D (compat_int_t) child->thread.error_code,
+			  .addr		=3D (compat_uptr_t) child->thread.cr2 });
+		ret =3D copy_to_user((unsigned long *) datap, &fault,
+				   sizeof(fault));
+		break;
+	}
+
+	case PTRACE_LDT: {
+		struct ptrace_ldt32 ldt;
+
+		if(copy_from_user(&ldt, (unsigned long *) datap,
+				  sizeof(ldt))){
+			ret =3D -EIO;
+			break;
+		}
+		ret =3D __modify_ldt(child->mm, ldt.func, compat_ptr(ldt.ptr), ldt.byt=
ecount);
+		break;
+	}
+
+	case PTRACE_SWITCH_MM: {
+		struct mm_struct *old =3D child->mm;
+		struct mm_struct *new =3D proc_mm_get_mm(data);
+
+		if(IS_ERR(new)){
+			ret =3D PTR_ERR(new);
+			break;
+		}
+
+		atomic_inc(&new->mm_users);
+
+		lock_fix_dumpable_setting(child, new);
+
+		child->mm =3D new;
+		child->active_mm =3D new;
+
+		task_unlock(child);
+
+		mmput(old);
+		ret =3D 0;
+		break;
+	}
+#endif
=20
 	case PTRACE_GETEVENTMSG:
 		ret =3D put_user(child->ptrace_message,(unsigned int __user *)compat_p=
tr(data));
diff -ruN linux-2.6.24-rc7.orig/arch/x86/ia32/sys_ia32.c linux-2.6.24-rc7=
/arch/x86/ia32/sys_ia32.c
--- linux-2.6.24-rc7.orig/arch/x86/ia32/sys_ia32.c	2008-01-11 22:47:26.00=
0000000 -0800
+++ linux-2.6.24-rc7/arch/x86/ia32/sys_ia32.c	2008-01-12 23:45:33.0000000=
00 -0800
@@ -693,11 +693,10 @@
 	return ret;
 }
=20
-asmlinkage long sys32_mmap2(unsigned long addr, unsigned long len,
-	unsigned long prot, unsigned long flags,
+long do32_mmap2(struct mm_struct *mm, unsigned long addr,
+	unsigned long len, unsigned long prot, unsigned long flags,
 	unsigned long fd, unsigned long pgoff)
 {
-	struct mm_struct *mm =3D current->mm;
 	unsigned long error;
 	struct file * file =3D NULL;
=20
@@ -709,7 +708,7 @@
 	}
=20
 	down_write(&mm->mmap_sem);
-	error =3D do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
+	error =3D __do_mmap_pgoff(mm, file, addr, len, prot, flags, pgoff);
 	up_write(&mm->mmap_sem);
=20
 	if (file)
@@ -717,6 +716,15 @@
 	return error;
 }
=20
+/* XXX: this wrapper can be probably removed, we can simply use the 64-b=
it
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
diff -ruN linux-2.6.24-rc7.orig/arch/x86/Kconfig linux-2.6.24-rc7/arch/x8=
6/Kconfig
--- linux-2.6.24-rc7.orig/arch/x86/Kconfig	2008-01-11 22:47:26.000000000 =
-0800
+++ linux-2.6.24-rc7/arch/x86/Kconfig	2008-01-12 23:45:33.000000000 -0800=

@@ -813,6 +813,26 @@
 	  has the cost of more pagetable lookup overhead, and also
 	  consumes more pagetable space per process.
=20
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
+	  This fiddles with some settings to make sure /proc/<pid> is completel=
y
+	  browsable by who started UML, at the expense of some additional
+	  locking (maybe this could slow down the runned UMLs of a few percents=
,
+	  I've not tested this).
+
+	  Also, if there is a bug in this feature, there is some little
+	  possibility to do privilege escalation if you have UML installed
+	  setuid (which you shouldn't have done) or if UML changes uid on
+	  startup (which will be a good thing, when enabled) ...
+
 # Common NUMA Features
 config NUMA
 	bool "Numa Memory Allocation and Scheduler Support (EXPERIMENTAL)"
diff -ruN linux-2.6.24-rc7.orig/arch/x86/kernel/ldt_32.c linux-2.6.24-rc7=
/arch/x86/kernel/ldt_32.c
--- linux-2.6.24-rc7.orig/arch/x86/kernel/ldt_32.c	2008-01-11 22:47:26.00=
0000000 -0800
+++ linux-2.6.24-rc7/arch/x86/kernel/ldt_32.c	2008-01-12 23:45:33.0000000=
00 -0800
@@ -25,11 +25,12 @@
 }
 #endif
=20
-static int alloc_ldt(mm_context_t *pc, int mincount, int reload)
+static int alloc_ldt(struct mm_struct *mm, int mincount, int reload)
 {
 	void *oldldt;
 	void *newldt;
 	int oldsize;
+	mm_context_t * pc =3D &mm->context;
=20
 	if (mincount <=3D pc->size)
 		return 0;
@@ -56,13 +57,15 @@
 #ifdef CONFIG_SMP
 		cpumask_t mask;
 		preempt_disable();
-		load_LDT(pc);
+		if (&current->active_mm->context =3D=3D pc)
+			load_LDT(pc);
 		mask =3D cpumask_of_cpu(smp_processor_id());
-		if (!cpus_equal(current->mm->cpu_vm_mask, mask))
+		if (!cpus_equal(mm->cpu_vm_mask, mask))
 			smp_call_function(flush_ldt, NULL, 1, 1);
 		preempt_enable();
 #else
-		load_LDT(pc);
+		if (&current->active_mm->context =3D=3D pc)
+			load_LDT(pc);
 #endif
 	}
 	if (oldsize) {
@@ -74,12 +77,12 @@
 	return 0;
 }
=20
-static inline int copy_ldt(mm_context_t *new, mm_context_t *old)
+static inline int copy_ldt(struct mm_struct *new, struct mm_struct *old)=

 {
-	int err =3D alloc_ldt(new, old->size, 0);
+	int err =3D alloc_ldt(new, old->context.size, 0);
 	if (err < 0)
 		return err;
-	memcpy(new->ldt, old->ldt, old->size*LDT_ENTRY_SIZE);
+	memcpy(new->context.ldt, old->context.ldt, old->context.size*LDT_ENTRY_=
SIZE);
 	return 0;
 }
=20
@@ -87,22 +90,24 @@
  * we do not have to muck with descriptors here, that is
  * done in switch_mm() as needed.
  */
-int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+int copy_context(struct mm_struct *mm, struct mm_struct *old_mm)
 {
-	struct mm_struct * old_mm;
 	int retval =3D 0;
=20
-	mutex_init(&mm->context.lock);
-	mm->context.size =3D 0;
-	old_mm =3D current->mm;
 	if (old_mm && old_mm->context.size > 0) {
 		mutex_lock(&old_mm->context.lock);
-		retval =3D copy_ldt(&mm->context, &old_mm->context);
+		retval =3D copy_ldt(mm, old_mm);
 		mutex_unlock(&old_mm->context.lock);
 	}
 	return retval;
 }
=20
+int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+{
+	init_new_empty_context(mm);
+	return copy_context(mm, current->mm);
+}
+
 /*
  * No need to lock the MM as we are the last user
  */
@@ -119,11 +124,11 @@
 	}
 }
=20
-static int read_ldt(void __user * ptr, unsigned long bytecount)
+static int read_ldt(struct mm_struct * mm, void __user * ptr,
+		    unsigned long bytecount)
 {
 	int err;
 	unsigned long size;
-	struct mm_struct * mm =3D current->mm;
=20
 	if (!mm->context.size)
 		return 0;
@@ -170,9 +175,8 @@
 	return err;
 }
=20
-static int write_ldt(void __user * ptr, unsigned long bytecount, int old=
mode)
+static int write_ldt(struct mm_struct * mm, void __user * ptr, unsigned =
long bytecount, int oldmode)
 {
-	struct mm_struct * mm =3D current->mm;
 	__u32 entry_1, entry_2;
 	int error;
 	struct user_desc ldt_info;
@@ -196,7 +200,7 @@
=20
 	mutex_lock(&mm->context.lock);
 	if (ldt_info.entry_number >=3D mm->context.size) {
-		error =3D alloc_ldt(&current->mm->context, ldt_info.entry_number+1, 1)=
;
+		error =3D alloc_ldt(mm, ldt_info.entry_number+1, 1);
 		if (error < 0)
 			goto out_unlock;
 	}
@@ -226,23 +230,33 @@
 	return error;
 }
=20
-asmlinkage int sys_modify_ldt(int func, void __user *ptr, unsigned long =
bytecount)
+int __modify_ldt(struct mm_struct * mm, int func, void __user *ptr,
+	       unsigned long bytecount)
 {
 	int ret =3D -ENOSYS;
=20
 	switch (func) {
 	case 0:
-		ret =3D read_ldt(ptr, bytecount);
+		ret =3D read_ldt(mm, ptr, bytecount);
 		break;
 	case 1:
-		ret =3D write_ldt(ptr, bytecount, 1);
+		ret =3D write_ldt(mm, ptr, bytecount, 1);
 		break;
 	case 2:
 		ret =3D read_default_ldt(ptr, bytecount);
 		break;
 	case 0x11:
-		ret =3D write_ldt(ptr, bytecount, 0);
+		ret =3D write_ldt(mm, ptr, bytecount, 0);
 		break;
 	}
 	return ret;
 }
+
+asmlinkage int sys_modify_ldt(int func, void __user *ptr, unsigned long =
bytecount)
+{
+	int ret =3D __modify_ldt(current->mm, func, ptr, bytecount);
+	/* A tail call would reorder parameters on the stack and they would the=
n
+	 * be restored at the wrong places. */
+	prevent_tail_call(ret);
+	return ret;
+}
diff -ruN linux-2.6.24-rc7.orig/arch/x86/kernel/ldt_64.c linux-2.6.24-rc7=
/arch/x86/kernel/ldt_64.c
--- linux-2.6.24-rc7.orig/arch/x86/kernel/ldt_64.c	2008-01-11 22:47:26.00=
0000000 -0800
+++ linux-2.6.24-rc7/arch/x86/kernel/ldt_64.c	2008-01-12 23:45:33.0000000=
00 -0800
@@ -19,6 +19,7 @@
 #include <asm/ldt.h>
 #include <asm/desc.h>
 #include <asm/proto.h>
+#include <asm/mmu_context.h>
=20
 #ifdef CONFIG_SMP /* avoids "defined but not used" warnig */
 static void flush_ldt(void *null)
@@ -28,11 +29,12 @@
 }
 #endif
=20
-static int alloc_ldt(mm_context_t *pc, unsigned mincount, int reload)
+static int alloc_ldt(struct mm_struct *mm, unsigned mincount, int reload=
)
 {
 	void *oldldt;
 	void *newldt;
 	unsigned oldsize;
+	mm_context_t * pc =3D &mm->context;
=20
 	if (mincount <=3D (unsigned)pc->size)
 		return 0;
@@ -61,12 +63,14 @@
=20
 		preempt_disable();
 		mask =3D cpumask_of_cpu(smp_processor_id());
-		load_LDT(pc);
-		if (!cpus_equal(current->mm->cpu_vm_mask, mask))
+		if (&current->active_mm->context =3D=3D pc)
+			load_LDT(pc);
+		if (!cpus_equal(mm->cpu_vm_mask, mask))
 			smp_call_function(flush_ldt, NULL, 1, 1);
 		preempt_enable();
 #else
-		load_LDT(pc);
+		if (&current->active_mm->context =3D=3D pc)
+			load_LDT(pc);
 #endif
 	}
 	if (oldsize) {
@@ -78,12 +82,12 @@
 	return 0;
 }
=20
-static inline int copy_ldt(mm_context_t *new, mm_context_t *old)
+static inline int copy_ldt(struct mm_struct *new, struct mm_struct *old)=

 {
-	int err =3D alloc_ldt(new, old->size, 0);
+	int err =3D alloc_ldt(new, old->context.size, 0);
 	if (err < 0)
 		return err;
-	memcpy(new->ldt, old->ldt, old->size*LDT_ENTRY_SIZE);
+	memcpy(new->context.ldt, old->context.ldt, old->context.size*LDT_ENTRY_=
SIZE);
 	return 0;
 }
=20
@@ -91,22 +95,24 @@
  * we do not have to muck with descriptors here, that is
  * done in switch_mm() as needed.
  */
-int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+int copy_context(struct mm_struct *mm, struct mm_struct *old_mm)
 {
-	struct mm_struct * old_mm;
 	int retval =3D 0;
=20
-	mutex_init(&mm->context.lock);
-	mm->context.size =3D 0;
-	old_mm =3D current->mm;
 	if (old_mm && old_mm->context.size > 0) {
 		mutex_lock(&old_mm->context.lock);
-		retval =3D copy_ldt(&mm->context, &old_mm->context);
+		retval =3D copy_ldt(mm, old_mm);
 		mutex_unlock(&old_mm->context.lock);
 	}
 	return retval;
 }
=20
+int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+{
+	init_new_empty_context(mm);
+	return copy_context(mm, current->mm);
+}
+
 /*
  *=20
  * Don't touch the LDT register - we're already in the next thread.
@@ -122,11 +128,10 @@
 	}
 }
=20
-static int read_ldt(void __user * ptr, unsigned long bytecount)
+static int read_ldt(struct mm_struct * mm, void __user * ptr, unsigned l=
ong bytecount)
 {
 	int err;
 	unsigned long size;
-	struct mm_struct * mm =3D current->mm;
=20
 	if (!mm->context.size)
 		return 0;
@@ -167,10 +172,8 @@
 	return bytecount;=20
 }
=20
-static int write_ldt(void __user * ptr, unsigned long bytecount, int old=
mode)
+static int write_ldt(struct mm_struct * mm, void __user * ptr, unsigned =
long bytecount, int oldmode)
 {
-	struct task_struct *me =3D current;
-	struct mm_struct * mm =3D me->mm;
 	__u32 entry_1, entry_2, *lp;
 	int error;
 	struct user_desc ldt_info;
@@ -195,7 +198,7 @@
=20
 	mutex_lock(&mm->context.lock);
 	if (ldt_info.entry_number >=3D (unsigned)mm->context.size) {
-		error =3D alloc_ldt(&current->mm->context, ldt_info.entry_number+1, 1)=
;
+		error =3D alloc_ldt(mm, ldt_info.entry_number+1, 1);
 		if (error < 0)
 			goto out_unlock;
 	}
@@ -228,23 +231,29 @@
 	return error;
 }
=20
-asmlinkage int sys_modify_ldt(int func, void __user *ptr, unsigned long =
bytecount)
+int __modify_ldt(struct mm_struct * mm, int func, void __user *ptr,
+		unsigned long bytecount)
 {
 	int ret =3D -ENOSYS;
=20
 	switch (func) {
 	case 0:
-		ret =3D read_ldt(ptr, bytecount);
+		ret =3D read_ldt(mm, ptr, bytecount);
 		break;
 	case 1:
-		ret =3D write_ldt(ptr, bytecount, 1);
+		ret =3D write_ldt(mm, ptr, bytecount, 1);
 		break;
 	case 2:
 		ret =3D read_default_ldt(ptr, bytecount);
 		break;
 	case 0x11:
-		ret =3D write_ldt(ptr, bytecount, 0);
+		ret =3D write_ldt(mm, ptr, bytecount, 0);
 		break;
 	}
 	return ret;
 }
+
+asmlinkage int sys_modify_ldt(int func, void __user *ptr, unsigned long =
bytecount)
+{
+	return __modify_ldt(current->mm, func, ptr, bytecount);
+}
diff -ruN linux-2.6.24-rc7.orig/arch/x86/kernel/ptrace_32.c linux-2.6.24-=
rc7/arch/x86/kernel/ptrace_32.c
--- linux-2.6.24-rc7.orig/arch/x86/kernel/ptrace_32.c	2008-01-11 22:47:26=
=2E000000000 -0800
+++ linux-2.6.24-rc7/arch/x86/kernel/ptrace_32.c	2008-01-12 23:45:33.0000=
00000 -0800
@@ -15,6 +15,7 @@
 #include <linux/audit.h>
 #include <linux/seccomp.h>
 #include <linux/signal.h>
+#include <linux/proc_mm.h>
=20
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -610,6 +611,66 @@
 					(struct user_desc __user *) data);
 		break;
=20
+#ifdef CONFIG_PROC_MM
+	case PTRACE_EX_FAULTINFO: {
+		struct ptrace_ex_faultinfo fault;
+
+		fault =3D ((struct ptrace_ex_faultinfo)
+			{ .is_write	=3D child->thread.error_code,
+			  .addr		=3D child->thread.cr2,
+			  .trap_no	=3D child->thread.trap_no });
+		ret =3D copy_to_user((unsigned long *) data, &fault,
+				   sizeof(fault));
+		break;
+	}
+
+	case PTRACE_FAULTINFO: {
+		struct ptrace_faultinfo fault;
+
+		fault =3D ((struct ptrace_faultinfo)
+			{ .is_write	=3D child->thread.error_code,
+			  .addr		=3D child->thread.cr2 });
+		ret =3D copy_to_user((unsigned long *) data, &fault,
+				   sizeof(fault));
+		break;
+	}
+
+	case PTRACE_LDT: {
+		struct ptrace_ldt ldt;
+
+		if(copy_from_user(&ldt, (unsigned long *) data,
+				  sizeof(ldt))){
+			ret =3D -EIO;
+			break;
+		}
+		ret =3D __modify_ldt(child->mm, ldt.func, ldt.ptr, ldt.bytecount);
+		break;
+	}
+
+	case PTRACE_SWITCH_MM: {
+		struct mm_struct *old =3D child->mm;
+		struct mm_struct *new =3D proc_mm_get_mm(data);
+
+		if(IS_ERR(new)){
+			ret =3D PTR_ERR(new);
+			break;
+		}
+
+		atomic_inc(&new->mm_users);
+
+		lock_fix_dumpable_setting(child, new);
+
+		child->mm =3D new;
+		child->active_mm =3D new;
+
+		task_unlock(child);
+
+		mmput(old);
+		ret =3D 0;
+		break;
+	}
+#endif
+
 	default:
 		ret =3D ptrace_request(child, request, addr, data);
 		break;
diff -ruN linux-2.6.24-rc7.orig/arch/x86/kernel/ptrace_64.c linux-2.6.24-=
rc7/arch/x86/kernel/ptrace_64.c
--- linux-2.6.24-rc7.orig/arch/x86/kernel/ptrace_64.c	2008-01-11 22:47:26=
=2E000000000 -0800
+++ linux-2.6.24-rc7/arch/x86/kernel/ptrace_64.c	2008-01-12 23:45:33.0000=
00000 -0800
@@ -17,6 +17,7 @@
 #include <linux/audit.h>
 #include <linux/seccomp.h>
 #include <linux/signal.h>
+#include <linux/proc_mm.h>
=20
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -555,6 +556,75 @@
 		break;
 	}
=20
+#ifdef CONFIG_PROC_MM
+	case PTRACE_EX_FAULTINFO: {
+		struct ptrace_ex_faultinfo fault;
+
+		/* I checked in thread_struct comments that error_code and cr2
+		 * are still part of the "fault info" section, so I guess that
+		 * things are unchanged for now. Still to check manuals. BB*/
+		fault =3D ((struct ptrace_ex_faultinfo)
+			{ .is_write	=3D child->thread.error_code,
+			  .addr		=3D child->thread.cr2,
+			  .trap_no	=3D child->thread.trap_no });
+		ret =3D copy_to_user((unsigned long *) data, &fault,
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
+		fault =3D ((struct ptrace_faultinfo)
+			{ .is_write	=3D child->thread.error_code,
+			  .addr		=3D child->thread.cr2 });
+		ret =3D copy_to_user((unsigned long *) data, &fault,
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
+			ret =3D -EIO;
+			break;
+		}
+		ret =3D __modify_ldt(child->mm, ldt.func, ldt.ptr, ldt.bytecount);
+		break;
+	}
+
+	case PTRACE_SWITCH_MM: {
+		struct mm_struct *old =3D child->mm;
+		struct mm_struct *new =3D proc_mm_get_mm64(data);
+
+		if(IS_ERR(new)){
+			ret =3D PTR_ERR(new);
+			break;
+		}
+
+		atomic_inc(&new->mm_users);
+
+		lock_fix_dumpable_setting(child, new);
+
+		child->mm =3D new;
+		child->active_mm =3D new;
+
+		task_unlock(child);
+
+		mmput(old);
+		ret =3D 0;
+		break;
+	}
+#endif
+
 	default:
 		ret =3D ptrace_request(child, request, addr, data);
 		break;
diff -ruN linux-2.6.24-rc7.orig/arch/x86/kernel/sys_i386_32.c linux-2.6.2=
4-rc7/arch/x86/kernel/sys_i386_32.c
--- linux-2.6.24-rc7.orig/arch/x86/kernel/sys_i386_32.c	2008-01-11 22:47:=
26.000000000 -0800
+++ linux-2.6.24-rc7/arch/x86/kernel/sys_i386_32.c	2008-01-12 23:45:33.00=
0000000 -0800
@@ -18,6 +18,7 @@
 #include <linux/file.h>
 #include <linux/utsname.h>
 #include <linux/ipc.h>
+#include <asm/proc_mm_32.h>
=20
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -39,13 +40,12 @@
 	return error;
 }
=20
-asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
-			  unsigned long prot, unsigned long flags,
-			  unsigned long fd, unsigned long pgoff)
+long do_mmap2(struct mm_struct *mm, unsigned long addr, unsigned long le=
n,
+		unsigned long prot, unsigned long flags, unsigned long fd,
+		unsigned long pgoff)
 {
 	int error =3D -EBADF;
 	struct file *file =3D NULL;
-	struct mm_struct *mm =3D current->mm;
=20
 	flags &=3D ~(MAP_EXECUTABLE | MAP_DENYWRITE);
 	if (!(flags & MAP_ANONYMOUS)) {
@@ -55,7 +55,7 @@
 	}
=20
 	down_write(&mm->mmap_sem);
-	error =3D do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
+	error =3D __do_mmap_pgoff(mm, file, addr, len, prot, flags, pgoff);
 	up_write(&mm->mmap_sem);
=20
 	if (file)
@@ -64,6 +64,18 @@
 	return error;
 }
=20
+asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
+       unsigned long prot, unsigned long flags,
+       unsigned long fd, unsigned long pgoff)
+{
+	long ret =3D do_mmap2(current->mm, addr, len, prot, flags, fd, pgoff);
+
+	/* A tail call would reorder parameters on the stack and they would the=
n
+	 * be restored at the wrong places. */
+	prevent_tail_call(ret);
+	return ret;
+}
+
 /*
  * Perform the select(nd, in, out, ex, tv) and mmap() system
  * calls. Linux/i386 didn't use to be able to handle more than
@@ -92,8 +104,11 @@
 	if (a.offset & ~PAGE_MASK)
 		goto out;
=20
-	err =3D sys_mmap2(a.addr, a.len, a.prot, a.flags,
+	err =3D do_mmap2(current->mm, a.addr, a.len, a.prot, a.flags,
 			a.fd, a.offset >> PAGE_SHIFT);
+	/* A tail call would reorder parameters on the stack and they would the=
n
+	 * be restored at the wrong places. */
+	prevent_tail_call(err);
 out:
 	return err;
 }
diff -ruN linux-2.6.24-rc7.orig/arch/x86/kernel/sys_x86_64.c linux-2.6.24=
-rc7/arch/x86/kernel/sys_x86_64.c
--- linux-2.6.24-rc7.orig/arch/x86/kernel/sys_x86_64.c	2008-01-11 22:47:2=
6.000000000 -0800
+++ linux-2.6.24-rc7/arch/x86/kernel/sys_x86_64.c	2008-01-12 23:45:33.000=
000000 -0800
@@ -15,6 +15,7 @@
=20
 #include <asm/uaccess.h>
 #include <asm/ia32.h>
+#include <asm/proc_mm_64.h>
=20
 /*
  * sys_pipe() is the normal C calling standard for creating
@@ -33,7 +34,7 @@
 	return error;
 }
=20
-asmlinkage long sys_mmap(unsigned long addr, unsigned long len, unsigned=
 long prot, unsigned long flags,
+long do64_mmap(struct mm_struct *mm, unsigned long addr, unsigned long l=
en, unsigned long prot, unsigned long flags,
 	unsigned long fd, unsigned long off)
 {
 	long error;
@@ -51,9 +52,9 @@
 		if (!file)
 			goto out;
 	}
-	down_write(&current->mm->mmap_sem);
-	error =3D do_mmap_pgoff(file, addr, len, prot, flags, off >> PAGE_SHIFT=
);
-	up_write(&current->mm->mmap_sem);
+	down_write(&mm->mmap_sem);
+	error =3D __do_mmap_pgoff(mm, file, addr, len, prot, flags, off >> PAGE=
_SHIFT);
+	up_write(&mm->mmap_sem);
=20
 	if (file)
 		fput(file);
@@ -61,6 +62,12 @@
 	return error;
 }
=20
+asmlinkage long sys_mmap(unsigned long addr, unsigned long len, unsigned=
 long prot, unsigned long flags,
+	unsigned long fd, unsigned long off)
+{
+	return do64_mmap(current->mm, addr, len, prot, flags, fd, off);
+}
+
 static void find_start_end(unsigned long flags, unsigned long *begin,
 			   unsigned long *end)
 {
diff -ruN linux-2.6.24-rc7.orig/arch/x86/mm/Makefile_64 linux-2.6.24-rc7/=
arch/x86/mm/Makefile_64
--- linux-2.6.24-rc7.orig/arch/x86/mm/Makefile_64	2008-01-11 22:47:26.000=
000000 -0800
+++ linux-2.6.24-rc7/arch/x86/mm/Makefile_64	2008-01-12 23:45:33.00000000=
0 -0800
@@ -7,4 +7,5 @@
 obj-$(CONFIG_NUMA) +=3D numa_64.o
 obj-$(CONFIG_K8_NUMA) +=3D k8topology_64.o
 obj-$(CONFIG_ACPI_NUMA) +=3D srat_64.o
+obj-$(CONFIG_PROC_MM) +=3D proc_mm_64.o
=20
diff -ruN linux-2.6.24-rc7.orig/arch/x86/mm/proc_mm_64.c linux-2.6.24-rc7=
/arch/x86/mm/proc_mm_64.c
--- linux-2.6.24-rc7.orig/arch/x86/mm/proc_mm_64.c	1969-12-31 16:00:00.00=
0000000 -0800
+++ linux-2.6.24-rc7/arch/x86/mm/proc_mm_64.c	2008-01-12 23:45:33.0000000=
00 -0800
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
+	struct mm_struct *mm =3D file->private_data;
+	struct proc_mm_op32 req;
+	int n, ret;
+
+	if(count > sizeof(req))
+		return(-EINVAL);
+
+	n =3D copy_from_user(&req, buffer, count);
+	if(n !=3D 0)
+		return(-EFAULT);
+
+	ret =3D count;
+	switch(req.op){
+	case MM_MMAP: {
+		struct mm_mmap32 *map =3D &req.u.mmap;
+
+		/* Nobody ever noticed it, but do_mmap_pgoff() calls
+		 * get_unmapped_area() which checks current->mm, if
+		 * MAP_FIXED is not set, so mmap() could replace
+		 * an old mapping.
+		 */
+		if (! (map->flags & MAP_FIXED))
+			return(-EINVAL);
+
+		ret =3D __do_mmap(mm, map->addr, map->len, map->prot,
+			       map->flags, map->fd, map->offset);
+		if((ret & ~PAGE_MASK) =3D=3D 0)
+			ret =3D count;
+
+		break;
+	}
+	case MM_MUNMAP: {
+		struct mm_munmap32 *unmap =3D &req.u.munmap;
+
+		down_write(&mm->mmap_sem);
+		ret =3D do_munmap(mm, unmap->addr, unmap->len);
+		up_write(&mm->mmap_sem);
+
+		if(ret =3D=3D 0)
+			ret =3D count;
+		break;
+	}
+	case MM_MPROTECT: {
+		struct mm_mprotect32 *protect =3D &req.u.mprotect;
+
+		ret =3D do_mprotect(mm, protect->addr, protect->len,
+				  protect->prot);
+		if(ret =3D=3D 0)
+			ret =3D count;
+		break;
+	}
+
+	case MM_COPY_SEGMENTS: {
+		struct mm_struct *from =3D proc_mm_get_mm_emul(req.u.copy_segments);
+
+		if(IS_ERR(from)){
+			ret =3D PTR_ERR(from);
+			break;
+		}
+
+		ret =3D copy_context(mm, from);
+		if(ret =3D=3D 0)
+			ret =3D count;
+		break;
+	}
+	default:
+		ret =3D -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
diff -ruN linux-2.6.24-rc7.orig/include/asm-um/compat.h linux-2.6.24-rc7/=
include/asm-um/compat.h
--- linux-2.6.24-rc7.orig/include/asm-um/compat.h	1969-12-31 16:00:00.000=
000000 -0800
+++ linux-2.6.24-rc7/include/asm-um/compat.h	2008-01-12 23:45:33.00000000=
0 -0800
@@ -0,0 +1,9 @@
+#ifndef _ASM_X86_64_COMPAT_H
+#define _ASM_X86_64_COMPAT_H
+
+typedef s32		compat_int_t;
+typedef s32		compat_long_t;
+typedef u32		compat_uint_t;
+typedef u32		compat_ulong_t;
+
+#endif /* _ASM_X86_64_COMPAT_H */
diff -ruN linux-2.6.24-rc7.orig/include/asm-um/proc_mm_32.h linux-2.6.24-=
rc7/include/asm-um/proc_mm_32.h
--- linux-2.6.24-rc7.orig/include/asm-um/proc_mm_32.h	1969-12-31 16:00:00=
=2E000000000 -0800
+++ linux-2.6.24-rc7/include/asm-um/proc_mm_32.h	2008-01-12 23:45:33.0000=
00000 -0800
@@ -0,0 +1 @@
+#include <asm/arch/proc_mm_32.h>
diff -ruN linux-2.6.24-rc7.orig/include/asm-um/proc_mm_64.h linux-2.6.24-=
rc7/include/asm-um/proc_mm_64.h
--- linux-2.6.24-rc7.orig/include/asm-um/proc_mm_64.h	1969-12-31 16:00:00=
=2E000000000 -0800
+++ linux-2.6.24-rc7/include/asm-um/proc_mm_64.h	2008-01-12 23:45:33.0000=
00000 -0800
@@ -0,0 +1 @@
+#include <asm/arch/proc_mm_64.h>
diff -ruN linux-2.6.24-rc7.orig/include/asm-um/ptrace-x86_64.h linux-2.6.=
24-rc7/include/asm-um/ptrace-x86_64.h
--- linux-2.6.24-rc7.orig/include/asm-um/ptrace-x86_64.h	2008-01-11 22:47=
:29.000000000 -0800
+++ linux-2.6.24-rc7/include/asm-um/ptrace-x86_64.h	2008-01-12 23:45:33.0=
00000000 -0800
@@ -78,4 +78,15 @@
=20
 extern long arch_prctl(struct task_struct *task, int code,
 		       unsigned long __user *addr);
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
 #endif
diff -ruN linux-2.6.24-rc7.orig/include/asm-x86/desc_32.h linux-2.6.24-rc=
7/include/asm-x86/desc_32.h
--- linux-2.6.24-rc7.orig/include/asm-x86/desc_32.h	2008-01-11 22:47:29.0=
00000000 -0800
+++ linux-2.6.24-rc7/include/asm-x86/desc_32.h	2008-01-12 23:45:33.000000=
000 -0800
@@ -216,6 +216,9 @@
 	return base;
 }
=20
+extern int __modify_ldt(struct mm_struct * mm, int func, void __user *pt=
r,
+		      unsigned long bytecount);
+
 #else /* __ASSEMBLY__ */
=20
 /*
diff -ruN linux-2.6.24-rc7.orig/include/asm-x86/desc_64.h linux-2.6.24-rc=
7/include/asm-x86/desc_64.h
--- linux-2.6.24-rc7.orig/include/asm-x86/desc_64.h	2008-01-11 22:47:29.0=
00000000 -0800
+++ linux-2.6.24-rc7/include/asm-x86/desc_64.h	2008-01-12 23:45:33.000000=
000 -0800
@@ -199,6 +199,9 @@
=20
 extern struct desc_ptr idt_descr;
=20
+extern int __modify_ldt(struct mm_struct * mm, int func, void __user *pt=
r,
+		unsigned long bytecount);
+
 #endif /* !__ASSEMBLY__ */
=20
 #endif
diff -ruN linux-2.6.24-rc7.orig/include/asm-x86/mmu_context_32.h linux-2.=
6.24-rc7/include/asm-x86/mmu_context_32.h
--- linux-2.6.24-rc7.orig/include/asm-x86/mmu_context_32.h	2008-01-11 22:=
47:29.000000000 -0800
+++ linux-2.6.24-rc7/include/asm-x86/mmu_context_32.h	2008-01-12 23:45:33=
=2E000000000 -0800
@@ -5,6 +5,7 @@
 #include <asm/atomic.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
+#include <asm/semaphore.h>
 #include <asm/paravirt.h>
 #ifndef CONFIG_PARAVIRT
 #include <asm-generic/mm_hooks.h>
@@ -17,11 +18,22 @@
=20
=20
 /*
- * Used for LDT copy/destruction.
+ * Used for LDT initialization/destruction. You cannot copy an LDT with
+ * init_new_context, since it thinks you are passing it a new LDT and wo=
n't
+ * deallocate its old content.
  */
 int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
 void destroy_context(struct mm_struct *mm);
=20
+/* LDT initialization for a clean environment - needed for SKAS.*/
+static inline void init_new_empty_context(struct mm_struct *mm)
+{
+	mutex_init(&mm->context.lock);
+	mm->context.size =3D 0;
+}
+
+/* LDT copy for SKAS - for the above problem.*/
+int copy_context(struct mm_struct *mm, struct mm_struct *old_mm);
=20
 static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_stru=
ct *tsk)
 {
@@ -40,6 +52,10 @@
 {
 	int cpu =3D smp_processor_id();
=20
+#ifdef CONFIG_SMP
+	prev =3D per_cpu(cpu_tlbstate, cpu).active_mm;
+#endif
+
 	if (likely(prev !=3D next)) {
 		/* stop flush ipis for the previous mm */
 		cpu_clear(cpu, prev->cpu_vm_mask);
@@ -61,7 +77,6 @@
 #ifdef CONFIG_SMP
 	else {
 		per_cpu(cpu_tlbstate, cpu).state =3D TLBSTATE_OK;
-		BUG_ON(per_cpu(cpu_tlbstate, cpu).active_mm !=3D next);
=20
 		if (!cpu_test_and_set(cpu, next->cpu_vm_mask)) {
 			/* We were in lazy tlb mode and leave_mm disabled=20
diff -ruN linux-2.6.24-rc7.orig/include/asm-x86/mmu_context_64.h linux-2.=
6.24-rc7/include/asm-x86/mmu_context_64.h
--- linux-2.6.24-rc7.orig/include/asm-x86/mmu_context_64.h	2008-01-11 22:=
47:29.000000000 -0800
+++ linux-2.6.24-rc7/include/asm-x86/mmu_context_64.h	2008-01-12 23:45:33=
=2E000000000 -0800
@@ -7,14 +7,29 @@
 #include <asm/pda.h>
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
+#include <asm/semaphore.h>
 #include <asm-generic/mm_hooks.h>
=20
 /*
  * possibly do the LDT unload here?
+ * Used for LDT initialization/destruction. You cannot copy an LDT with
+ * init_new_context, since it thinks you are passing it a new LDT and wo=
n't
+ * deallocate its old content.
  */
+
 int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
 void destroy_context(struct mm_struct *mm);
=20
+/* LDT initialization for a clean environment - needed for SKAS.*/
+static inline void init_new_empty_context(struct mm_struct *mm)
+{
+	mutex_init(&mm->context.lock);
+	mm->context.size =3D 0;
+}
+
+/* LDT copy for SKAS - for the above problem.*/
+int copy_context(struct mm_struct *mm, struct mm_struct *old_mm);
+
 static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_stru=
ct *tsk)
 {
 #ifdef CONFIG_SMP
@@ -32,6 +47,9 @@
 			     struct task_struct *tsk)
 {
 	unsigned cpu =3D smp_processor_id();
+#ifdef CONFIG_SMP
+	prev =3D read_pda(active_mm);
+#endif
 	if (likely(prev !=3D next)) {
 		/* stop flush ipis for the previous mm */
 		cpu_clear(cpu, prev->cpu_vm_mask);
@@ -48,8 +66,6 @@
 #ifdef CONFIG_SMP
 	else {
 		write_pda(mmu_state, TLBSTATE_OK);
-		if (read_pda(active_mm) !=3D next)
-			out_of_line_bug();
 		if (!cpu_test_and_set(cpu, next->cpu_vm_mask)) {
 			/* We were in lazy tlb mode and leave_mm disabled=20
 			 * tlb flush IPI delivery. We must reload CR3
diff -ruN linux-2.6.24-rc7.orig/include/asm-x86/proc_mm_32.h linux-2.6.24=
-rc7/include/asm-x86/proc_mm_32.h
--- linux-2.6.24-rc7.orig/include/asm-x86/proc_mm_32.h	1969-12-31 16:00:0=
0.000000000 -0800
+++ linux-2.6.24-rc7/include/asm-x86/proc_mm_32.h	2008-01-12 23:45:33.000=
000000 -0800
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
diff -ruN linux-2.6.24-rc7.orig/include/asm-x86/proc_mm_64.h linux-2.6.24=
-rc7/include/asm-x86/proc_mm_64.h
--- linux-2.6.24-rc7.orig/include/asm-x86/proc_mm_64.h	1969-12-31 16:00:0=
0.000000000 -0800
+++ linux-2.6.24-rc7/include/asm-x86/proc_mm_64.h	2008-01-12 23:45:33.000=
000000 -0800
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
+extern ssize_t write_proc_mm_emul(struct file *file, const char *buffer,=

+			     size_t count, loff_t *ppos);
+
+extern struct mm_struct *proc_mm_get_mm64(int fd);
+
+extern long do64_mmap(struct mm_struct *mm, unsigned long addr, unsigned=
 long len, unsigned long prot, unsigned long flags,
+	unsigned long fd, unsigned long off);
+
+static inline long __do_mmap(struct mm_struct *mm, unsigned long addr,
+		     unsigned long len, unsigned long prot,
+		     unsigned long flags, unsigned long fd,
+		     unsigned long off)
+{
+	/* The latter one is stricter, since will actually check that off is pa=
ge
+	 * aligned. The first one skipped the check. */
+
+	/* return do32_mmap2(mm, addr, len, prot, flags, fd, off >>
+	 * PAGE_SHIFT);*/
+	return do64_mmap(mm, addr, len, prot, flags, fd, off);
+}
+
+#endif /* __ASM_PROC_MM */
diff -ruN linux-2.6.24-rc7.orig/include/asm-x86/ptrace-abi.h linux-2.6.24=
-rc7/include/asm-x86/ptrace-abi.h
--- linux-2.6.24-rc7.orig/include/asm-x86/ptrace-abi.h	2008-01-11 22:47:2=
9.000000000 -0800
+++ linux-2.6.24-rc7/include/asm-x86/ptrace-abi.h	2008-01-12 23:45:33.000=
000000 -0800
@@ -65,6 +65,12 @@
 #define PTRACE_GETFPXREGS         18
 #define PTRACE_SETFPXREGS         19
=20
+#define PTRACE_FAULTINFO 52
+/* 53 was used for PTRACE_SIGPENDING, don't reuse it. */
+#define PTRACE_LDT 54
+#define PTRACE_SWITCH_MM 55
+#define PTRACE_EX_FAULTINFO	  56
+
 #define PTRACE_OLDSETOPTIONS      21
=20
 /* only useful for access 32bit programs / kernels */
diff -ruN linux-2.6.24-rc7.orig/include/asm-x86/ptrace.h linux-2.6.24-rc7=
/include/asm-x86/ptrace.h
--- linux-2.6.24-rc7.orig/include/asm-x86/ptrace.h	2008-01-11 22:47:29.00=
0000000 -0800
+++ linux-2.6.24-rc7/include/asm-x86/ptrace.h	2008-01-12 23:45:33.0000000=
00 -0800
@@ -139,4 +139,69 @@
 #endif /* !__i386__ */
 #endif /* !__ASSEMBLY__ */
=20
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
+	compat_uptr_t ptr; /*Actually a void pointer on i386, but must be conve=
rted.*/
+	compat_ulong_t bytecount;
+};
+
+#undef	compat_int_t
+#undef	compat_long_t
+#undef	compat_uint_t
+#undef	compat_ulong_t
+#undef	compat_uptr_t
+
 #endif
diff -ruN linux-2.6.24-rc7.orig/include/linux/mm.h linux-2.6.24-rc7/inclu=
de/linux/mm.h
--- linux-2.6.24-rc7.orig/include/linux/mm.h	2008-01-11 22:47:29.00000000=
0 -0800
+++ linux-2.6.24-rc7/include/linux/mm.h	2008-01-12 23:45:33.000000000 -08=
00
@@ -5,6 +5,7 @@
=20
 #ifdef __KERNEL__
=20
+#include <linux/proc_mm.h>
 #include <linux/gfp.h>
 #include <linux/list.h>
 #include <linux/mmzone.h>
@@ -996,11 +997,18 @@
=20
 extern unsigned long get_unmapped_area(struct file *, unsigned long, uns=
igned long, unsigned long, unsigned long);
=20
-extern unsigned long do_mmap_pgoff(struct file *file, unsigned long addr=
,
+extern unsigned long __do_mmap_pgoff(struct mm_struct *mm, struct file *=
file,
+				   unsigned long addr, unsigned long len,
+				   unsigned long prot, unsigned long flag,
+				   unsigned long pgoff);
+static inline unsigned long do_mmap_pgoff(struct file *file, unsigned lo=
ng addr,
 	unsigned long len, unsigned long prot,
-	unsigned long flag, unsigned long pgoff);
-extern unsigned long mmap_region(struct file *file, unsigned long addr,
-	unsigned long len, unsigned long flags,
+	unsigned long flag, unsigned long pgoff) {
+	return __do_mmap_pgoff(current->mm, file, addr, len, prot, flag, pgoff)=
;
+}
+
+extern unsigned long mmap_region(struct mm_struct *mm, struct file *file=
,
+	unsigned long addr, unsigned long len, unsigned long flags,
 	unsigned int vm_flags, unsigned long pgoff,
 	int accountable);
=20
@@ -1019,6 +1027,9 @@
=20
 extern int do_munmap(struct mm_struct *, unsigned long, size_t);
=20
+extern long do_mprotect(struct mm_struct *mm, unsigned long start,
+			size_t len, unsigned long prot);
+
 extern unsigned long do_brk(unsigned long, unsigned long);
=20
 /* filemap.c */
diff -ruN linux-2.6.24-rc7.orig/include/linux/proc_mm.h linux-2.6.24-rc7/=
include/linux/proc_mm.h
--- linux-2.6.24-rc7.orig/include/linux/proc_mm.h	1969-12-31 16:00:00.000=
000000 -0800
+++ linux-2.6.24-rc7/include/linux/proc_mm.h	2008-01-12 23:45:33.00000000=
0 -0800
@@ -0,0 +1,110 @@
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
+ * - we must accept the struct mm_struct on which to act as first param,=
 and the
+ *   offset in byte rather than page units as last param.
+ */
+static inline long __do_mmap(struct mm_struct *mm, unsigned long addr,
+		     unsigned long len, unsigned long prot,
+		     unsigned long flags, unsigned long fd,
+		     unsigned long off);
+
+/*XXX: this is defined on x86_64, but not on every 64-bit arch (not on s=
h64).*/
+#ifdef CONFIG_64BIT
+
+#include <asm/proc_mm_64.h>
+#define write_proc_mm write_proc_mm_emul
+#define write_proc_mm64 write_proc_mm_native
+
+/* It would make more sense to do this mapping the reverse direction, to=
 map the
+ * called name to the defined one and not the reverse. Like the 2nd exam=
ple
+ */
+/*#define proc_mm_get_mm proc_mm_get_mm_emul
+#define proc_mm_get_mm64 proc_mm_get_mm_native*/
+
+#define proc_mm_get_mm_emul proc_mm_get_mm
+#define proc_mm_get_mm_native proc_mm_get_mm64
+
+#else
+
+#include <asm/proc_mm_32.h>
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
+ * Since we take task_lock of child and it's needed also by the caller, =
we
+ * return with it locked.
+ */
+extern void lock_fix_dumpable_setting(struct task_struct * child,
+		struct mm_struct* new) __acquires(child->alloc_lock);
+#else
+static inline void lock_fix_dumpable_setting(struct task_struct * child,=

+		struct mm_struct* new) __acquires(child->alloc_lock)
+{
+	task_lock(child);
+}
+#endif
+
+#endif
diff -ruN linux-2.6.24-rc7.orig/mm/fremap.c linux-2.6.24-rc7/mm/fremap.c
--- linux-2.6.24-rc7.orig/mm/fremap.c	2008-01-11 22:47:30.000000000 -0800=

+++ linux-2.6.24-rc7/mm/fremap.c	2008-01-12 23:45:33.000000000 -0800
@@ -192,8 +192,9 @@
 			unsigned long addr;
=20
 			flags &=3D MAP_NONBLOCK;
-			addr =3D mmap_region(vma->vm_file, start, size,
-					flags, vma->vm_flags, pgoff, 1);
+			addr =3D mmap_region(current->mm, vma->vm_file, start,
+					   size, flags, vma->vm_flags, pgoff,
+					   1);
 			if (IS_ERR_VALUE(addr)) {
 				err =3D addr;
 			} else {
diff -ruN linux-2.6.24-rc7.orig/mm/Makefile linux-2.6.24-rc7/mm/Makefile
--- linux-2.6.24-rc7.orig/mm/Makefile	2008-01-11 22:47:30.000000000 -0800=

+++ linux-2.6.24-rc7/mm/Makefile	2008-01-12 23:45:33.000000000 -0800
@@ -29,5 +29,10 @@
 obj-$(CONFIG_FS_XIP) +=3D filemap_xip.o
 obj-$(CONFIG_MIGRATION) +=3D migrate.o
 obj-$(CONFIG_SMP) +=3D allocpercpu.o
+obj-$(CONFIG_PROC_MM)	+=3D proc_mm.o
+
+ifeq ($(CONFIG_PROC_MM),y)
+obj-m			+=3D proc_mm-mod.o
+endif
 obj-$(CONFIG_QUICKLIST) +=3D quicklist.o
=20
diff -ruN linux-2.6.24-rc7.orig/mm/mmap.c linux-2.6.24-rc7/mm/mmap.c
--- linux-2.6.24-rc7.orig/mm/mmap.c	2008-01-11 22:47:30.000000000 -0800
+++ linux-2.6.24-rc7/mm/mmap.c	2008-01-12 23:45:33.000000000 -0800
@@ -887,12 +887,11 @@
 /*
  * The caller must hold down_write(current->mm->mmap_sem).
  */
-
-unsigned long do_mmap_pgoff(struct file * file, unsigned long addr,
-			unsigned long len, unsigned long prot,
-			unsigned long flags, unsigned long pgoff)
+unsigned long __do_mmap_pgoff(struct mm_struct *mm, struct file * file,
+			    unsigned long addr, unsigned long len,
+			    unsigned long prot, unsigned long flags,
+			    unsigned long pgoff)
 {
-	struct mm_struct * mm =3D current->mm;
 	struct inode *inode;
 	unsigned int vm_flags;
 	int error;
@@ -1026,10 +1025,10 @@
 	if (error)
 		return error;
=20
-	return mmap_region(file, addr, len, flags, vm_flags, pgoff,
+	return mmap_region(mm, file, addr, len, flags, vm_flags, pgoff,
 			   accountable);
 }
-EXPORT_SYMBOL(do_mmap_pgoff);
+EXPORT_SYMBOL(__do_mmap_pgoff);
=20
 /*
  * Some shared mappigns will want the pages marked read-only
@@ -1064,12 +1063,12 @@
 }
=20
=20
-unsigned long mmap_region(struct file *file, unsigned long addr,
+unsigned long mmap_region(struct mm_struct *mm,
+			  struct file *file, unsigned long addr,
 			  unsigned long len, unsigned long flags,
 			  unsigned int vm_flags, unsigned long pgoff,
 			  int accountable)
 {
-	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma, *prev;
 	int correct_wcount =3D 0;
 	int error;
diff -ruN linux-2.6.24-rc7.orig/mm/mprotect.c linux-2.6.24-rc7/mm/mprotec=
t.c
--- linux-2.6.24-rc7.orig/mm/mprotect.c	2008-01-11 22:47:30.000000000 -08=
00
+++ linux-2.6.24-rc7/mm/mprotect.c	2008-01-12 23:45:33.000000000 -0800
@@ -211,8 +211,9 @@
 	return error;
 }
=20
-asmlinkage long
-sys_mprotect(unsigned long start, size_t len, unsigned long prot)
+long
+do_mprotect(struct mm_struct *mm, unsigned long start, size_t len,
+	     unsigned long prot)
 {
 	unsigned long vm_flags, nstart, end, tmp, reqprot;
 	struct vm_area_struct *vma, *prev;
@@ -242,9 +243,9 @@
=20
 	vm_flags =3D calc_vm_prot_bits(prot);
=20
-	down_write(&current->mm->mmap_sem);
+	down_write(&mm->mmap_sem);
=20
-	vma =3D find_vma_prev(current->mm, start, &prev);
+	vma =3D find_vma_prev(mm, start, &prev);
 	error =3D -ENOMEM;
 	if (!vma)
 		goto out;
@@ -306,6 +307,15 @@
 		}
 	}
 out:
-	up_write(&current->mm->mmap_sem);
+	up_write(&mm->mmap_sem);
 	return error;
 }
+
+asmlinkage long sys_mprotect(unsigned long start, size_t len, unsigned l=
ong prot)
+{
+	long ret =3D do_mprotect(current->mm, start, len, prot);
+	/* A tail call would reorder parameters on the stack and they would the=
n
+	 * be restored at the wrong places. */
+	prevent_tail_call(ret);
+	return ret;
+}
diff -ruN linux-2.6.24-rc7.orig/mm/proc_mm.c linux-2.6.24-rc7/mm/proc_mm.=
c
--- linux-2.6.24-rc7.orig/mm/proc_mm.c	1969-12-31 16:00:00.000000000 -080=
0
+++ linux-2.6.24-rc7/mm/proc_mm.c	2008-01-12 23:45:33.000000000 -0800
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
+ * XXX: copied from fs/proc/base.c, removed task_lock, added rmb(): this=
 must be
+ * called with task_lock(task) held. */
+static int task_dumpable(struct task_struct *task)
+{
+	int dumpable =3D 0;
+	struct mm_struct *mm;
+
+	mm =3D task->mm;
+	if (mm) {
+		rmb();
+		dumpable =3D mm->dumpable;
+	}
+	return dumpable;
+}
+
+/*
+ * This is to be used in PTRACE_SWITCH_MM handling. We are going to set
+ * child->mm to new, and we must first correctly set new->dumpable.
+ * Since we take task_lock of child and it's needed also by the caller, =
we
+ * return with it locked.
+ */
+void lock_fix_dumpable_setting(struct task_struct* child, struct mm_stru=
ct* new)
+	__acquires(child->alloc_lock)
+{
+	int dumpable =3D 1;
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
+		dumpable =3D 0;
+	}
+	task_unlock(current);
+
+	task_lock(child);
+	if (likely(dumpable) && unlikely(!task_dumpable(child))) {
+		dumpable =3D 0;
+	}
+
+	if (!dumpable) {
+		new->dumpable =3D 0;
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
+ * _mm means /proc/mm, _mm64 means /proc/mm64. This is for the infrastru=
cture
+ * only (for instance proc_mm_get_mm checks whether the file is /proc/mm=
 or
+ * /proc/mm64; for instance the /proc handling).
+ *
+ * While for what is conversion dependant, we use the suffix _native and=
 _emul.
+ * In some cases, there is a mapping between these ones (defined by
+ * <asm/proc_mm.h>).
+ */
+
+/*These two are common to everything.*/
+static int open_proc_mm(struct inode *inode, struct file *file)
+{
+	struct mm_struct *mm =3D mm_alloc();
+	int ret;
+
+	ret =3D -ENOMEM;
+	if(mm =3D=3D NULL)
+		goto out_mem;
+
+	init_new_empty_context(mm);
+	arch_pick_mmap_layout(mm);
+#ifdef CONFIG_PROC_MM_DUMPABLE
+	mm->dumpable =3D current->mm->dumpable;
+	wmb();
+#endif
+
+	file->private_data =3D mm;
+
+	return 0;
+
+out_mem:
+	return ret;
+}
+
+static int release_proc_mm(struct inode *inode, struct file *file)
+{
+	struct mm_struct *mm =3D file->private_data;
+
+	mmput(mm);
+	return 0;
+}
+
+static struct file_operations proc_mm_fops;
+
+struct mm_struct *proc_mm_get_mm_native(int fd);
+
+static ssize_t write_proc_mm_native(struct file *file, const char *buffe=
r,
+			     size_t count, loff_t *ppos)
+{
+	struct mm_struct *mm =3D file->private_data;
+	struct proc_mm_op req;
+	int n, ret;
+
+	if(count > sizeof(req))
+		return(-EINVAL);
+
+	n =3D copy_from_user(&req, buffer, count);
+	if(n !=3D 0)
+		return(-EFAULT);
+
+	ret =3D count;
+	switch(req.op){
+	case MM_MMAP: {
+		struct mm_mmap *map =3D &req.u.mmap;
+
+		/* Nobody ever noticed it, but do_mmap_pgoff() calls
+		 * get_unmapped_area() which checks current->mm, if
+		 * MAP_FIXED is not set, so mmap() could replace
+		 * an old mapping.
+		 */
+		if (! (map->flags & MAP_FIXED))
+			return(-EINVAL);
+
+		ret =3D __do_mmap(mm, map->addr, map->len, map->prot,
+			       map->flags, map->fd, map->offset);
+		if((ret & ~PAGE_MASK) =3D=3D 0)
+			ret =3D count;
+
+		break;
+	}
+	case MM_MUNMAP: {
+		struct mm_munmap *unmap =3D &req.u.munmap;
+
+		down_write(&mm->mmap_sem);
+		ret =3D do_munmap(mm, unmap->addr, unmap->len);
+		up_write(&mm->mmap_sem);
+
+		if(ret =3D=3D 0)
+			ret =3D count;
+		break;
+	}
+	case MM_MPROTECT: {
+		struct mm_mprotect *protect =3D &req.u.mprotect;
+
+		ret =3D do_mprotect(mm, protect->addr, protect->len,
+				  protect->prot);
+		if(ret =3D=3D 0)
+			ret =3D count;
+		break;
+	}
+
+	case MM_COPY_SEGMENTS: {
+		struct mm_struct *from =3D proc_mm_get_mm_native(req.u.copy_segments);=

+
+		if(IS_ERR(from)){
+			ret =3D PTR_ERR(from);
+			break;
+		}
+
+		ret =3D copy_context(mm, from);
+		if(ret =3D=3D 0)
+			ret =3D count;
+		break;
+	}
+	default:
+		ret =3D -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+/*These three are all for /proc/mm.*/
+struct mm_struct *proc_mm_get_mm(int fd)
+{
+	struct mm_struct *ret =3D ERR_PTR(-EBADF);
+	struct file *file;
+
+	file =3D fget(fd);
+	if (!file)
+		goto out;
+
+	ret =3D ERR_PTR(-EINVAL);
+	if(PDE(file->f_path.dentry->d_inode)->proc_fops !=3D &proc_mm_fops)
+		goto out_fput;
+
+	ret =3D file->private_data;
+out_fput:
+	fput(file);
+out:
+	return(ret);
+}
+
+static struct file_operations proc_mm_fops =3D {
+	.open		=3D open_proc_mm,
+	.release	=3D release_proc_mm,
+	.write		=3D write_proc_mm,
+};
+
+/*Macro-ify it to avoid the duplication.*/
+static int make_proc_mm(void)
+{
+	struct proc_dir_entry *ent;
+
+	ent =3D create_proc_entry("mm", 0222, &proc_root);
+	if(ent =3D=3D NULL){
+		printk("make_proc_mm : Failed to register /proc/mm\n");
+		return(0);
+	}
+	ent->proc_fops =3D &proc_mm_fops;
+
+	return 0;
+}
+
+__initcall(make_proc_mm);
+
+/*XXX: change the option.*/
+#ifdef CONFIG_64BIT
+static struct file_operations proc_mm64_fops =3D {
+	.open		=3D open_proc_mm,
+	.release	=3D release_proc_mm,
+	.write		=3D write_proc_mm64,
+};
+
+static int make_proc_mm64(void)
+{
+	struct proc_dir_entry *ent;
+
+	ent =3D create_proc_entry("mm64", 0222, &proc_root);
+	if(ent =3D=3D NULL){
+		printk("make_proc_mm : Failed to register /proc/mm64\n");
+		return(0);
+	}
+	ent->proc_fops =3D &proc_mm64_fops;
+
+	return 0;
+}
+
+__initcall(make_proc_mm64);
+
+struct mm_struct *proc_mm_get_mm64(int fd)
+{
+	struct mm_struct *ret =3D ERR_PTR(-EBADF);
+	struct file *file;
+
+	file =3D fget(fd);
+	if (!file)
+		goto out;
+
+	ret =3D ERR_PTR(-EINVAL);
+	/*This is the only change.*/
+	if(file->f_op !=3D &proc_mm64_fops)
+		goto out_fput;
+
+	ret =3D file->private_data;
+out_fput:
+	fput(file);
+out:
+	return(ret);
+}
+#endif
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically=

+ * adjust the settings for this buffer only.  This must remain at the en=
d
+ * of the file.
+ * ---------------------------------------------------------------------=
------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
diff -ruN linux-2.6.24-rc7.orig/mm/proc_mm-mod.c linux-2.6.24-rc7/mm/proc=
_mm-mod.c
--- linux-2.6.24-rc7.orig/mm/proc_mm-mod.c	1969-12-31 16:00:00.000000000 =
-0800
+++ linux-2.6.24-rc7/mm/proc_mm-mod.c	2008-01-12 23:45:33.000000000 -0800=

@@ -0,0 +1,50 @@
+#include <linux/kernel.h>
+#include <linux/proc_mm.h>
+#include <linux/ptrace.h>
+#include <linux/module.h>
+
+#ifdef CONFIG_64BIT
+#define PRINT_OFFSET(type, member) \
+	printk(KERN_DEBUG "struct " #type "32->" #member " \t: %ld\n", (long) o=
ffsetof(struct type ## 32, member))
+#else
+#define PRINT_OFFSET(type, member) \
+	printk(KERN_DEBUG "struct " #type "->" #member " \t: %ld\n", (long) off=
setof(struct type, member))
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

--------------050803020801080000090209--

--------------enig1F993DE614A15D14A0FF33E5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHicd2KZYQqSA+yiURAtzEAJ9E+w0yZJmTmpTNOietz60MccesQACgjQg7
0Ar7ZeD3/By0SpujRB+XLZc=
=Wqxm
-----END PGP SIGNATURE-----

--------------enig1F993DE614A15D14A0FF33E5--


--===============1362675307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============1362675307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1362675307==--

