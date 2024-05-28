Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F0AC25B7E
	for <linux-um@archiver.kernel.org>; Tue, 28 May 2024 08:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wi2Xld7h/j0VXvio5/oyj4J7kJTuo4AEFW3Ce6k+E28=; b=yPrwTJXAHy3TCi2i95Ll/644XS
	KYlaO7WaFtbqcZvvSICmG8YdzSudK0Up/tXfs7mMrnHBzRo0PeHyTj2fl7jqQeH7vKLiqTVxPimdY
	+VhrEIFWZOFwsyBQ1878MRAVPJor8e7wuxdfU6jtAbUaqi8frFPaO12fchy0Q4GgvZec2q6vA+pS9
	xbpPEmZxWhy2p8j3sBiUSB4Fe/8DEVZ2EuENL0D35n/U8b4mka1QNp4OxordRIbt77CXjx+3UMZwG
	UUcmtUKangQr5zwjICeysyhuV8vnd8JZRDjspZT14bt3fUSr99UievSz+jtk0EULqToB5/1JmXa0b
	9z/3MzBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBsbT-0000000HY6D-0BFR;
	Tue, 28 May 2024 08:54:43 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBsbQ-0000000HY4o-0uVA
	for linux-um@lists.infradead.org;
	Tue, 28 May 2024 08:54:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=wi2Xld7h/j0VXvio5/oyj4J7kJTuo4AEFW3Ce6k+E28=;
	t=1716886480; x=1718096080; b=P13zEp10MO5n8TeMAmvsbEcG8pg2hmaGPW+Ocoru895anQW
	tCuQS4YkBFMn9gKriJhgIYNtpmvh+onFQkRqjPafOM+/qJAe6Wjt9Gs2sqi61QqPLQWWYQWjGmhF+
	t2AFQweWH252RV4DcbzzQ/8yMxqY7iQEHT2NsoZfYZGXFEnIQl9yyB6zmx62hTxUcEk2BTdNPtqvz
	LjrG6tJilPPFYacmVEMDklMTPYONG9Xo1Y5sxCaQjTMCOzuHYf99lKMRckWeplk1Dvt4ky5onIYJ/
	Ax8zDNkLiEOGkugCTcyqvcDdl2tvMGYg5+5sgRJFILrYXEEo+KqAg2e/9YHWM9cQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sBsbN-0000000EAlo-0dfv;
	Tue, 28 May 2024 10:54:38 +0200
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 3/5] um: Do a double clone to disable rseq
Date: Tue, 28 May 2024 10:54:17 +0200
Message-ID: <20240528085419.1964424-4-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528085419.1964424-1-benjamin@sipsolutions.net>
References: <20240528085419.1964424-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240528_015440_286378_D0C22E1B 
X-CRM114-Status: GOOD (  17.25  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

Newer glibc versions are enabling rseq support by default. This remains
enabled in the cloned child process, potentially causing the host kernel
to write/read memory in the child.

It appears that this was purely not an issue because the used memory
area happened to be above TASK_SIZE and remains mapped.

Note that a better approach would be to exec a small static binary that
does not link with other libraries. Using a memfd and execveat the
binary could be embedded into UML itself and it would result in an
entirely clean execution environment for userspace.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/os-Linux/skas/process.c | 54 ++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 41a288dcfc34..ee332a2aeea6 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -255,6 +255,31 @@ static int userspace_tramp(void *stack)
 int userspace_pid[NR_CPUS];
 int kill_userspace_mm[NR_CPUS];
 
+struct tramp_data {
+	int pid;
+	void *clone_sp;
+	void *stack;
+};
+
+static int userspace_tramp_clone_vm(void *data)
+{
+	struct tramp_data *tramp_data = data;
+
+	/*
+	 * This helper exist to do a double-clone. First with CLONE_VM which
+	 * effectively disables things like rseq, and then the second one to
+	 * get a new memory space.
+	 */
+
+	tramp_data->pid = clone(userspace_tramp, tramp_data->clone_sp,
+				CLONE_PARENT | CLONE_FILES | SIGCHLD,
+				tramp_data->stack);
+	if (tramp_data->pid < 0)
+		tramp_data->pid = -errno;
+
+	exit(0);
+}
+
 /**
  * start_userspace() - prepare a new userspace process
  * @stub_stack:	pointer to the stub stack.
@@ -268,9 +293,10 @@ int kill_userspace_mm[NR_CPUS];
  */
 int start_userspace(unsigned long stub_stack)
 {
+	struct tramp_data tramp_data;
 	void *stack;
 	unsigned long sp;
-	int pid, status, n, flags, err;
+	int pid, status, n, err;
 
 	/* setup a temporary stack page */
 	stack = mmap(NULL, UM_KERN_PAGE_SIZE,
@@ -286,10 +312,13 @@ int start_userspace(unsigned long stub_stack)
 	/* set stack pointer to the end of the stack page, so it can grow downwards */
 	sp = (unsigned long)stack + UM_KERN_PAGE_SIZE;
 
-	flags = CLONE_FILES | SIGCHLD;
+	tramp_data.stack = (void *) stub_stack;
+	tramp_data.clone_sp = (void *) sp;
+	tramp_data.pid = -EINVAL;
 
 	/* clone into new userspace process */
-	pid = clone(userspace_tramp, (void *) sp, flags, (void *) stub_stack);
+	pid = clone(userspace_tramp_clone_vm, (void *) sp,
+		    CLONE_VM | CLONE_FILES | SIGCHLD, &tramp_data);
 	if (pid < 0) {
 		err = -errno;
 		printk(UM_KERN_ERR "%s : clone failed, errno = %d\n",
@@ -305,7 +334,24 @@ int start_userspace(unsigned long stub_stack)
 			       __func__, errno);
 			goto out_kill;
 		}
-	} while (WIFSTOPPED(status) && (WSTOPSIG(status) == SIGALRM));
+	} while (!WIFEXITED(status));
+
+	pid = tramp_data.pid;
+	if (pid < 0) {
+		printk(UM_KERN_ERR "%s : second clone failed, errno = %d\n",
+		       __func__, -pid);
+		return pid;
+	}
+
+	do {
+		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED | __WALL));
+		if (n < 0) {
+			err = -errno;
+			printk(UM_KERN_ERR "%s : wait failed, errno = %d\n",
+			       __func__, errno);
+			goto out_kill;
+		}
+	} while (WIFEXITED(status) && (WSTOPSIG(status) == SIGALRM));
 
 	if (!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGSTOP)) {
 		err = -EINVAL;
-- 
2.45.1


