Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5936C4332F
	for <linux-um@archiver.kernel.org>; Tue, 22 Nov 2022 10:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KYTejbUBlcL5B4bhUiWERNq/tt6F5mLLmNK4lGx1jXs=; b=WEvrNyU+J49LpN
	01cIgTXSykPTwYwdKqIffuaavIjngnl7sfhVUxHX/gPlUtELFj8SWNH1cbhZ/LObWWiZrTinzfRlJ
	rMgorfNyLzr2hphoYcdqMd/NYk4B2T4m5ii7rCjKSpqcF+1Yx9HbWnkaBt1MVAhdDyszWRgrFkQWJ
	MjvBD16m/aR+/3w8+7wsVsuFe0sc8M+hmSfJrWo1L+lGSKJobpbrske+w9yKZa5PQH6N8uYCfwKZc
	9fwZGJQ19DA1h09zjRF8o4e9bk+D8HRXf/nn8ph9hLNqjY4v/aZ6vq7IbQXLQ2NL5VP5cFaQ2KglF
	0CxjenPq2gee3c5w40sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQFF-007fsk-LS; Tue, 22 Nov 2022 10:11:13 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQF0-007fex-Cp
	for linux-um@lists.infradead.org; Tue, 22 Nov 2022 10:11:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=av462UGKtsinCGwk7vjoqMbYuXdvAp3qQw5EhZxOO5A=;
	t=1669111856; x=1670321456; b=hIdPrxeULpYRmECpQFpm3bJcoQnV41A+Dov6APCYxKrbe4l
	Ik9zRQ4VEaFkG5yI2AxQRRdz5OnLSSytestWUtw4UBPt5X0IKKReEbmSA3cut46xzFvCpLd4JW91x
	IM6l4WGEBvH7fin8FfrLEGRsoeVvAif0h5c0wkEZoctrncyCJ0lBW4C1lS4RfWerEPJKwFxRI9igO
	GeKpEuWx1GP4xo+18pmgSMMyDomCMbg1JGf+wSQxyXWkMVJZoervQYZpZkzmNElKzLJ2wZ071sCSq
	dx4DZeB/uKTso3nOIK19KgnBw9ZwlAXGbgYUtoIpJLAEeR9gZ8VFNPMPxtY2DOSA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1oxQEn-006IGn-0I;
	Tue, 22 Nov 2022 11:10:45 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v2 04/28] um: Drop NULL check from start_userspace
Date: Tue, 22 Nov 2022 11:07:35 +0100
Message-Id: <20221122100759.208290-5-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122100759.208290-1-benjamin@sipsolutions.net>
References: <20221122100759.208290-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_021058_881595_4C7E6FC2 
X-CRM114-Status: GOOD (  12.86  )
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
index 11278c30a82d..90db8add1231 100644
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
-			    UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
-			    MAP_FIXED | MAP_SHARED, fd, offset);
-		if (addr == MAP_FAILED) {
-			printk(UM_KERN_ERR "mapping segfault stack at 0x%lx failed, errno = %d\n",
-			       STUB_DATA, errno);
-			exit(1);
-		}
+	fd = phys_mapping(uml_to_phys(stack), &offset);
+	addr = mmap((void *) STUB_DATA,
+		    UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
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
-		set_sigstack((void *) STUB_DATA, UM_KERN_PAGE_SIZE);
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
+	set_sigstack((void *) STUB_DATA, UM_KERN_PAGE_SIZE);
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
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
