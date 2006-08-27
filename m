Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GHPF1-0004bn-Oy for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Aug 2006 11:20:15 -0700
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GHPEx-0003Ac-1p
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Aug 2006 11:20:15 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sun, 27 Aug 2006 20:19:53 +0200
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_KJe8E7t/aQTX+mQ"
Message-Id: <200608272019.54677.blaisorblade@yahoo.it>
Subject: [uml-devel] UML remap_file_pages usage
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net
Cc: Ingo Molnar <mingo@redhat.com>

--Boundary-00=_KJe8E7t/aQTX+mQ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

First, now there is (or should be, when I upload all updates) 
http://www.user-mode-linux.org/~blaisorblade/fremap.html.

It is not especially beautiful but it collects something.

I've been working at finishing and polishing remap_file_pages support from 
the "host kernel" side, as you might have seen from the patchset I just sent.

That's likely finished IMHO, so I was looking at the Uml side of the support - 
I had ported Ingo's patch (which is conceptually easy) to 2.6.13 (there had 
been a rewrite), but it didn't work and you rewrote the code in 2.6.14, so I 
left it away till now.

And as I discovered after looking at it, it was _very_ old (it still used the 
original API and not the 2nd, improved, one).

I'm confident about this patch, since I found a stupid typo in the code I 
previously tested; I fixed it and then ported it to UML/2.6.18-rc4.

However, I'm currently unable to do any testing, so I'm sending the patch to 
you for this.

Apply the patchset to the host kernel (it supports i386, x86_64 and UML), 
apply this patch to a UML kernel and run it in SKAS0 mode.

I've also got an (untested but simple) extension to SKAS3 mode (supported in 
the below patch). The host support is at my homepage.

To make it clear, this patch must just replace any mmap()/munmap()/mprotect() 
call (and I think there's no mremap() call, but it could support that as 
well) with calls to remap_file_pages() with appropriate protections and 
offsets.

An initial call to mmap() with PROT_NONE protection must be done, obviously. 
There's not much beyond this; the only problem is to write a boot test for 
this function (remap_file_pages() syscall always exists).

If you believe you find a bug in the host support, try to reproduce it with 
the testprogram I attached to the patchset.

But note it has yet no tests for PTRACE_POKETEXT interaction with R_F_P (IIRC 
Uml does not use it).

That's because I run a custom kernel on my Ubuntu system - there is probably 
some udev problem and trying to ignore the need for a initrd does not help 
(the existance of udev seem to make the initrd essential). I must still 
verify where the error lies.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade


--Boundary-00=_KJe8E7t/aQTX+mQ
Content-Type: text/x-diff; charset="us-ascii"; name="uml-fremap-usage.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-fremap-usage.patch"


From: Ingo Molnar <mingo@redhat.com>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

TODO:
- range optimization: should be already done here by Jeff.
- implement a real startup check.
- study the first_flush optimization.
- cleanup the code
- study a workaround for physmem_fd, if needed.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.git/arch/um/os-Linux/skas/mem.c
===================================================================
--- linux-2.6.git.orig/arch/um/os-Linux/skas/mem.c
+++ linux-2.6.git/arch/um/os-Linux/skas/mem.c
@@ -172,6 +172,41 @@ long syscall_stub_data(struct mm_id * mm
 	return 0;
 }
 
+#ifndef MAP_CHGPROT
+#define MAP_CHGPROT 0x20000
+#endif
+
+int remap(struct mm_id *mm_idp, unsigned long virt, unsigned long phys,
+		unsigned long len, int prot, int done, void **data)
+{
+	int ret;
+
+	if (proc_mm) {
+		struct proc_mm_op remap;
+		int fd = mm_idp->u.mm_fd;
+		remap = ((struct proc_mm_op)
+			{ .op 	= MM_REMAP_FILE_PAGES,
+				     .u 	=
+				     { .fremap	=
+				       { .start		= virt,
+					 .size		= len,
+					 .prot		= prot,
+					 .flags		= MAP_CHGPROT,
+					 .pgoff		= MMAP_OFFSET(phys)
+			} } } );
+		ret = os_write_file(fd, &remap, sizeof(remap));
+		if (ret != sizeof(remap))
+			panic("remap : /proc/mm remap failed, errno = %d\n", -ret);
+	} else {
+                unsigned long args[] = { virt, len, prot,
+                                         0, MMAP_OFFSET(phys) };
+
+                ret = run_syscall_stub(mm_idp, __NR_remap_file_pages, args,
+				MAP_CHGPROT, data, done);
+        }
+	return ret;
+}
+
 int map(struct mm_id * mm_idp, unsigned long virt, unsigned long len,
 	int r, int w, int x, int phys_fd, unsigned long long offset,
 	int done, void **data)
@@ -198,7 +233,7 @@ int map(struct mm_id * mm_idp, unsigned 
 					 } } } );
 		ret = os_write_file(fd, &map, sizeof(map));
 		if(ret != sizeof(map))
-			printk("map : /proc/mm map failed, err = %d\n", -ret);
+			panic("map : /proc/mm map failed, err = %d\n", -ret);
 		else ret = 0;
 	}
 	else {
@@ -218,6 +253,9 @@ int unmap(struct mm_id * mm_idp, void *a
 {
 	int ret;
 
+	if (mode_fremap)
+		panic("unmap() in fremap mode?");
+
 	if(proc_mm){
 		struct proc_mm_op unmap;
 		int fd = mm_idp->u.mm_fd;
@@ -230,7 +268,7 @@ int unmap(struct mm_id * mm_idp, void *a
 					     .len		= len } } } );
 		ret = os_write_file(fd, &unmap, sizeof(unmap));
 		if(ret != sizeof(unmap))
-			printk("unmap - proc_mm write returned %d\n", ret);
+			panic("unmap : /proc/mm write failed, errno = %d\n", -ret);
 		else ret = 0;
 	}
 	else {
@@ -250,6 +288,9 @@ int protect(struct mm_id * mm_idp, unsig
 	struct proc_mm_op protect;
 	int prot, ret;
 
+	if (mode_fremap)
+		panic("protect() in fremap mode?");
+
 	prot = (r ? PROT_READ : 0) | (w ? PROT_WRITE : 0) |
 		(x ? PROT_EXEC : 0);
 	if(proc_mm){
@@ -265,7 +306,7 @@ int protect(struct mm_id * mm_idp, unsig
 
 		ret = os_write_file(fd, &protect, sizeof(protect));
 		if(ret != sizeof(protect))
-			printk("protect failed, err = %d", -ret);
+			panic("protect : /proc/mm protect failed, errno = %d\n", -ret);
 		else ret = 0;
 	}
 	else {
Index: linux-2.6.git/arch/um/Kconfig
===================================================================
--- linux-2.6.git.orig/arch/um/Kconfig
+++ linux-2.6.git/arch/um/Kconfig
@@ -90,6 +90,19 @@ config LD_SCRIPT_DYN
 	default y
 	depends on !LD_SCRIPT_STATIC
 
+config MODE_FREMAP
+	bool "Host Remap File Pages support"
+	default y
+	depends on MODE_SKAS
+	help
+	This option controls whether virtual RAM is mapped via a new
+	host kernel syscall, called sys_remap_file_pages. Compiled in,
+	this feature auto-detects the availability of fremap in the host
+	kernel.
+	If you have applied the fremap patch to the host, then you certainly
+	want to say Y here.  Otherwise, it is safe to say Y.  Disabling this
+	option will shrink the UML binary slightly.
+
 config NET
 	bool "Networking support"
 	help
Index: linux-2.6.git/arch/um/include/user_util.h
===================================================================
--- linux-2.6.git.orig/arch/um/include/user_util.h
+++ linux-2.6.git/arch/um/include/user_util.h
@@ -14,6 +14,7 @@
 #define CATCH_EINTR(expr) while ((errno = 0, ((expr) < 0)) && (errno == EINTR))
 
 extern int mode_tt;
+extern int mode_fremap;
 
 extern int grantpt(int __fd);
 extern int unlockpt(int __fd);
Index: linux-2.6.git/arch/um/include/os.h
===================================================================
--- linux-2.6.git.orig/arch/um/include/os.h
+++ linux-2.6.git/arch/um/include/os.h
@@ -172,6 +172,7 @@ extern int os_fchange_dir(int fd);
 /* start_up.c */
 extern void os_early_checks(void);
 extern int can_do_skas(void);
+extern int can_do_fremap(void);
 extern void os_check_bugs(void);
 extern void check_host_supports_tls(int *supports_tls, int *tls_min);
 
@@ -289,6 +290,8 @@ extern long run_syscall_stub(struct mm_i
 extern long syscall_stub_data(struct mm_id * mm_idp,
 			      unsigned long *data, int data_count,
 			      void **addr, void **stub_addr);
+extern int remap(struct mm_id *mm_idp, unsigned long virt, unsigned long phys,
+		unsigned long len, int prot, int done, void **data);
 extern int map(struct mm_id * mm_idp, unsigned long virt,
 	       unsigned long len, int r, int w, int x, int phys_fd,
 	       unsigned long long offset, int done, void **data);
Index: linux-2.6.git/arch/um/os-Linux/start_up.c
===================================================================
--- linux-2.6.git.orig/arch/um/os-Linux/start_up.c
+++ linux-2.6.git/arch/um/os-Linux/start_up.c
@@ -428,6 +428,38 @@ static inline void check_skas3_proc_mm(v
 	}
 }
 
+#define MAP_NOINHERIT 0x20000
+
+#define __NR_remap_file_pages	257
+_syscall5(int, remap_file_pages, void*, start, unsigned int, len,
+        int, prot, unsigned int, pgoff, int, flags);
+/*
+#define __NR_new_remap_file_pages 274
+_syscall5(int, new_remap_file_pages, unsigned long, start, unsigned long, len,
+        unsigned long, prot, unsigned long, pgoff, int, flags);
+*/
+
+//FIXME: must write a proper test.
+int can_do_fremap(void)
+{
+#ifdef UML_CONFIG_MODE_FREMAP
+	int err;
+
+	printf("Checking for proper fremap support in the host... ");
+	err = remap_file_pages((void*) -1, -1, -1, -1, -1);
+	if (err == -1 && errno == EINVAL) {
+		printf("found.\n");
+		return 1;
+	}
+
+	printf("not found.\n");
+	return 0;
+#else
+	return 0;
+#endif
+}
+
+
 int can_do_skas(void)
 {
 	printf("Checking for the skas3 patch in the host:\n");
Index: linux-2.6.git/arch/um/include/skas/proc_mm.h
===================================================================
--- linux-2.6.git.orig/arch/um/include/skas/proc_mm.h
+++ linux-2.6.git/arch/um/include/skas/proc_mm.h
@@ -10,6 +10,15 @@
 #define MM_MUNMAP 55
 #define MM_MPROTECT 56
 #define MM_COPY_SEGMENTS 57
+#define MM_REMAP_FILE_PAGES 58
+
+struct mm_remap_file_pages {
+	unsigned long start;
+	unsigned long size;
+	unsigned long prot;
+	unsigned long pgoff;
+	unsigned long flags;
+};
 
 struct mm_mmap {
 	unsigned long addr;
@@ -37,6 +46,7 @@ struct proc_mm_op {
 		struct mm_mmap mmap;
 		struct mm_munmap munmap;
 	        struct mm_mprotect mprotect;
+		struct mm_remap_file_pages fremap;
 		int copy_segments;
 	} u;
 };
Index: linux-2.6.git/arch/um/kernel/skas/mmu.c
===================================================================
--- linux-2.6.git.orig/arch/um/kernel/skas/mmu.c
+++ linux-2.6.git/arch/um/kernel/skas/mmu.c
@@ -16,8 +16,10 @@
 #include "asm/pgalloc.h"
 #include "asm/pgtable.h"
 #include "asm/ldt.h"
+#include "user_util.h"
 #include "os.h"
 #include "skas.h"
+#include "mem.h"
 
 extern int __syscall_stub_start;
 
@@ -79,6 +81,8 @@ int init_new_context_skas(struct task_st
 	struct mmu_context_skas *to_mm = &mm->context.skas;
 	unsigned long stack = 0;
 	int ret = -ENOMEM;
+	/* XXX: rename*/
+	void *flush = NULL;
 
 	if(skas_needs_stub){
 		stack = get_zeroed_page(GFP_KERNEL);
@@ -122,6 +126,15 @@ int init_new_context_skas(struct task_st
 							     from_mm->id.u.pid);
 		else to_mm->id.u.pid = start_userspace(stack);
 	}
+	/*
+	 * An initial mmap() is needed to allow subsequent fremap()s:
+	 */
+	if (mode_fremap) {
+		__u64 off_out;
+		int fd = phys_mapping(0, &off_out);
+		map(&mm->context.skas.id, 0, TASK_SIZE, 0, 0, 0, fd, 0, 1, &flush);
+	}
+	mm->context.skas.first_flush = 1;
 
 	ret = init_new_ldt(to_mm, from_mm);
 	if(ret < 0){
Index: linux-2.6.git/arch/um/include/skas/mmu-skas.h
===================================================================
--- linux-2.6.git.orig/arch/um/include/skas/mmu-skas.h
+++ linux-2.6.git/arch/um/include/skas/mmu-skas.h
@@ -17,6 +17,7 @@ struct mmu_context_skas {
 	unsigned long last_pmd;
 #endif
 	uml_ldt_t ldt;
+	int first_flush;
 };
 
 extern void switch_mm_skas(struct mm_id * mm_idp);
Index: linux-2.6.git/arch/um/kernel/skas/tlb.c
===================================================================
--- linux-2.6.git.orig/arch/um/kernel/skas/tlb.c
+++ linux-2.6.git/arch/um/kernel/skas/tlb.c
@@ -18,11 +18,18 @@
 #include "os.h"
 #include "tlb.h"
 
+static int do_ops_fremap(union mm_context *mmu, struct host_vm_op *ops,
+		int last, int finished, void **flush);
+
 static int do_ops(union mm_context *mmu, struct host_vm_op *ops, int last,
 		  int finished, void **flush)
 {
 	struct host_vm_op *op;
-        int i, ret = 0;
+        int i, ret = -EINVAL;
+
+	if (mode_fremap) {
+		return do_ops_fremap(mmu, ops, last, finished, flush);
+	}
 
         for(i = 0; i <= last && !ret; i++){
 		op = &ops[i];
@@ -53,6 +60,55 @@ static int do_ops(union mm_context *mmu,
 	return ret;
 }
 
+#define PROT_NONE 0x0
+#define PROT_READ 0x1
+#define PROT_WRITE 0x2
+#define PROT_EXEC 0x4
+
+#define PROTS(r, w, x) ((r ? PROT_READ : 0) | (w ? PROT_WRITE : 0) | \
+		(x ? PROT_EXEC : 0))
+
+#define PROTS_OP(op) PROTS(op.r, op.w, op.x)
+
+static int do_ops_fremap(union mm_context *mmu, struct host_vm_op *ops,
+		int last, int finished, void **flush)
+{
+	struct host_vm_op *op;
+	int i, ret = -EINVAL;
+
+	for(i = 0; i <= last; i++){
+		unsigned long long off_out;
+		int physmem_fd = phys_mapping(0, &off_out);
+
+		op = &ops[i];
+		switch(op->type){
+		case MMAP:
+			if (op->u.mmap.fd != physmem_fd)
+				panic("do_ops_fremap: not implemented!\n");
+                        ret = remap(&mmu->skas.id, op->u.mmap.addr, op->u.mmap.offset,
+				op->u.mmap.len, PROTS_OP(op->u.mmap),
+				finished, flush);
+			/*
+                        remap(&mmu->skas.id, op->u.mmap.addr, op->u.mmap.len,
+			    op->u.mmap.r, op->u.mmap.w, op->u.mmap.x,
+			    op->u.mmap.fd, op->u.mmap.offset);*/
+			break;
+		case MUNMAP:
+                        ret = remap(&mmu->skas.id, op->u.munmap.addr, 0,
+			      op->u.munmap.len, PROT_NONE, finished, flush);
+			break;
+		case MPROTECT:
+                        ret = remap(&mmu->skas.id, op->u.mprotect.addr, op->u.mmap.offset,
+				op->u.mprotect.len, PROTS_OP(op->u.mprotect),
+				finished, flush);
+			break;
+		default:
+			printk("Unknown op type %d in do_ops\n", op->type);
+			break;
+		}
+	}
+	return ret;
+}
 extern int proc_mm;
 
 static void fix_range(struct mm_struct *mm, unsigned long start_addr,
Index: linux-2.6.git/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6.git.orig/arch/um/kernel/um_arch.c
+++ linux-2.6.git/arch/um/kernel/um_arch.c
@@ -273,6 +273,20 @@ __uml_setup("mode=tt", mode_tt_setup,
 );
 
 int mode_tt = DEFAULT_TT;
+int mode_fremap = 0;
+int force_mmap = 0;
+
+static int __init mode_mmap_setup(char *line, int *add)
+{
+	force_mmap = 1;
+	return 0;
+}
+
+__uml_setup("mode=mmap", mode_mmap_setup,
+"mode=mmap\n"
+"    When CONFIG_MODE_FREMAP is enabled, this option forces UML to use\n"
+"    the mmap mapping method.\n\n"
+);
 
 static int __init Usage(char *line, int *add)
 {
@@ -362,6 +376,9 @@ int linux_main(int argc, char **argv)
 	}
 #endif
 
+	if (!mode_tt && !force_mmap)
+		mode_fremap = can_do_fremap();
+
 #ifndef CONFIG_MODE_SKAS
 	mode = "TT";
 #else
@@ -373,7 +390,6 @@ int linux_main(int argc, char **argv)
 	else
 		mode = "SKAS0";
 #endif
-
 	printf("UML running in %s mode\n", mode);
 
 	uml_start = (unsigned long) &__binary_start;
Index: linux-2.6.git/arch/um/kernel/tlb.c
===================================================================
--- linux-2.6.git.orig/arch/um/kernel/tlb.c
+++ linux-2.6.git/arch/um/kernel/tlb.c
@@ -139,8 +139,19 @@ void fix_range_common(struct mm_struct *
         void *flush = NULL;
         int op_index = -1, last_op = sizeof(ops) / sizeof(ops[0]) - 1;
         int ret = 0;
+	int first_flush;
 
-        if(mm == NULL) return;
+        if (mm == NULL) return;
+
+	if (mode_fremap) {
+		/* Can we assume the area is already unmapped? */
+		first_flush = mm->context.skas.first_flush;
+	} else
+		/* Probably this assumption would be valid here too, but I'm not
+		 * going to do it for now. */
+		first_flush = 0;
+
+	mm->context.skas.first_flush = 0;
 
         ops[0].type = NONE;
         for(addr = start_addr; addr < end_addr && !ret;){
@@ -150,9 +161,10 @@ void fix_range_common(struct mm_struct *
                         if(end > end_addr)
                                 end = end_addr;
                         if(force || pgd_newpage(*npgd)){
-                                ret = add_munmap(addr, end - addr, ops,
-                                                 &op_index, last_op, mmu,
-                                                 &flush, do_ops);
+				if (!first_flush)
+					ret = add_munmap(addr, end - addr, ops,
+							 &op_index, last_op, mmu,
+							 &flush, do_ops);
                                 pgd_mkuptodate(*npgd);
                         }
                         addr = end;
@@ -165,9 +177,10 @@ void fix_range_common(struct mm_struct *
                         if(end > end_addr)
                                 end = end_addr;
                         if(force || pud_newpage(*npud)){
-                                ret = add_munmap(addr, end - addr, ops,
-                                                 &op_index, last_op, mmu,
-                                                 &flush, do_ops);
+				if (!first_flush)
+					ret = add_munmap(addr, end - addr, ops,
+							 &op_index, last_op, mmu,
+							 &flush, do_ops);
                                 pud_mkuptodate(*npud);
                         }
                         addr = end;
@@ -180,9 +193,10 @@ void fix_range_common(struct mm_struct *
                         if(end > end_addr)
                                 end = end_addr;
                         if(force || pmd_newpage(*npmd)){
-                                ret = add_munmap(addr, end - addr, ops,
-                                                 &op_index, last_op, mmu,
-                                                 &flush, do_ops);
+				if (!first_flush)
+					ret = add_munmap(addr, end - addr, ops,
+							 &op_index, last_op, mmu,
+							 &flush, do_ops);
                                 pmd_mkuptodate(*npmd);
                         }
                         addr = end;
@@ -201,12 +215,13 @@ void fix_range_common(struct mm_struct *
 		}
                 if(force || pte_newpage(*npte)){
                         if(pte_present(*npte))
-			  ret = add_mmap(addr,
+				ret = add_mmap(addr,
 					 pte_val(*npte) & PAGE_MASK,
 					 PAGE_SIZE, r, w, x, ops,
 					 &op_index, last_op, mmu,
 					 &flush, do_ops);
-			else ret = add_munmap(addr, PAGE_SIZE, ops,
+			else if (!first_flush)
+				ret = add_munmap(addr, PAGE_SIZE, ops,
 					      &op_index, last_op, mmu,
 					      &flush, do_ops);
                 }

--Boundary-00=_KJe8E7t/aQTX+mQ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--Boundary-00=_KJe8E7t/aQTX+mQ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--Boundary-00=_KJe8E7t/aQTX+mQ--
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 

