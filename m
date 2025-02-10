Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63B9C0219E
	for <linux-um@archiver.kernel.org>; Mon, 10 Feb 2025 16:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pyemu5RgLgXyo+Kw4NE2aqsevitUB2cTl0J7g7IyFaw=; b=pEeAEWNE0XZxknJIRJ98ji1h59
	zWv7dsGTC/jnbUXYhy7rk1XWqgi2oVHEbTBbKbrpjPSpOb95eP1h5DdHKv8EFtOzmGQ5HEDItOF03
	m5uUfUeQQaNzO8xdKZeSwq0PbFUSmWS0GRsI+BIEQs8nocofX3JHjDLPjb3+2pFxVHyQyW2HXwKvv
	HgZfXDJcSoKGDnQN+DskLG5E4nRnkwtb40jM1J6oM4YilaKn80BCEeHQSF+LlvNX8jdi4kYSbAvkE
	Kta86AipKY/0k5dHV6yo6ewmgO9U/WWbL0N8z7h9Zhqnr0M78mY/UmYlKgVxnkHSz5V9UByNOboJi
	z6p4/FIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thWMf-00000000RiW-1MSs;
	Mon, 10 Feb 2025 16:10:29 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thWLw-00000000Ra8-1CNK
	for linux-um@lists.infradead.org;
	Mon, 10 Feb 2025 16:09:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Pyemu5RgLgXyo+Kw4NE2aqsevitUB2cTl0J7g7IyFaw=;
	t=1739203782; x=1740413382; b=CvBeMGsMt4uo/A6rzY9TV3sSGXO69mL9EHliaImm6dLeILr
	/w4qG9y1SCvayce96UTTG1tlxerYrYg6Jb1n5rirSjKoV8LtYi4aiY3ZaLWjkH/CGqrLpiNpP2LiL
	E8aeufR350LJKYtZEmxqAIRDZ/5f8nYkKphSdy5fjV6zQBPDvo1xHMkIG1JmjCoNj4ZIuW6Imt13f
	MK1D7UBI0FzmsQizD6TeZQ7Uq6GvyESwTs5LnMhS2yHLFCeXWsslfz2tshU2gfxbI+S6i2WqGDOtw
	yBLuDb61aghD4eg6zzOHU+iMnmvczYduQHpHvxbPkLyHwxO9mecH+Zeg++CemC2g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1thWLr-00000009rY9-448K;
	Mon, 10 Feb 2025 17:09:40 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 1/2] um: mark rodata read-only and implement _nofault accesses
Date: Mon, 10 Feb 2025 17:09:25 +0100
Message-ID: <20250210160926.420133-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210160926.420133-1-benjamin@sipsolutions.net>
References: <20250210160926.420133-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250210_080944_630657_C43D7EAD 
X-CRM114-Status: GOOD (  28.84  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Johannes Berg <johannes.berg@intel.com>

Mark read-only data actually read-only (simple mprotect), and
to be able to test it also implement _nofault accesses. This
works by setting up a new "segv_continue" pointer in current,
and then when we hit a segfault we change the signal return
context so that we continue at that address. The code using
this sets it up so that it jumps to a label and then aborts
the access that way, returning -EFAULT.

It's possible to optimize the ___backtrack_faulted() thing by
using asm goto (compiler version dependent) and/or gcc's (not
sure if clang has it) &&label extension, but at least in one
attempt I made the && caused the compiler to not load -EFAULT
into the register in case of jumping to the &&label from the
fault handler. So leave it like this for now.

Co-developed-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/Kconfig                          |  1 +
 arch/um/include/asm/processor-generic.h  |  2 ++
 arch/um/include/asm/uaccess.h            | 20 ++++++++++++-----
 arch/um/include/shared/arch.h            |  2 ++
 arch/um/include/shared/as-layout.h       |  2 +-
 arch/um/include/shared/irq_user.h        |  3 ++-
 arch/um/include/shared/kern_util.h       | 12 ++++++----
 arch/um/kernel/irq.c                     |  3 ++-
 arch/um/kernel/mem.c                     | 10 +++++++++
 arch/um/kernel/trap.c                    | 28 +++++++++++++++++++-----
 arch/um/os-Linux/signal.c                |  4 ++--
 arch/um/os-Linux/skas/process.c          |  8 +++----
 arch/x86/um/os-Linux/mcontext.c          | 12 ++++++++++
 arch/x86/um/shared/sysdep/faultinfo_32.h | 12 ++++++++++
 arch/x86/um/shared/sysdep/faultinfo_64.h | 12 ++++++++++
 15 files changed, 108 insertions(+), 23 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 18051b1cfce0..79509c7f39de 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -12,6 +12,7 @@ config UML
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_STRNCPY_FROM_USER
 	select ARCH_HAS_STRNLEN_USER
+	select ARCH_HAS_STRICT_KERNEL_RWX
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_KASAN if X86_64
 	select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
index 5d6356eafffe..8a789c17acd8 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -31,6 +31,8 @@ struct thread_struct {
 		} thread;
 	} request;
 
+	void *segv_continue;
+
 	/* Contains variable sized FP registers */
 	struct pt_regs regs;
 };
diff --git a/arch/um/include/asm/uaccess.h b/arch/um/include/asm/uaccess.h
index 1d4b6bbc1b65..3a08f9029a3f 100644
--- a/arch/um/include/asm/uaccess.h
+++ b/arch/um/include/asm/uaccess.h
@@ -9,6 +9,7 @@
 
 #include <asm/elf.h>
 #include <linux/unaligned.h>
+#include <sysdep/faultinfo.h>
 
 #define __under_task_size(addr, size) \
 	(((unsigned long) (addr) < TASK_SIZE) && \
@@ -44,19 +45,28 @@ static inline int __access_ok(const void __user *ptr, unsigned long size)
 		 __access_ok_vsyscall(addr, size));
 }
 
-/* no pagefaults for kernel addresses in um */
 #define __get_kernel_nofault(dst, src, type, err_label)			\
 do {									\
-	*((type *)dst) = get_unaligned((type *)(src));			\
-	if (0) /* make sure the label looks used to the compiler */	\
+	int __faulted;							\
+									\
+	___backtrack_faulted(__faulted);				\
+	if (__faulted) {						\
+		*((type *)dst) = (type) 0;				\
 		goto err_label;						\
+	}								\
+	*((type *)dst) = get_unaligned((type *)(src));			\
+	current->thread.segv_continue = NULL;				\
 } while (0)
 
 #define __put_kernel_nofault(dst, src, type, err_label)			\
 do {									\
-	put_unaligned(*((type *)src), (type *)(dst));			\
-	if (0) /* make sure the label looks used to the compiler */	\
+	int __faulted;							\
+									\
+	___backtrack_faulted(__faulted);				\
+	if (__faulted)							\
 		goto err_label;						\
+	put_unaligned(*((type *)src), (type *)(dst));			\
+	current->thread.segv_continue = NULL;				\
 } while (0)
 
 #endif
diff --git a/arch/um/include/shared/arch.h b/arch/um/include/shared/arch.h
index 880ee42a3329..cc398a21ad96 100644
--- a/arch/um/include/shared/arch.h
+++ b/arch/um/include/shared/arch.h
@@ -12,4 +12,6 @@ extern void arch_check_bugs(void);
 extern int arch_fixup(unsigned long address, struct uml_pt_regs *regs);
 extern void arch_examine_signal(int sig, struct uml_pt_regs *regs);
 
+void mc_set_rip(void *_mc, void *target);
+
 #endif
diff --git a/arch/um/include/shared/as-layout.h b/arch/um/include/shared/as-layout.h
index ea65f151bf48..4f44dcce8a7c 100644
--- a/arch/um/include/shared/as-layout.h
+++ b/arch/um/include/shared/as-layout.h
@@ -50,7 +50,7 @@ extern int linux_main(int argc, char **argv, char **envp);
 extern void uml_finishsetup(void);
 
 struct siginfo;
-extern void (*sig_info[])(int, struct siginfo *si, struct uml_pt_regs *);
+extern void (*sig_info[])(int, struct siginfo *si, struct uml_pt_regs *, void *);
 
 #endif
 
diff --git a/arch/um/include/shared/irq_user.h b/arch/um/include/shared/irq_user.h
index da0f6eea30d0..88835b52ae2b 100644
--- a/arch/um/include/shared/irq_user.h
+++ b/arch/um/include/shared/irq_user.h
@@ -15,7 +15,8 @@ enum um_irq_type {
 };
 
 struct siginfo;
-extern void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs);
+extern void sigio_handler(int sig, struct siginfo *unused_si,
+			  struct uml_pt_regs *regs, void *mc);
 void sigio_run_timetravel_handlers(void);
 extern void free_irq_by_fd(int fd);
 extern void deactivate_fd(int fd, int irqnum);
diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index f21dc8517538..00ca3e12fd9a 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -24,10 +24,12 @@ extern void free_stack(unsigned long stack, int order);
 struct pt_regs;
 extern void do_signal(struct pt_regs *regs);
 extern void interrupt_end(void);
-extern void relay_signal(int sig, struct siginfo *si, struct uml_pt_regs *regs);
+extern void relay_signal(int sig, struct siginfo *si, struct uml_pt_regs *regs,
+			 void *mc);
 
 extern unsigned long segv(struct faultinfo fi, unsigned long ip,
-			  int is_user, struct uml_pt_regs *regs);
+			  int is_user, struct uml_pt_regs *regs,
+			  void *mc);
 extern int handle_page_fault(unsigned long address, unsigned long ip,
 			     int is_write, int is_user, int *code_out);
 
@@ -59,8 +61,10 @@ extern unsigned long from_irq_stack(int nested);
 
 extern int singlestepping(void);
 
-extern void segv_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs);
-extern void winch(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs);
+extern void segv_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs,
+			 void *mc);
+extern void winch(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs,
+		  void *mc);
 extern void fatal_sigsegv(void) __attribute__ ((noreturn));
 
 void um_idle_sleep(void);
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 338450741aac..185664215814 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -236,7 +236,8 @@ static void _sigio_handler(struct uml_pt_regs *regs,
 		free_irqs();
 }
 
-void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
+void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs,
+		   void *mc)
 {
 	preempt_disable();
 	_sigio_handler(regs, irqs_suspended);
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index befed230aac2..05ffceb555b4 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -9,6 +9,8 @@
 #include <linux/mm.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
+#include <linux/init.h>
+#include <asm/sections.h>
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 #include <as-layout.h>
@@ -241,3 +243,11 @@ static const pgprot_t protection_map[16] = {
 	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_SHARED
 };
 DECLARE_VM_GET_PAGE_PROT
+
+void mark_rodata_ro(void)
+{
+	unsigned long rodata_start = PFN_ALIGN(__start_rodata);
+	unsigned long rodata_end = PFN_ALIGN(__end_rodata);
+
+	os_protect_memory((void *)rodata_start, rodata_end - rodata_start, 1, 0, 0);
+}
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index cdaee3e94273..ce073150dc20 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -16,6 +16,7 @@
 #include <kern_util.h>
 #include <os.h>
 #include <skas.h>
+#include <arch.h>
 
 /*
  * Note this is constrained to return 0, -EFAULT, -EACCES, -ENOMEM by
@@ -175,12 +176,14 @@ void fatal_sigsegv(void)
  * @sig:	the signal number
  * @unused_si:	the signal info struct; unused in this handler
  * @regs:	the ptrace register information
+ * @mc:		the mcontext of the signal
  *
  * The handler first extracts the faultinfo from the UML ptrace regs struct.
  * If the userfault did not happen in an UML userspace process, bad_segv is called.
  * Otherwise the signal did happen in a cloned userspace process, handle it.
  */
-void segv_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
+void segv_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs,
+		  void *mc)
 {
 	struct faultinfo * fi = UPT_FAULTINFO(regs);
 
@@ -189,7 +192,7 @@ void segv_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 		bad_segv(*fi, UPT_IP(regs));
 		return;
 	}
-	segv(*fi, UPT_IP(regs), UPT_IS_USER(regs), regs);
+	segv(*fi, UPT_IP(regs), UPT_IS_USER(regs), regs, mc);
 }
 
 /*
@@ -199,7 +202,7 @@ void segv_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
  * give us bad data!
  */
 unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
-		   struct uml_pt_regs *regs)
+		   struct uml_pt_regs *regs, void *mc)
 {
 	int si_code;
 	int err;
@@ -223,6 +226,19 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 		goto out;
 	}
 	else if (current->mm == NULL) {
+		if (current->pagefault_disabled) {
+			if (!mc) {
+				show_regs(container_of(regs, struct pt_regs, regs));
+				panic("Segfault with pagefaults disabled but no mcontext");
+			}
+			if (!current->thread.segv_continue) {
+				show_regs(container_of(regs, struct pt_regs, regs));
+				panic("Segfault without recovery target");
+			}
+			mc_set_rip(mc, current->thread.segv_continue);
+			current->thread.segv_continue = NULL;
+			goto out;
+		}
 		show_regs(container_of(regs, struct pt_regs, regs));
 		panic("Segfault with no mm");
 	}
@@ -274,7 +290,8 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 	return 0;
 }
 
-void relay_signal(int sig, struct siginfo *si, struct uml_pt_regs *regs)
+void relay_signal(int sig, struct siginfo *si, struct uml_pt_regs *regs,
+		  void *mc)
 {
 	int code, err;
 	if (!UPT_IS_USER(regs)) {
@@ -302,7 +319,8 @@ void relay_signal(int sig, struct siginfo *si, struct uml_pt_regs *regs)
 	}
 }
 
-void winch(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
+void winch(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs,
+	   void *mc)
 {
 	do_IRQ(WINCH_IRQ, regs);
 }
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 9ea7269ffb77..e71e5b4878d1 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -21,7 +21,7 @@
 #include <sys/ucontext.h>
 #include <timetravel.h>
 
-void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *) = {
+void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *, void *mc) = {
 	[SIGTRAP]	= relay_signal,
 	[SIGFPE]	= relay_signal,
 	[SIGILL]	= relay_signal,
@@ -47,7 +47,7 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 	if ((sig != SIGIO) && (sig != SIGWINCH))
 		unblock_signals_trace();
 
-	(*sig_info[sig])(sig, si, &r);
+	(*sig_info[sig])(sig, si, &r, mc);
 
 	errno = save_errno;
 }
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index f683cfc9e51a..2bd3d796bc55 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -166,7 +166,7 @@ static void get_skas_faultinfo(int pid, struct faultinfo *fi)
 static void handle_segv(int pid, struct uml_pt_regs *regs)
 {
 	get_skas_faultinfo(pid, &regs->faultinfo);
-	segv(regs->faultinfo, 0, 1, NULL);
+	segv(regs->faultinfo, 0, 1, NULL, NULL);
 }
 
 static void handle_trap(int pid, struct uml_pt_regs *regs)
@@ -515,7 +515,7 @@ void userspace(struct uml_pt_regs *regs)
 					get_skas_faultinfo(pid,
 							   &regs->faultinfo);
 					(*sig_info[SIGSEGV])(SIGSEGV, (struct siginfo *)&si,
-							     regs);
+							     regs, NULL);
 				}
 				else handle_segv(pid, regs);
 				break;
@@ -523,7 +523,7 @@ void userspace(struct uml_pt_regs *regs)
 				handle_trap(pid, regs);
 				break;
 			case SIGTRAP:
-				relay_signal(SIGTRAP, (struct siginfo *)&si, regs);
+				relay_signal(SIGTRAP, (struct siginfo *)&si, regs, NULL);
 				break;
 			case SIGALRM:
 				break;
@@ -533,7 +533,7 @@ void userspace(struct uml_pt_regs *regs)
 			case SIGFPE:
 			case SIGWINCH:
 				block_signals_trace();
-				(*sig_info[sig])(sig, (struct siginfo *)&si, regs);
+				(*sig_info[sig])(sig, (struct siginfo *)&si, regs, NULL);
 				unblock_signals_trace();
 				break;
 			default:
diff --git a/arch/x86/um/os-Linux/mcontext.c b/arch/x86/um/os-Linux/mcontext.c
index e80ab7d28117..d2f3a595b4ef 100644
--- a/arch/x86/um/os-Linux/mcontext.c
+++ b/arch/x86/um/os-Linux/mcontext.c
@@ -4,6 +4,7 @@
 #include <asm/ptrace.h>
 #include <sysdep/ptrace.h>
 #include <sysdep/mcontext.h>
+#include <arch.h>
 
 void get_regs_from_mc(struct uml_pt_regs *regs, mcontext_t *mc)
 {
@@ -31,3 +32,14 @@ void get_regs_from_mc(struct uml_pt_regs *regs, mcontext_t *mc)
 	regs->gp[CS / sizeof(unsigned long)] |= 3;
 #endif
 }
+
+void mc_set_rip(void *_mc, void *target)
+{
+	mcontext_t *mc = _mc;
+
+#ifdef __i386__
+	mc->gregs[REG_EIP] = (unsigned long)target;
+#else
+	mc->gregs[REG_RIP] = (unsigned long)target;
+#endif
+}
diff --git a/arch/x86/um/shared/sysdep/faultinfo_32.h b/arch/x86/um/shared/sysdep/faultinfo_32.h
index b6f2437ec29c..ab5c8e47049c 100644
--- a/arch/x86/um/shared/sysdep/faultinfo_32.h
+++ b/arch/x86/um/shared/sysdep/faultinfo_32.h
@@ -29,4 +29,16 @@ struct faultinfo {
 
 #define PTRACE_FULL_FAULTINFO 0
 
+#define ___backtrack_faulted(_faulted)					\
+	asm volatile (							\
+		"mov $0, %0\n"						\
+		"movl $__get_kernel_nofault_faulted_%=,%1\n"		\
+		"jmp _end_%=\n"						\
+		"__get_kernel_nofault_faulted_%=:\n"			\
+		"mov $1, %0;"						\
+		"_end_%=:"						\
+		: "=r" (_faulted),					\
+		  "=m" (current->thread.segv_continue) ::		\
+	)
+
 #endif
diff --git a/arch/x86/um/shared/sysdep/faultinfo_64.h b/arch/x86/um/shared/sysdep/faultinfo_64.h
index ee88f88974ea..26fb4835d3e9 100644
--- a/arch/x86/um/shared/sysdep/faultinfo_64.h
+++ b/arch/x86/um/shared/sysdep/faultinfo_64.h
@@ -29,4 +29,16 @@ struct faultinfo {
 
 #define PTRACE_FULL_FAULTINFO 1
 
+#define ___backtrack_faulted(_faulted)					\
+	asm volatile (							\
+		"mov $0, %0\n"						\
+		"movq $__get_kernel_nofault_faulted_%=,%1\n"		\
+		"jmp _end_%=\n"						\
+		"__get_kernel_nofault_faulted_%=:\n"			\
+		"mov $1, %0;"						\
+		"_end_%=:"						\
+		: "=r" (_faulted),					\
+		  "=m" (current->thread.segv_continue) ::		\
+	)
+
 #endif
-- 
2.48.1


