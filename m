Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2E9C47422
	for <linux-um@archiver.kernel.org>; Wed, 24 Jan 2024 14:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nYZ2eRWQny82g5Pr6AKuxeAsA2uyuPGDCypHfd+ahG0=; b=OkNFA2fbff2WwL6YsxUa+OukhD
	G8gd/BVZNqRb0c7Nf8cwCVl0XfywiGeYrbfYPZGb1eWQsM3Dyqvvo1QlPDuA3N9JCRpTB/GOhb7i+
	Z5e5SNhdoUXH1AKEvPz3wY48qshIK1jjmAkyM/F/xU5/RvE+/HvQKQ6bp42GLUYikTxFl8uZkR4su
	X2QYY9dSloRqfwaEnzP1Rj+Q4PP565Xb4OLpccKW8iTzJvwQ6gbNjgn2TFJ6oWv5sI3YFtTLx+Lo+
	TqTD0K+hM+yxFkNCi0W5T77Wjy2zpUI+rxbUNP/15BW+dUdTSEnTZ5PiZVfMdzzGD7auGNg8V1RM5
	nM84HZvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSeHF-003gNz-1F;
	Wed, 24 Jan 2024 14:30:53 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSeHB-003gLO-1i
	for linux-um@lists.infradead.org;
	Wed, 24 Jan 2024 14:30:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 53FF6CE3164;
	Wed, 24 Jan 2024 14:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF642C43399;
	Wed, 24 Jan 2024 14:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106633;
	bh=soGe+VZ3hewFWpaTCT4rz5IfWkdxsKffPEpeTNY9etw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DCOMK4sAMOTVTWg8MYE4cSg432tbUbbsOsP0bM6fK/09A0F3CWP6oE12krlcV3Xcw
	 S9OXLQfgHWrG/YR4Aw5anWtdrBsOVXgsgKQx6cGADfBNxqKqoF/XByDQsXr0E56KNx
	 +yair3l/+dwXVdeovAmOU/LXw3YzWBoO3v3+t9Wt2kGBcrUyfZsKSz7omQpkQgQ2AR
	 umqUQVjF1FKptNZ29NKnoJq8vqxCfWii5BTevPdflrTgRaunF2uSiBq4Zx5yrVHqM/
	 QfiC5s96ELkyB2aL4i8oSqY1+k+0qaXuHq1yANZ2jhsXvfkrlmk1FnGqBZzpkePwCs
	 UoL1aWk+c3TuQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Peter Lafreniere <peter@n8pjl.ca>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	benjamin@sipsolutions.net,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 2/9] um: Fix naming clash between UML and scheduler
Date: Wed, 24 Jan 2024 09:30:05 -0500
Message-ID: <20240124143024.1284046-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124143024.1284046-1-sashal@kernel.org>
References: <20240124143024.1284046-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_063049_919901_903A0A84 
X-CRM114-Status: GOOD (  11.35  )
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

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

[ Upstream commit 541d4e4d435c8b9bfd29f70a1da4a2db97794e0a ]

__cant_sleep was already used and exported by the scheduler.
The name had to be changed to a UML specific one.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Reviewed-by: Peter Lafreniere <peter@n8pjl.ca>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/include/shared/kern_util.h | 2 +-
 arch/um/kernel/process.c           | 2 +-
 arch/um/os-Linux/helper.c          | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index a2cfd42608a0..cb798a50e8cf 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -50,7 +50,7 @@ extern void do_uml_exitcalls(void);
  * Are we disallowed to sleep? Used to choose between GFP_KERNEL and
  * GFP_ATOMIC.
  */
-extern int __cant_sleep(void);
+extern int __uml_cant_sleep(void);
 extern int get_current_pid(void);
 extern int copy_from_user_proc(void *to, void *from, int size);
 extern int cpu(void);
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index b3fbfca49400..4b6179a8a3e8 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -218,7 +218,7 @@ void arch_cpu_idle(void)
 	raw_local_irq_enable();
 }
 
-int __cant_sleep(void) {
+int __uml_cant_sleep(void) {
 	return in_atomic() || irqs_disabled() || in_interrupt();
 	/* Is in_interrupt() really needed? */
 }
diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
index 32e88baf18dd..4e429a41565c 100644
--- a/arch/um/os-Linux/helper.c
+++ b/arch/um/os-Linux/helper.c
@@ -45,7 +45,7 @@ int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv)
 	unsigned long stack, sp;
 	int pid, fds[2], ret, n;
 
-	stack = alloc_stack(0, __cant_sleep());
+	stack = alloc_stack(0, __uml_cant_sleep());
 	if (stack == 0)
 		return -ENOMEM;
 
@@ -69,7 +69,7 @@ int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv)
 	data.pre_data = pre_data;
 	data.argv = argv;
 	data.fd = fds[1];
-	data.buf = __cant_sleep() ? uml_kmalloc(PATH_MAX, UM_GFP_ATOMIC) :
+	data.buf = __uml_cant_sleep() ? uml_kmalloc(PATH_MAX, UM_GFP_ATOMIC) :
 					uml_kmalloc(PATH_MAX, UM_GFP_KERNEL);
 	pid = clone(helper_child, (void *) sp, CLONE_VM, &data);
 	if (pid < 0) {
@@ -116,7 +116,7 @@ int run_helper_thread(int (*proc)(void *), void *arg, unsigned int flags,
 	unsigned long stack, sp;
 	int pid, status, err;
 
-	stack = alloc_stack(0, __cant_sleep());
+	stack = alloc_stack(0, __uml_cant_sleep());
 	if (stack == 0)
 		return -ENOMEM;
 
-- 
2.43.0


