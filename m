Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6057DC27C53
	for <linux-um@archiver.kernel.org>; Wed, 12 Jun 2024 16:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r+d+FOolDhN243bZu3JialY3bClijATFuLLrMCW4LL8=; b=pKmmRmEAxeg9zDvRfT/RA+I0Op
	I3yA5ISLjbvW69ezzc5bfn0BHifZ8QVW+amK+Ud+drVE+xjye23UMzLWWmRk/wgfcTVn8NGBegDfX
	9jhLFfVf1zT1ARs1Szer19fydIbmWVVf/V6glHcbn2pueExGPxmzSMvnVckJeEkRZ+cNFOSA3efaS
	J7NHxrJD7C9e8DOQEKbZo2CnZBpkIHuBfkBxtic0anavdqsj/NtOIBPaeghb27ed3iARz80uDiwVB
	Z6ZLy06M3JH+4A2EXdZ8UH6yYlKNkhuzBhJ94NdfWvN0olCb9Bx/894Sw18l9l1HIKB54xQnKdbc6
	q6jAM65w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHR2h-0000000DPwT-0Gsv;
	Wed, 12 Jun 2024 16:41:47 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHR2b-0000000DPtE-37QU
	for linux-um@lists.infradead.org;
	Wed, 12 Jun 2024 16:41:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=r+d+FOolDhN243bZu3JialY3bClijATFuLLrMCW4LL8=;
	t=1718210501; x=1719420101; b=ghmbpS2y4RatTf1fnlUefQi0Lk2ka/fEr5WsWghwVYTQ12h
	cB9zulN5Fc9FgNfQ4TOUNBEWne/dbgjMpjcBS1NV3XlADg59GEVhyrzDYMbStiCJFLlnJQi+AKJpm
	aNlAm7RpEraHUuS0Ko4HfkD7mskHCo52F+7G789mB3BcB0/Avu8dRPY5EdjZaOnkaM2MSbP3qSr10
	umCX8I52rwpF+zMeHfklGBRzex4cYcdY18Dkh1U/eVqr9f6vxFtoG8rbVijS1zXmTXKHUxodqT3/9
	ZXUiZpV/Y0UdBVxpmujwtwB3qe1yzNMnNXFTJ9truM4s2Z5lTX5Iz7eavyszDH1A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sHR2Z-0000000AUQy-2rrA;
	Wed, 12 Jun 2024 18:41:40 +0200
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v4 3/5] um: Do a double clone to disable rseq
Date: Wed, 12 Jun 2024 18:41:06 +0200
Message-ID: <20240612164108.1742106-4-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240612164108.1742106-1-benjamin@sipsolutions.net>
References: <20240612164108.1742106-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_094141_816602_8C52CE7C 
X-CRM114-Status: GOOD (  17.50  )
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

v2: Improved clone logic using CLONE_VFORK
v3: Undo incorrect change in child wait loop
v4: Do not use WNOHANG in wait for CLONE_VFORK, this seems to fail on
    older host kernel versions.
---
 arch/um/os-Linux/skas/process.c | 53 ++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 41a288dcfc34..8fa2d06faef4 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -255,6 +255,32 @@ static int userspace_tramp(void *stack)
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
+	 * At this point we are still in the same VM as the parent, but rseq
+	 * has been disabled for this process.
+	 * Continue with the clone into the new userspace process, the kernel
+	 * continues as soon as this process quits (CLONE_VFORK).
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
@@ -268,9 +294,10 @@ int kill_userspace_mm[NR_CPUS];
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
@@ -286,10 +313,13 @@ int start_userspace(unsigned long stub_stack)
 	/* set stack pointer to the end of the stack page, so it can grow downwards */
 	sp = (unsigned long)stack + UM_KERN_PAGE_SIZE;
 
-	flags = CLONE_FILES | SIGCHLD;
+	tramp_data.stack = (void *) stub_stack;
+	tramp_data.clone_sp = (void *) sp;
+	tramp_data.pid = -EINVAL;
 
-	/* clone into new userspace process */
-	pid = clone(userspace_tramp, (void *) sp, flags, (void *) stub_stack);
+	/* first stage CLONE_VM clone using VFORK and no signal notification */
+	pid = clone(userspace_tramp_clone_vm, (void *) sp,
+		    CLONE_VM | CLONE_FILES | CLONE_VFORK, &tramp_data);
 	if (pid < 0) {
 		err = -errno;
 		printk(UM_KERN_ERR "%s : clone failed, errno = %d\n",
@@ -297,6 +327,21 @@ int start_userspace(unsigned long stub_stack)
 		return err;
 	}
 
+	CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED | __WALL));
+	if (n < 0 || !WIFEXITED(status) || WEXITSTATUS(status)) {
+		err = -errno;
+		printk(UM_KERN_ERR "%s : wait failed, errno = %d, status = %d\n",
+		       __func__, n < 0 ? errno : 0, status);
+		goto out_kill;
+	}
+
+	pid = tramp_data.pid;
+	if (pid < 0) {
+		printk(UM_KERN_ERR "%s : second clone failed, errno = %d\n",
+		       __func__, -pid);
+		return pid;
+	}
+
 	do {
 		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED | __WALL));
 		if (n < 0) {
-- 
2.45.1


