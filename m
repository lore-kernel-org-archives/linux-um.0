Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1C0C4167B
	for <linux-um@archiver.kernel.org>; Fri, 10 Nov 2023 11:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NlNaL2kShNmariBRYZWGmseLNgBPJJi+PuXmpZddoX8=; b=fMY7zyo0dSDwzb
	zfmSfG4R8bkhE2RH6cknfr6kOxtIr0qk4OmfwUAtQum0ro8W6O37briRe0xUucRMcywMwD6ZsbWCp
	Djao/bdHp7KIKhEEim2zUcfF8FRVpwjF8HVr4te6efi4sN1kCH6Z7NghXhc5r808iJXNKGp9JoF61
	pXfNHX9ZcviFmbP1hAeXlZws3UTywIbk3KFJpI15kZdVTQmoZBlme/vgpPKGiqOHP5u1Ps1153S0b
	X/ez2uD/DX5TuOyI4JCHDk5LPABIhJTEu5jRI/pcSmzlf3LvTuqmMDfL8YXnhIVY4gJgb2n8oVVQn
	U8FcX15jLpeOAZl9LBow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1PJJ-008Lzn-2P;
	Fri, 10 Nov 2023 11:04:25 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1PJF-008LuT-2o
	for linux-um@lists.infradead.org;
	Fri, 10 Nov 2023 11:04:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kexc/K+Nq5HRFzt+yhj0sNP4mY71RwwML0Sl9qXIlEk=;
	t=1699614261; x=1700823861; b=uoVCDKGdLZE6jzLe0uu+aT12Yx+VDSkznXYr+zylxpaTPLU
	ueia/cfIEI0cwDgIOWMUwlZNh5DngNtBfNp7ENQeVyrpgRQJ2CL+8ek9NJZ2R1hovfEg0oeDPt7cy
	xu1gKtgpqxHIknFZSxcOTaA+uJCioJE3cs7QEAb092HbLhMTn6t/y0yGIvthTULVfiF6L+zMzyZGw
	JcSeLsz0ePAWNW4CP2RWz3TOTguZJOKn/cUz/7I1iLDsX4CnbvjOiPBQBcsfo5R3e0sCwMjX7WytO
	U3ZTKOQU4h7wEift9slRolQ62LqxQ/GQzPYrRrDzB0+Tz0SRmgMUo3vXOOhVfjMg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1r1PJ7-00000002xHc-25Uv;
	Fri, 10 Nov 2023 12:04:14 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v3 02/11] um: Drop NULL check from start_userspace
Date: Fri, 10 Nov 2023 12:03:39 +0100
Message-ID: <20231110110348.1815612-3-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231110110348.1815612-1-benjamin@sipsolutions.net>
References: <20231110110348.1815612-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_030421_966983_0924ED83 
X-CRM114-Status: GOOD (  13.32  )
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

From: Benjamin Berg <benjamin@sipsolutions.net>

start_userspace is only called from exactly one location, and the passed
pointer for the userspace process stack cannot be NULL.

Remove the check, without changing the control flow.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/os-Linux/skas/process.c | 53 +++++++++++++++------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 43168c51850c..ed20cefb2963 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -189,7 +189,7 @@ extern char __syscall_stub_start[];
 
 /**
  * userspace_tramp() - userspace trampoline
- * @stack:	pointer to the new userspace stack page, can be NULL, if? FIXME:
+ * @stack:	pointer to the new userspace stack page
  *
  * The userspace trampoline is used to setup a new userspace process in start_userspace() after it was clone()'ed.
  * This function will run on a temporary stack page.
@@ -204,9 +204,13 @@ extern char __syscall_stub_start[];
  */
 static int userspace_tramp(void *stack)
 {
+	struct sigaction sa;
 	void *addr;
 	int fd;
 	unsigned long long offset;
+	unsigned long segv_handler = STUB_CODE +
+				     (unsigned long) stub_segv_handler -
+				     (unsigned long) __syscall_stub_start;
 
 	ptrace(PTRACE_TRACEME, 0, 0, 0);
 
@@ -222,34 +226,25 @@ static int userspace_tramp(void *stack)
 		exit(1);
 	}
 
-	if (stack != NULL) {
-		fd = phys_mapping(uml_to_phys(stack), &offset);
-		addr = mmap((void *) STUB_DATA,
-			    STUB_DATA_PAGES * UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
-			    MAP_FIXED | MAP_SHARED, fd, offset);
-		if (addr == MAP_FAILED) {
-			printk(UM_KERN_ERR "mapping segfault stack at 0x%lx failed, errno = %d\n",
-			       STUB_DATA, errno);
-			exit(1);
-		}
+	fd = phys_mapping(uml_to_phys(stack), &offset);
+	addr = mmap((void *) STUB_DATA,
+		    STUB_DATA_PAGES * UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
+		    MAP_FIXED | MAP_SHARED, fd, offset);
+	if (addr == MAP_FAILED) {
+		printk(UM_KERN_ERR "mapping segfault stack at 0x%lx failed, errno = %d\n",
+		       STUB_DATA, errno);
+		exit(1);
 	}
-	if (stack != NULL) {
-		struct sigaction sa;
-
-		unsigned long v = STUB_CODE +
-				  (unsigned long) stub_segv_handler -
-				  (unsigned long) __syscall_stub_start;
-
-		set_sigstack((void *) STUB_DATA, STUB_DATA_PAGES * UM_KERN_PAGE_SIZE);
-		sigemptyset(&sa.sa_mask);
-		sa.sa_flags = SA_ONSTACK | SA_NODEFER | SA_SIGINFO;
-		sa.sa_sigaction = (void *) v;
-		sa.sa_restorer = NULL;
-		if (sigaction(SIGSEGV, &sa, NULL) < 0) {
-			printk(UM_KERN_ERR "%s - setting SIGSEGV handler failed - errno = %d\n",
-			       __func__, errno);
-			exit(1);
-		}
+
+	set_sigstack((void *) STUB_DATA, STUB_DATA_PAGES * UM_KERN_PAGE_SIZE);
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = SA_ONSTACK | SA_NODEFER | SA_SIGINFO;
+	sa.sa_sigaction = (void *) segv_handler;
+	sa.sa_restorer = NULL;
+	if (sigaction(SIGSEGV, &sa, NULL) < 0) {
+		printk(UM_KERN_ERR "%s - setting SIGSEGV handler failed - errno = %d\n",
+		       __func__, errno);
+		exit(1);
 	}
 
 	kill(os_getpid(), SIGSTOP);
@@ -261,7 +256,7 @@ int kill_userspace_mm[NR_CPUS];
 
 /**
  * start_userspace() - prepare a new userspace process
- * @stub_stack:	pointer to the stub stack. Can be NULL, if? FIXME:
+ * @stub_stack:	pointer to the stub stack.
  *
  * Setups a new temporary stack page that is used while userspace_tramp() runs
  * Clones the kernel process into a new userspace process, with FDs only.
-- 
2.41.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
