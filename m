Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BwUC0-0003cG-LZ for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 15 Aug 2004 16:13:36 -0700
Received: from mail.scgiservices.com ([198.107.3.67])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1BwUC0-0006Pr-76
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 15 Aug 2004 16:13:36 -0700
Received: from SCG2 (c-67-160-159-191.client.comcast.net [67.160.159.191])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail.scgiservices.com (Postfix) with ESMTP id 40BC32A3B2
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 15 Aug 2004 16:13:33 -0700 (PDT)
From: "Anthony Brock" <brocka@sterlingcgi.com>
Subject: RE: [uml-devel] SKAS on AMD 64-Bit
Message-ID: <LEEIJGBJEEABAGOFFGAHCEHMCBAA.brocka@sterlingcgi.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0021_01C482E2.CE4F74B0"
In-Reply-To: <LEEIJGBJEEABAGOFFGAHKEHLCBAA.brocka@sterlingcgi.com>
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
Date: Sun, 15 Aug 2004 16:13:30 -0700
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_0021_01C482E2.CE4F74B0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

It would probably help if I included the patch! :)

Tony


> -----Original Message-----
> From: user-mode-linux-devel-admin@lists.sourceforge.net
> [mailto:user-mode-linux-devel-admin@lists.sourceforge.net]On Behalf Of
> Anthony Brock
> Sent: Sunday, August 15, 2004 2:44 PM
> To: user-mode-linux-devel@lists.sourceforge.net
> Subject: RE: [uml-devel] SKAS on AMD 64-Bit
>
>
> Given a lack of responses to my inquiry, I've attempted to migrate the
> existing patches to the "arch/i386" and "include/asm-i386" directories to
> the corresponding "arch/x86_64" and "include/asm-x86_64" directories.
>
> However, I am experiencing the following issue during boot of a previously
> functional guest UML when I use the new Host Kernel:
>
> Checking for the skas3 patch in the host...found
> Checking for /proc/mm...found
> Linux version 2.6.7-1um (root@vs1) (gcc version 3.3.3 (SuSE Linux)) #2 Thu
> Jul 29 08:57:53 PDT 2004
> On node 0 totalpages: 122880
>   DMA zone: 122880 pages, LIFO batch:16
>   Normal zone: 0 pages, LIFO batch:1
>   HighMem zone: 0 pages, LIFO batch:1
> Built 1 zonelists
>
> *** OUTPUT TRIMMED ***
>
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Kernel panic: kernel BUG at mm/mmap.c:700!
>
>
> Any ideas? How would I generate a backtrace for this issue?
>
> I am attaching a copy of the non-functional patch. This patch applies
> against a vanilla 2.6.7 kernel with host-skas3-2.6.7-v1.patch pre-applied
> (in other words, it's a patch to the SKAS3 patch). Thanks in advance!
>
> Tony
>
>
>
> -------------------------------------------------------
> SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
> 100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
> Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
> http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>

------=_NextPart_000_0021_01C482E2.CE4F74B0
Content-Type: application/octet-stream; name="x86_64-host-skas3-2.6.7-v1.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="x86_64-host-skas3-2.6.7-v1.patch"

diff -ur arch/x86_64/Kconfig.skas arch/x86_64/Kconfig=0A=
--- arch/x86_64/Kconfig.skas	2004-06-15 22:19:44.000000000 -0700=0A=
+++ arch/x86_64/Kconfig	2004-08-06 14:29:12.447093965 -0700=0A=
@@ -249,6 +249,10 @@=0A=
 	  cost of slightly increased overhead in some places. If unsure say=0A=
 	  N here.=0A=
 =0A=
+config PROC_MM=0A=
+       bool "/proc/mm support"=0A=
+       default y=0A=
+=0A=
 config K8_NUMA=0A=
        bool "K8 NUMA support"=0A=
        depends on SMP=0A=
diff -ur arch/x86_64/kernel/ldt.c.skas arch/x86_64/kernel/ldt.c=0A=
--- arch/x86_64/kernel/ldt.c.skas	2004-06-15 22:20:03.000000000 -0700=0A=
+++ arch/x86_64/kernel/ldt.c	2004-08-06 14:25:55.828722076 -0700=0A=
@@ -58,7 +58,7 @@=0A=
 	wmb();=0A=
 	pc->size =3D mincount;=0A=
 	wmb();=0A=
-	if (reload) {=0A=
+	if (reload && (&current->active_mm->context =3D=3D pc)) {=0A=
 #ifdef CONFIG_SMP=0A=
 		cpumask_t mask;=0A=
 =0A=
@@ -94,14 +94,12 @@=0A=
  * we do not have to muck with descriptors here, that is=0A=
  * done in switch_mm() as needed.=0A=
  */=0A=
-int init_new_context(struct task_struct *tsk, struct mm_struct *mm)=0A=
+int __init_new_context(struct mm_struct *mm, struct mm_struct *old_mm)=0A=
 {=0A=
-	struct mm_struct * old_mm;=0A=
 	int retval =3D 0;=0A=
 =0A=
 	init_MUTEX(&mm->context.sem);=0A=
 	mm->context.size =3D 0;=0A=
-	old_mm =3D current->mm;=0A=
 	if (old_mm && old_mm->context.size > 0) {=0A=
 		down(&old_mm->context.sem);=0A=
 		retval =3D copy_ldt(&mm->context, &old_mm->context);=0A=
@@ -110,6 +108,11 @@=0A=
 	return retval;=0A=
 }=0A=
 =0A=
+int init_new_context(struct task_struct *tsk, struct mm_struct *mm)=0A=
+{=0A=
+	return __init_new_context(mm, current->mm);=0A=
+}=0A=
+=0A=
 /*=0A=
  * =0A=
  * Don't touch the LDT register - we're already in the next thread.=0A=
@@ -125,11 +128,11 @@=0A=
 	}=0A=
 }=0A=
 =0A=
-static int read_ldt(void __user * ptr, unsigned long bytecount)=0A=
+static int read_ldt(struct mm_struct * mm, void __user * ptr,=0A=
+		    unsigned long bytecount)=0A=
 {=0A=
 	int err;=0A=
 	unsigned long size;=0A=
-	struct mm_struct * mm =3D current->mm;=0A=
 =0A=
 	if (!mm->context.size)=0A=
 		return 0;=0A=
@@ -164,10 +167,9 @@=0A=
 	return bytecount; =0A=
 }=0A=
 =0A=
-static int write_ldt(void __user * ptr, unsigned long bytecount, int =
oldmode)=0A=
+static int write_ldt(struct mm_struct * mm, void __user * ptr,=0A=
+		     unsigned long bytecount, int oldmode)=0A=
 {=0A=
-	struct task_struct *me =3D current;=0A=
-	struct mm_struct * mm =3D me->mm;=0A=
 	__u32 entry_1, entry_2, *lp;=0A=
 	int error;=0A=
 	struct user_desc ldt_info;=0A=
@@ -192,7 +194,7 @@=0A=
 =0A=
 	down(&mm->context.sem);=0A=
 	if (ldt_info.entry_number >=3D (unsigned)mm->context.size) {=0A=
-		error =3D alloc_ldt(&current->mm->context, ldt_info.entry_number+1, =
1);=0A=
+		error =3D alloc_ldt(&mm->context, ldt_info.entry_number+1, 1);=0A=
 		if (error < 0)=0A=
 			goto out_unlock;=0A=
 	}=0A=
@@ -225,23 +227,29 @@=0A=
 	return error;=0A=
 }=0A=
 =0A=
-asmlinkage int sys_modify_ldt(int func, void __user *ptr, unsigned long =
bytecount)=0A=
+int modify_ldt(struct mm_struct * mm, int func, void __user *ptr,=0A=
+		   unsigned long bytecount)=0A=
 {=0A=
 	int ret =3D -ENOSYS;=0A=
 =0A=
 	switch (func) {=0A=
 	case 0:=0A=
-		ret =3D read_ldt(ptr, bytecount);=0A=
+		ret =3D read_ldt(mm, ptr, bytecount);=0A=
 		break;=0A=
 	case 1:=0A=
-		ret =3D write_ldt(ptr, bytecount, 1);=0A=
+		ret =3D write_ldt(mm, ptr, bytecount, 1);=0A=
 		break;=0A=
 	case 2:=0A=
 		ret =3D read_default_ldt(ptr, bytecount);=0A=
 		break;=0A=
 	case 0x11:=0A=
-		ret =3D write_ldt(ptr, bytecount, 0);=0A=
+		ret =3D write_ldt(mm, ptr, bytecount, 0);=0A=
 		break;=0A=
 	}=0A=
 	return ret;=0A=
 }=0A=
+=0A=
+asmlinkage int sys_modify_ldt(int func, void __user *ptr, unsigned long =
bytecount)=0A=
+{=0A=
+	return modify_ldt(current->mm, func, ptr, bytecount);=0A=
+}=0A=
diff -ur arch/x86_64/kernel/ptrace.c.skas arch/x86_64/kernel/ptrace.c=0A=
--- arch/x86_64/kernel/ptrace.c.skas	2004-06-15 22:19:09.000000000 -0700=0A=
+++ arch/x86_64/kernel/ptrace.c	2004-08-06 14:13:50.589224916 -0700=0A=
@@ -17,6 +17,7 @@=0A=
 #include <linux/user.h>=0A=
 #include <linux/security.h>=0A=
 #include <linux/audit.h>=0A=
+#include <linux/proc_mm.h>=0A=
 =0A=
 #include <asm/uaccess.h>=0A=
 #include <asm/pgtable.h>=0A=
@@ -477,6 +478,56 @@=0A=
 		break;=0A=
 	}=0A=
 =0A=
+#ifdef CONFIG_PROC_MM=0A=
+	case PTRACE_FAULTINFO: {=0A=
+		struct ptrace_faultinfo fault;=0A=
+=0A=
+		fault =3D ((struct ptrace_faultinfo)=0A=
+			{ .is_write	=3D child->thread.error_code,=0A=
+			  .addr		=3D child->thread.cr2 });=0A=
+		ret =3D copy_to_user((unsigned long *) data, &fault,=0A=
+				   sizeof(fault));=0A=
+		if(ret)=0A=
+			break;=0A=
+		break;=0A=
+	}=0A=
+=0A=
+	case PTRACE_SIGPENDING:=0A=
+		ret =3D copy_to_user((unsigned long *) data,=0A=
+				   &child->pending.signal,=0A=
+				   sizeof(child->pending.signal));=0A=
+		break;=0A=
+=0A=
+	case PTRACE_LDT: {=0A=
+		struct ptrace_ldt ldt;=0A=
+=0A=
+		if(copy_from_user(&ldt, (unsigned long *) data,=0A=
+				  sizeof(ldt))){=0A=
+			ret =3D -EIO;=0A=
+			break;=0A=
+		}=0A=
+		ret =3D modify_ldt(child->mm, ldt.func, ldt.ptr, ldt.bytecount);=0A=
+		break;=0A=
+	}=0A=
+=0A=
+	case PTRACE_SWITCH_MM: {=0A=
+		struct mm_struct *old =3D child->mm;=0A=
+		struct mm_struct *new =3D proc_mm_get_mm(data);=0A=
+=0A=
+		if(IS_ERR(new)){=0A=
+			ret =3D PTR_ERR(new);=0A=
+			break;=0A=
+		}=0A=
+=0A=
+		atomic_inc(&new->mm_users);=0A=
+		child->mm =3D new;=0A=
+		child->active_mm =3D new;=0A=
+		mmput(old);=0A=
+		ret =3D 0;=0A=
+		break;=0A=
+	}=0A=
+#endif=0A=
+=0A=
 	default:=0A=
 		ret =3D ptrace_request(child, request, addr, data);=0A=
 		break;=0A=
diff -ur arch/x86_64/kernel/sys_x86_64.c.skas =
arch/x86_64/kernel/sys_x86_64.c=0A=
--- arch/x86_64/kernel/sys_x86_64.c.skas	2004-06-15 22:19:37.000000000 =
-0700=0A=
+++ arch/x86_64/kernel/sys_x86_64.c	2004-08-06 13:51:08.308766765 -0700=0A=
@@ -38,7 +38,9 @@=0A=
 	return error;=0A=
 }=0A=
 =0A=
-long sys_mmap(unsigned long addr, unsigned long len, unsigned long =
prot, unsigned long flags,=0A=
+long do_mmap2(struct mm_struct *mm,=0A=
+	unsigned long addr, unsigned long len,=0A=
+	unsigned long prot, unsigned long flags,=0A=
 	unsigned long fd, unsigned long off)=0A=
 {=0A=
 	long error;=0A=
@@ -56,9 +58,9 @@=0A=
 		if (!file)=0A=
 			goto out;=0A=
 	}=0A=
-	down_write(&current->mm->mmap_sem);=0A=
-	error =3D do_mmap_pgoff(file, addr, len, prot, flags, off >> =
PAGE_SHIFT);=0A=
-	up_write(&current->mm->mmap_sem);=0A=
+	down_write(&mm->mmap_sem);=0A=
+	error =3D __do_mmap_pgoff(mm, file, addr, len, prot, flags, off >> =
PAGE_SHIFT);=0A=
+	up_write(&mm->mmap_sem);=0A=
 =0A=
 	if (file)=0A=
 		fput(file);=0A=
@@ -66,6 +68,12 @@=0A=
 	return error;=0A=
 }=0A=
 =0A=
+long sys_mmap(unsigned long addr, unsigned long len, unsigned long =
prot, unsigned long flags,=0A=
+	unsigned long fd, unsigned long off)=0A=
+{=0A=
+	return do_mmap2(current->mm, addr, len, prot, flags, fd, off);=0A=
+}=0A=
+=0A=
 static void find_start_end(unsigned long flags, unsigned long *begin,=0A=
 			   unsigned long *end)=0A=
 {=0A=
diff -ur include/asm-x86_64/desc.h.skas include/asm-x86_64/desc.h=0A=
--- include/asm-x86_64/desc.h.skas	2004-06-15 22:20:26.000000000 -0700=0A=
+++ include/asm-x86_64/desc.h	2004-08-06 14:32:39.968349277 -0700=0A=
@@ -210,6 +210,9 @@=0A=
 	put_cpu();=0A=
 }=0A=
 =0A=
+extern int modify_ldt(struct mm_struct * mm, int func, void __user *ptr,=0A=
+		      unsigned long bytecount);=0A=
+=0A=
 #endif /* !__ASSEMBLY__ */=0A=
 =0A=
 #endif=0A=
diff -ur include/asm-x86_64/processor.h.skas =
include/asm-x86_64/processor.h=0A=
--- include/asm-x86_64/processor.h.skas	2004-06-15 22:20:18.000000000 =
-0700=0A=
+++ include/asm-x86_64/processor.h	2004-08-06 14:34:56.998875865 -0700=0A=
@@ -454,6 +454,8 @@=0A=
 	ti->task;					\=0A=
 })=0A=
 =0A=
+extern int __init_new_context(struct mm_struct *mm, struct mm_struct =
*old_mm);=0A=
+=0A=
 #define cache_line_size() (boot_cpu_data.x86_cache_alignment)=0A=
 =0A=
 #ifdef CONFIG_SCHED_SMT=0A=
diff -ur include/asm-x86_64/ptrace.h.skas include/asm-x86_64/ptrace.h=0A=
--- include/asm-x86_64/ptrace.h.skas	2004-06-15 22:19:03.000000000 -0700=0A=
+++ include/asm-x86_64/ptrace.h	2004-08-06 14:38:35.353933414 -0700=0A=
@@ -110,4 +110,26 @@=0A=
 =0A=
 #endif=0A=
 =0A=
+/*For SKAS3 support.*/=0A=
+#ifndef _LINUX_PTRACE_STRUCT_DEF=0A=
+#define _LINUX_PTRACE_STRUCT_DEF=0A=
+=0A=
+#define PTRACE_FAULTINFO	52=0A=
+#define PTRACE_SIGPENDING	53=0A=
+#define PTRACE_LDT		54=0A=
+#define PTRACE_SWITCH_MM	55=0A=
+=0A=
+struct ptrace_faultinfo {=0A=
+	int is_write;=0A=
+	unsigned long addr;=0A=
+};=0A=
+=0A=
+struct ptrace_ldt {=0A=
+	int func;=0A=
+	void *ptr;=0A=
+	unsigned long bytecount;=0A=
+};=0A=
+=0A=
+#endif /*ifndef _LINUX_PTRACE_STRUCT_DEF*/=0A=
+=0A=
 #endif=0A=

------=_NextPart_000_0021_01C482E2.CE4F74B0--



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
