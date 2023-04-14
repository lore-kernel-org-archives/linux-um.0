Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31A9C77B6E
	for <linux-um@archiver.kernel.org>; Fri, 14 Apr 2023 13:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=zM8l8b8MvaIpFtH5eyGt5mx2wMMrYe6RdDS4NOH/LK4=; b=Q0jij2GHfYETe4
	dTFvboSzAVj4ySxD7+a3xZH1WrjihLloU8wzqSTp3ki3JJpeRUCrRpKrBrjOaBPKdq8GQissdjtbY
	pNOfNqyztk2L86uQXAwewt7jyH0KrGXO/ldh5GtOWDexHWtrRAbhhEdlQtg/gFbRnoJ4LZWe8cYh9
	X/J1QGFigQbpWjk1paQB990s93SJ8tHxMoUH1T7JULDXv6UNFdjkm/fHnB5CN89joKSYjzcCDLlJ/
	EmEkFpsWi+n8OxA6uUNHGf+o2mqrkz4y75ajDDekdtgqWtsnXWLzRmMpsburFkLDHy8Fhn73pd7ji
	arNK2njkEWj3MVRfp+WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pnJlP-009i5z-0C;
	Fri, 14 Apr 2023 13:46:55 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pnJlK-009i59-2j
	for linux-um@lists.infradead.org;
	Fri, 14 Apr 2023 13:46:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=UEY7hViUFn5NoyYV907Ia+BGfbwwa37aM0YX9IkxgJI=; t=1681480007; x=1682689607; 
	b=SySux0uJLFgm4CMT9d/hW7S3wv4ECrc4NHyDIviMCKa+2zxn1tpBfSCXNIPJOeXxniBh/AXEjh8
	h1zLMUQIiIQMdZvobZXHHNWMpFDkl2I7+JpEVBGclcWiwaopEE3GyDFKozTQ0pBCJaevTQrNQiUba
	etyh171odAoHzJ2JDMvza4xUdjxClc2HFab5I1oSDyHKvYB8SFpTFABxQEisWPEGqTQhbfstPaVNi
	hqyBvbx9auqbb42rXZ/oUDTgrhSQgDrT5j69lfNRb3ufB+ViKAWRFvDz2fZNQaLSawattG3/jVToh
	FiS77bfuFkM6nKUTUv/Anb58TGLxO0+cnqyQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1pnJlD-00Fbwu-0B;
	Fri, 14 Apr 2023 15:46:43 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] um: make stub data pages size tweakable
Date: Fri, 14 Apr 2023 15:46:39 +0200
Message-Id: <20230414154639.d1fa722b8010.I611134b2783b65662e0584d373dc4c343f5d751d@changeid>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230414_064651_066047_2513FA41 
X-CRM114-Status: GOOD (  21.17  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Johannes Berg <johannes.berg@intel.com>

There's a lot of code here that hard-codes that the
data is a single page, and right now that seems to
be sufficient, but to make it easier to change this
in the future, add a new STUB_DATA_PAGES constant
and use it throughout the code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
Note the seccomp patchset contained something similar,
with a different rationale:
https://patchwork.ozlabs.org/project/linux-um/patch/20221122100759.208290-16-benjamin@sipsolutions.net/

However this is broken in a few places, e.g. 32-bit
and the lack of alignment, so we should probably do
this first correctly and then do seccomp again on top.
---
 arch/um/include/shared/as-layout.h  |  3 ++-
 arch/um/kernel/skas/clone.c         |  5 +++--
 arch/um/kernel/skas/mmu.c           |  6 +++---
 arch/um/kernel/um_arch.c            | 10 +++++++---
 arch/um/os-Linux/skas/process.c     |  6 +++---
 arch/x86/um/shared/sysdep/stub_32.h |  8 ++++----
 arch/x86/um/shared/sysdep/stub_64.h |  8 ++++----
 arch/x86/um/stub_segv.c             |  2 +-
 8 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/arch/um/include/shared/as-layout.h b/arch/um/include/shared/as-layout.h
index 9a0bd648d872..9ec3015bc5e2 100644
--- a/arch/um/include/shared/as-layout.h
+++ b/arch/um/include/shared/as-layout.h
@@ -23,7 +23,8 @@
 #define STUB_START stub_start
 #define STUB_CODE STUB_START
 #define STUB_DATA (STUB_CODE + UM_KERN_PAGE_SIZE)
-#define STUB_END (STUB_DATA + UM_KERN_PAGE_SIZE)
+#define STUB_DATA_PAGES 1 /* must be a power of two */
+#define STUB_END (STUB_DATA + STUB_DATA_PAGES * UM_KERN_PAGE_SIZE)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/um/kernel/skas/clone.c b/arch/um/kernel/skas/clone.c
index ff5061f29167..62435187dda4 100644
--- a/arch/um/kernel/skas/clone.c
+++ b/arch/um/kernel/skas/clone.c
@@ -24,11 +24,12 @@
 void __attribute__ ((__section__ (".__syscall_stub")))
 stub_clone_handler(void)
 {
-	struct stub_data *data = get_stub_page();
+	struct stub_data *data = get_stub_data();
 	long err;
 
 	err = stub_syscall2(__NR_clone, CLONE_PARENT | CLONE_FILES | SIGCHLD,
-			    (unsigned long)data + UM_KERN_PAGE_SIZE / 2);
+			    (unsigned long)data +
+				STUB_DATA_PAGES * UM_KERN_PAGE_SIZE / 2);
 	if (err) {
 		data->parent_err = err;
 		goto done;
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 125df465e8ea..656fe16c9b63 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -21,7 +21,7 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 	unsigned long stack = 0;
 	int ret = -ENOMEM;
 
-	stack = get_zeroed_page(GFP_KERNEL);
+	stack = __get_free_pages(GFP_KERNEL | __GFP_ZERO, ilog2(STUB_DATA_PAGES));
 	if (stack == 0)
 		goto out;
 
@@ -52,7 +52,7 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 
  out_free:
 	if (to_mm->id.stack != 0)
-		free_page(to_mm->id.stack);
+		free_pages(to_mm->id.stack, ilog2(STUB_DATA_PAGES));
  out:
 	return ret;
 }
@@ -74,6 +74,6 @@ void destroy_context(struct mm_struct *mm)
 	}
 	os_kill_ptraced_process(mmu->id.u.pid, 1);
 
-	free_page(mmu->id.stack);
+	free_pages(mmu->id.stack, ilog2(STUB_DATA_PAGES));
 	free_ldt(mmu);
 }
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 8dcda617b8bf..0a23a98d4ca0 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -326,9 +326,13 @@ int __init linux_main(int argc, char **argv)
 		add_arg(DEFAULT_COMMAND_LINE_CONSOLE);
 
 	host_task_size = os_get_top_address();
-	/* reserve two pages for the stubs */
-	host_task_size -= 2 * PAGE_SIZE;
-	stub_start = host_task_size;
+	/* reserve a few pages for the stubs (taking care of data alignment) */
+	/* align the data portion */
+	BUILD_BUG_ON(!is_power_of_2(STUB_DATA_PAGES));
+	stub_start = (host_task_size - 1) & ~(STUB_DATA_PAGES * PAGE_SIZE - 1);
+	/* another page for the code portion */
+	stub_start -= PAGE_SIZE;
+	host_task_size = stub_start;
 
 	/*
 	 * TASK_SIZE needs to be PGDIR_SIZE aligned or else exit_mmap craps
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 810e27c94c09..d46f62223b45 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -263,7 +263,7 @@ static int userspace_tramp(void *stack)
 	if (stack != NULL) {
 		fd = phys_mapping(uml_to_phys(stack), &offset);
 		addr = mmap((void *) STUB_DATA,
-			    UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
+			    STUB_DATA_PAGES * UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
 			    MAP_FIXED | MAP_SHARED, fd, offset);
 		if (addr == MAP_FAILED) {
 			printk(UM_KERN_ERR "mapping segfault stack at 0x%lx failed, errno = %d\n",
@@ -278,7 +278,7 @@ static int userspace_tramp(void *stack)
 				  (unsigned long) stub_segv_handler -
 				  (unsigned long) __syscall_stub_start;
 
-		set_sigstack((void *) STUB_DATA, UM_KERN_PAGE_SIZE);
+		set_sigstack((void *) STUB_DATA, STUB_DATA_PAGES * UM_KERN_PAGE_SIZE);
 		sigemptyset(&sa.sa_mask);
 		sa.sa_flags = SA_ONSTACK | SA_NODEFER | SA_SIGINFO;
 		sa.sa_sigaction = (void *) v;
@@ -518,7 +518,7 @@ static int __init init_thread_regs(void)
 	thread_regs[REGS_IP_INDEX] = STUB_CODE +
 				(unsigned long) stub_clone_handler -
 				(unsigned long) __syscall_stub_start;
-	thread_regs[REGS_SP_INDEX] = STUB_DATA + UM_KERN_PAGE_SIZE -
+	thread_regs[REGS_SP_INDEX] = STUB_DATA + STUB_DATA_PAGES * UM_KERN_PAGE_SIZE -
 		sizeof(void *);
 #ifdef __SIGNAL_FRAMESIZE
 	thread_regs[REGS_SP_INDEX] -= __SIGNAL_FRAMESIZE;
diff --git a/arch/x86/um/shared/sysdep/stub_32.h b/arch/x86/um/shared/sysdep/stub_32.h
index 4c6c2be0c899..38fa894b65d0 100644
--- a/arch/x86/um/shared/sysdep/stub_32.h
+++ b/arch/x86/um/shared/sysdep/stub_32.h
@@ -89,19 +89,19 @@ static inline void remap_stack_and_trap(void)
 		"addl %4,%%ebx ; movl %%eax, (%%ebx) ;"
 		"int $3"
 		: :
-		"g" (~(UM_KERN_PAGE_SIZE - 1)),
+		"g" (~(STUB_DATA_PAGES * UM_KERN_PAGE_SIZE - 1)),
 		"g" (STUB_MMAP_NR),
 		"g" (UML_STUB_FIELD_FD),
 		"g" (UML_STUB_FIELD_OFFSET),
 		"g" (UML_STUB_FIELD_CHILD_ERR),
-		"c" (UM_KERN_PAGE_SIZE),
+		"c" (STUB_DATA_PAGES * UM_KERN_PAGE_SIZE),
 		"d" (PROT_READ | PROT_WRITE),
 		"S" (MAP_FIXED | MAP_SHARED)
 		:
 		"memory");
 }
 
-static __always_inline void *get_stub_page(void)
+static __always_inline void *get_stub_data(void)
 {
 	unsigned long ret;
 
@@ -109,7 +109,7 @@ static __always_inline void *get_stub_page(void)
 		"movl %%esp,%0 ;"
 		"andl %1,%0"
 		: "=a" (ret)
-		: "g" (~(UM_KERN_PAGE_SIZE - 1)));
+		: "g" (~(STUB_DATA_PAGES * UM_KERN_PAGE_SIZE - 1)));
 
 	return (void *)ret;
 }
diff --git a/arch/x86/um/shared/sysdep/stub_64.h b/arch/x86/um/shared/sysdep/stub_64.h
index 92ea1670cf1c..2de1c8f88173 100644
--- a/arch/x86/um/shared/sysdep/stub_64.h
+++ b/arch/x86/um/shared/sysdep/stub_64.h
@@ -98,18 +98,18 @@ static inline void remap_stack_and_trap(void)
 		"int3"
 		: :
 		"g" (STUB_MMAP_NR),
-		"g" (~(UM_KERN_PAGE_SIZE - 1)),
+		"g" (~(STUB_DATA_PAGES * UM_KERN_PAGE_SIZE - 1)),
 		"g" (MAP_FIXED | MAP_SHARED),
 		"g" (UML_STUB_FIELD_FD),
 		"g" (UML_STUB_FIELD_OFFSET),
 		"g" (UML_STUB_FIELD_CHILD_ERR),
-		"S" (UM_KERN_PAGE_SIZE),
+		"S" (STUB_DATA_PAGES * UM_KERN_PAGE_SIZE),
 		"d" (PROT_READ | PROT_WRITE)
 		:
 		__syscall_clobber, "r10", "r8", "r9");
 }
 
-static __always_inline void *get_stub_page(void)
+static __always_inline void *get_stub_data(void)
 {
 	unsigned long ret;
 
@@ -117,7 +117,7 @@ static __always_inline void *get_stub_page(void)
 		"movq %%rsp,%0 ;"
 		"andq %1,%0"
 		: "=a" (ret)
-		: "g" (~(UM_KERN_PAGE_SIZE - 1)));
+		: "g" (~(STUB_DATA_PAGES * UM_KERN_PAGE_SIZE - 1)));
 
 	return (void *)ret;
 }
diff --git a/arch/x86/um/stub_segv.c b/arch/x86/um/stub_segv.c
index f7eefba034f9..040668b989b5 100644
--- a/arch/x86/um/stub_segv.c
+++ b/arch/x86/um/stub_segv.c
@@ -11,7 +11,7 @@
 void __attribute__ ((__section__ (".__syscall_stub")))
 stub_segv_handler(int sig, siginfo_t *info, void *p)
 {
-	struct faultinfo *f = get_stub_page();
+	struct faultinfo *f = get_stub_data();
 	ucontext_t *uc = p;
 
 	GET_FAULTINFO_FROM_MC(*f, &uc->uc_mcontext);
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
